import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upnp_explorer/application/changelog/changelog_service.dart';
import 'package:upnp_explorer/application/network_logs/network_event_service.dart';
import 'package:upnp_explorer/application/version_service.dart';
import 'package:upnp_explorer/presentation/device/pages/device_info_page.dart';
import 'package:upnp_explorer/presentation/device/pages/discovery_page.dart';
import 'package:upnp_explorer/presentation/network_logs/pages/logs_page.dart';
import 'package:upnp_explorer/presentation/service/pages/action_page.dart';
import 'package:upnped/upnped.dart' as upnp;

import 'store_screenshots_test.setup.dart';
import 'util/screenshot_wrapper.dart';
import 'store_screenshots_test.mocks.dart';
import 'wrappers/actions_screenshot_wrapper.dart';
import 'wrappers/commands_wrapper.dart';
import 'wrappers/devices_wrapper.dart';
import 'wrappers/logs_screenshot_wrapper.dart';

@GenerateNiceMocks([
  MockSpec<SharedPreferences>(),
  MockSpec<Connectivity>(),
  MockSpec<NetworkEventService>(),
  MockSpec<upnp.Server>(),
  MockSpec<VersionService>(),
  MockSpec<ChangelogService>(),
  MockSpec<upnp.DeviceDescription>(),
  MockSpec<upnp.Device>(),
  MockSpec<upnp.NotifyDiscovered>(),
  MockSpec<upnp.ServiceDescription>(),
  MockSpec<upnp.Action>(),
  MockSpec<upnp.ServiceStateTable>(),
  MockSpec<upnp.SpecVersion>(),
  MockSpec<upnp.Service>(),
  MockSpec<upnp.ServiceData>(),
  MockSpec<upnp.Argument>(),
  MockSpec<upnp.StateVariable>(),
  MockSpec<upnp.AllowedValueRange>(),
])
void main() {
  /*
  Android smartphone: 1107 x 1968 (density: 3)
7 inches Android tablet: 1206 x 2144 (density: 2)
10 inches Android tablet: 1449 x 2576 (density: 2)
  */

  group('store images', () {
    setUpAll(() async {
      await configureTestDependencies();
    });

    testGoldens('devices (light)', (tester) async {
      const name = 'devices.light';
      await takeScreenshot(
        tester: tester,
        widget: TestPageWrapper(child: DiscoveryPage()),
        pageName: name,
        isFinal: false,
        sizeDp: Size(1242 / 3, 2208 / 3),
        density: 3,
      );

      var golden = loadGoldenImage(name);

      await takeScreenshot(
        tester: tester,
        widget: DevicesScreenshotWrapper(golden: golden),
        pageName: name,
        isFinal: true,
        sizeDp: Size(1242 / 3, 2688 / 3),
        density: 3,
      );
    });

    testActions(WidgetTester tester, ThemeMode themeMode) async {
      final livingRoomSoundBar = find.text('Living room sound bar');
      final renderingControl = find.text('RenderingControl');

      final app = TestPageWrapper(
        child: DiscoveryPage(),
        themeMode: themeMode,
      );
      await tester.pumpWidgetBuilder(app);

      await tester.tap(livingRoomSoundBar);
      await tester.pumpAndSettle();

      await tester.tap(renderingControl);
      await tester.pumpAndSettle();

      await takeScreenshot(
        tester: tester,
        widget: app,
        pageName: 'actions.${themeMode.name}',
        isFinal: false,
        sizeDp: Size(1242 / 3, 2688 / 3),
        density: 3,
      );
    }

    testGoldens('actions (dark)', (tester) async {
      await testActions(tester, ThemeMode.dark);
    });

    testGoldens('actions (light)', (tester) async {
      await testActions(tester, ThemeMode.light);
    });

    testGoldens('actions', (tester) async {
      var light = loadGoldenImage('actions.light');
      var dark = loadGoldenImage('actions.dark');

      await takeScreenshot(
        tester: tester,
        widget: ActionsScreenshotWrapper(
          light: light,
          dark: dark,
        ),
        pageName: 'actions',
        isFinal: true,
        sizeDp: Size(1242 / 3, 2688 / 3),
        density: 3,
      );
    });

    testGoldens('logs', (tester) async {
      const name = 'logs.dark';

      await takeScreenshot(
        tester: tester,
        widget: TestPageWrapper(
          child: LogsPage(),
          themeMode: ThemeMode.dark,
        ),
        pageName: name,
        isFinal: false,
        sizeDp: Size(1242 / 3, 2662 / 3),
        density: 3,
      );

      final golden = loadGoldenImage(name);

      await takeScreenshot(
        tester: tester,
        widget: LogsScreenshotWrapper(golden: golden),
        pageName: name,
        isFinal: true,
        sizeDp: Size(1242 / 3, 2688 / 3),
        density: 3,
      );
    });

    testGoldens('deviceInfo', (tester) async {
      final device = MockDeviceDescription();
      when(device.friendlyName).thenReturn("Living room sound bar");
      when(device.manufacturer).thenReturn("Sony Corporation");
      when(device.manufacturerUrl).thenReturn(Uri());
      when(device.modelName).thenReturn("HT-CT790");
      when(device.modelNumber).thenReturn("BAR-2016");

      final notify = MockNotifyDiscovered();
      when(notify.location).thenReturn(Uri());

      final screen = DeviceInfoPage(
        device: device,
        notify: notify,
      );

      await takeScreenshot(
        tester: tester,
        widget: TestPageWrapper(
          child: screen,
        ),
        pageName: 'deviceInfo.light',
        isFinal: false,
        sizeDp: Size(1242 / 3, 2688 / 3),
        density: 3,
      );
    });

    testGoldens('command', (tester) async {
      const name = 'action.light';

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

      final actionArgs = <upnp.Argument>[
        instanceId,
        channel,
        volume,
      ];
      final stateVariables = <upnp.StateVariable>[
        instanceIdStateVariable,
        channelStateVariable,
        volumeStateVariable
      ];

      final action = MockAction();
      when(action.arguments).thenReturn(actionArgs);
      when(action.name).thenReturn('SetVolume');

      final stateTable = MockServiceStateTable();
      when(stateTable.stateVariables).thenReturn(stateVariables);

      final screen = ActionPage(
        action: action,
        stateTable: stateTable,
      );

      await takeScreenshot(
        tester: tester,
        widget: TestPageWrapper(child: screen),
        pageName: name,
        isFinal: false,
        sizeDp: Size(1242 / 3, 2662 / 3),
        density: 3,
      );

      var golden = loadGoldenImage(name);

      await takeScreenshot(
        tester: tester,
        widget: CommandsScreenshotWrapper(golden: golden),
        pageName: name,
        isFinal: true,
        sizeDp: Size(1242 / 3, 2688 / 3),
        density: 3,
      );
    });
  });
}
