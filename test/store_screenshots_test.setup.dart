import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upnp_explorer/application/changelog/changelog_service.dart';
import 'package:upnp_explorer/application/flavors/google/google_features.dart';
import 'package:upnp_explorer/application/ioc.dart';
import 'package:upnp_explorer/application/network_logs/network_event_service.dart';
import 'package:upnp_explorer/application/settings/palette.dart';
import 'package:upnp_explorer/application/version_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: child,
        darkTheme: AppTheme.dark(
          darkDynamic,
          VisualDensity.standard,
        ),
        theme: AppTheme.light(
          lightDynamic,
          VisualDensity.standard,
        ),
        themeMode: themeMode,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
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

  final renderingControlDescription = MockServiceDescription();
  when(renderingControlDescription.actions).thenReturn(actions);

  final renderingControlDocument = MockServiceData();
  when(renderingControlDocument.serviceId).thenReturn(upnp.ServiceId(
    '',
    domain: '',
    serviceId: name,
  ));

  final renderingControl = MockService();
  when(renderingControl.description).thenReturn(renderingControlDescription);
  when(renderingControl.document).thenReturn(renderingControlDocument);

  return renderingControl;
}

MockDevice chromecast() {
  final description = MockDeviceDescription();
  when(description.friendlyName).thenReturn('Chromecast');

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

  final notify = MockNotifyDiscovered();
  when(notify.location).thenReturn(Uri(host: '192.168.0.5'));

  final services = [
    _createService('RenderingControl', [
      'ListPresets',
      'SelectPreset',
      'GetMute',
      'SetMute',
      'GetVolume',
      'SetVolume'
    ]),
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
