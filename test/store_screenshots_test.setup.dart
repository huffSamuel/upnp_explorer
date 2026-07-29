import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upnp_explorer/application/changelog/changelog_service.dart';
import 'package:upnp_explorer/application/flavors/google/google_features.dart';
import 'package:upnp_explorer/application/ioc.dart';
import 'package:upnp_explorer/application/network_logs/network_event_service.dart';
import 'package:upnp_explorer/application/version_service.dart';
import 'package:upnp_explorer/application/l10n/app_localizations.dart';
import 'package:upnp_explorer/features/core/theme.dart';
import 'package:upnped/upnped.dart' as upnp;

import 'store_screenshots_test.mocks.dart';

Future<void> configureTestDependencies() async {
  GetIt.I.allowReassignment = true;

  GetIt.I.registerSingleton(GoogleFeatures());

  configureSharedPreferences();
  configureConnectivity();
  configureServer();
  configureVersion();
  configureChangelog();
  configureNetworkEventService();

  await configureDependencies(environment: 'instrumented');
}

class FakeNetworkEvent extends upnp.NetworkEvent {
  FakeNetworkEvent({
    required super.direction,
    required super.protocol,
    required super.type,
    super.from,
    super.to,
    super.content = '',
  });
}

class TestPageWrapper extends StatelessWidget {
  final Widget child;
  final ThemeMode themeMode;

  const TestPageWrapper({
    super.key,
    required this.child,
    this.themeMode = ThemeMode.light,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: child,
      darkTheme: AppTheme.dark(),
      theme: AppTheme.light(),
      themeMode: themeMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}

void configureNetworkEventService() {
  final service = MockNetworkEventService();

  when(service.events).thenAnswer(
    (_) => Stream.value(
      [
        FakeNetworkEvent(
            direction: upnp.NetworkEventDirection.outgoing,
            protocol: upnp.NetworkEventProtocol.ssdp,
            type: 'M-SEARCH',
            content: '''M-SEARCH * HTTP/1.1
HOST: 239.255.255.250:1900
MAN: "ssdp:discover"
'''),
        FakeNetworkEvent(
            direction: upnp.NetworkEventDirection.incoming,
            protocol: upnp.NetworkEventProtocol.ssdp,
            type: 'NOTIFY',
            from: '192.168.0.1',
            content: '''HTTP/1.1 200 OK
CACHE-CONTROL: max-age=120
ST: upnp:rootdevice
'''),
        FakeNetworkEvent(
            direction: upnp.NetworkEventDirection.incoming,
            protocol: upnp.NetworkEventProtocol.ssdp,
            type: 'NOTIFY',
            from: '192.168.0.138',
            content: '''HTTP/1.1 200 OK
CACHE-CONTROL: max-age=120
ST: upnp:rootdevice
''')
      ],
    ),
  );

  GetIt.I.registerSingleton<NetworkEventService>(service);
}

void configureSharedPreferences() {
  final prefs = MockSharedPreferences();

  GetIt.I.registerSingleton<SharedPreferences>(prefs);
}

void configureVersion() {
  final version = MockVersionService();

  when(version.getVersion()).thenAnswer((_) => Future.value('1.0.0'));

  GetIt.I.registerSingleton<VersionService>(version);
}

void configureConnectivity() {
  final connectivity = MockConnectivity();

  when(connectivity.checkConnectivity())
      .thenAnswer((_) => Future.value([ConnectivityResult.wifi]));
  when(connectivity.onConnectivityChanged).thenAnswer((_) => Stream.empty());

  GetIt.I.registerSingleton<Connectivity>(connectivity);
}

void configureChangelog() {
  final changelog = MockChangelogService();

  when(changelog.shouldDisplayChangelog())
      .thenAnswer((_) => Future.value(false));

  GetIt.I.registerSingleton<ChangelogService>(changelog);
}

void configureServer() {
  final server = MockServer();

  when(server.devices).thenAnswer((_) => Stream.fromIterable(_devices()));

  GetIt.I.registerSingleton<upnp.Server>(server);
}

MockAction _createAction(String name) {
  final action = MockAction();
  when(action.name).thenReturn(name);

  return action;
}

MockService _createService(String name, List<String> actionNames) {
  final actions = actionNames.map((x) => _createAction(x)).toList();

  final description = MockServiceDescription();
  when(description.actions).thenReturn(actions);

  final document = MockServiceData();
  when(document.serviceId).thenReturn(upnp.ServiceId(
    '',
    domain: '',
    serviceId: name,
  ));

  final service = MockService();
  when(service.description).thenReturn(description);
  when(service.document).thenReturn(document);

  return service;
}

MockDevice chromecast() {
  final description = MockDeviceDescription();
  when(description.friendlyName).thenReturn('Chromecast');
  when(description.deviceType).thenReturn(upnp.DeviceType(uri: ""));

  final notify = MockNotifyDiscovered();
  when(notify.location).thenReturn(Uri(host: '192.168.0.122'));

  final services = <MockService>[];

  final soundbar = MockDevice();
  when(soundbar.description).thenReturn(description);
  when(soundbar.notify).thenReturn(notify);
  when(soundbar.isActive).thenAnswer((_) => Stream.value(true));
  when(soundbar.services).thenReturn(services);

  return soundbar;
}

MockDevice soundbar() {
  final description = MockDeviceDescription();
  when(description.friendlyName).thenReturn('Living room sound bar');
  when(description.deviceType).thenReturn(upnp.DeviceType(uri: ""));

  final notify = MockNotifyDiscovered();
  when(notify.location).thenReturn(Uri(host: '192.168.0.5'));

  final instanceId = MockArgument();
  when(instanceId.name).thenReturn('InstanceID');
  when(instanceId.direction).thenReturn(upnp.Direction.fromString('in'));
  when(instanceId.relatedStateVariable).thenReturn('instance');
  final instanceIdStateVariable = MockStateVariable();
  when(instanceIdStateVariable.name).thenReturn('instance');
  when(instanceIdStateVariable.dataType)
      .thenReturn(upnp.DataType(upnp.DataTypeValue.string));
  when(instanceIdStateVariable.defaultValue).thenReturn('0');

  final channel = MockArgument();
  when(channel.name).thenReturn('Channel');
  when(channel.direction).thenReturn(upnp.Direction.fromString('in'));
  when(channel.relatedStateVariable).thenReturn('channel');
  final channelStateVariable = MockStateVariable();
  when(channelStateVariable.name).thenReturn('channel');
  when(channelStateVariable.dataType)
      .thenReturn(upnp.DataType(upnp.DataTypeValue.string));
  when(channelStateVariable.allowedValues).thenReturn(['Master']);

  final volume = MockArgument();
  when(volume.name).thenReturn('DesiredVolume');
  when(volume.direction).thenReturn(upnp.Direction.fromString('in'));
  when(volume.relatedStateVariable).thenReturn('volume');
  final volumeRange = MockAllowedValueRange();
  when(volumeRange.minimum).thenReturn('0');
  when(volumeRange.maximum).thenReturn('100');
  when(volumeRange.step).thenReturn(1);

  final volumeStateVariable = MockStateVariable();
  when(volumeStateVariable.name).thenReturn('volume');
  when(volumeStateVariable.dataType)
      .thenReturn(upnp.DataType(upnp.DataTypeValue.ui2));
  when(volumeStateVariable.allowedValueRange).thenReturn(volumeRange);

  var setVolume = MockAction();
  when(setVolume.name).thenReturn('SetVolume');
  when(setVolume.inputs).thenReturn([instanceId, channel, volume]);
  when(setVolume.outputs).thenReturn([]);

  final actions = [
    'ListPresets',
    'SelectPreset',
    'GetMute',
    'SetMute',
    'GetVolume',
  ].map((x) => _createAction(x)).toList();

  final serviceStateTable = MockServiceStateTable();
  when(serviceStateTable.stateVariables).thenReturn([
    volumeStateVariable
  ]);

  final renderingControlDescription = MockServiceDescription();
  when(renderingControlDescription.actions).thenReturn([...actions, setVolume]);
  when(renderingControlDescription.serviceStateTable).thenReturn(serviceStateTable);

  final document = MockServiceData();
  when(document.serviceId).thenReturn(upnp.ServiceId(
    '',
    domain: '',
    serviceId: 'RenderingControl',
  ));
  
  final renderingControl = MockService();
  when(renderingControl.description).thenReturn(renderingControlDescription);
  when(renderingControl.document).thenReturn(document);

  final services = [
    renderingControl,
    _createService('ConnectionManager', []),
    _createService('AVTransport', []),
    _createService('Group', []),
    _createService('MultiChannel', []),
    _createService('ScalarWebAPI', []),
  ];

  final soundbar = MockDevice();
  when(soundbar.description).thenReturn(description);
  when(soundbar.notify).thenReturn(notify);
  when(soundbar.isActive).thenAnswer((_) => Stream.value(true));
  when(soundbar.services).thenReturn(services);

  return soundbar;
}

Iterable<MockDevice> _devices() {
  return <MockDevice>[
    soundbar(),
    chromecast(),
  ];
}
