// Mocks generated by Mockito 5.4.4 from annotations
// in upnp_explorer/test/store_screenshots_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i9;
import 'dart:collection' as _i6;

import 'package:connectivity_plus/connectivity_plus.dart' as _i10;
import 'package:connectivity_plus_platform_interface/connectivity_plus_platform_interface.dart'
    as _i11;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i13;
import 'package:shared_preferences/shared_preferences.dart' as _i4;
import 'package:upnp_explorer/application/changelog/changelog_service.dart'
    as _i14;
import 'package:upnp_explorer/application/network_logs/filters_service.dart'
    as _i2;
import 'package:upnp_explorer/application/network_logs/network_event_service.dart'
    as _i12;
import 'package:upnp_explorer/application/version_service.dart' as _i5;
import 'package:upnped/src/shared/messages.dart' as _i15;
import 'package:upnped/src/ssdp/ssdp.dart' as _i7;
import 'package:upnped/upnped.dart' as _i3;
import 'package:xml/xml.dart' as _i8;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeFilterService_0 extends _i1.SmartFake implements _i2.FilterService {
  _FakeFilterService_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeOptions_1 extends _i1.SmartFake implements _i3.Options {
  _FakeOptions_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSharedPreferences_2 extends _i1.SmartFake
    implements _i4.SharedPreferences {
  _FakeSharedPreferences_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeVersionService_3 extends _i1.SmartFake
    implements _i5.VersionService {
  _FakeVersionService_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDeviceType_4 extends _i1.SmartFake implements _i3.DeviceType {
  _FakeDeviceType_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUnmodifiableListView_5<E> extends _i1.SmartFake
    implements _i6.UnmodifiableListView<E> {
  _FakeUnmodifiableListView_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDeviceDescription_6 extends _i1.SmartFake
    implements _i3.DeviceDescription {
  _FakeDeviceDescription_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeNotify_7 extends _i1.SmartFake implements _i7.Notify {
  _FakeNotify_7(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUnmodifiableMapView_8<K, V> extends _i1.SmartFake
    implements _i6.UnmodifiableMapView<K, V> {
  _FakeUnmodifiableMapView_8(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeXmlDocument_9 extends _i1.SmartFake implements _i8.XmlDocument {
  _FakeXmlDocument_9(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSpecVersion_10 extends _i1.SmartFake implements _i3.SpecVersion {
  _FakeSpecVersion_10(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeServiceStateTable_11 extends _i1.SmartFake
    implements _i3.ServiceStateTable {
  _FakeServiceStateTable_11(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeActionResponse_12 extends _i1.SmartFake
    implements _i3.ActionResponse {
  _FakeActionResponse_12(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeServiceData_13 extends _i1.SmartFake implements _i3.ServiceData {
  _FakeServiceData_13(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUri_14 extends _i1.SmartFake implements Uri {
  _FakeUri_14(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeServiceId_15 extends _i1.SmartFake implements _i3.ServiceId {
  _FakeServiceId_15(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDataType_16 extends _i1.SmartFake implements _i3.DataType {
  _FakeDataType_16(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [SharedPreferences].
///
/// See the documentation for Mockito's code generation for more information.
class MockSharedPreferences extends _i1.Mock implements _i4.SharedPreferences {
  @override
  Set<String> getKeys() => (super.noSuchMethod(
        Invocation.method(
          #getKeys,
          [],
        ),
        returnValue: <String>{},
        returnValueForMissingStub: <String>{},
      ) as Set<String>);

  @override
  Object? get(String? key) => (super.noSuchMethod(
        Invocation.method(
          #get,
          [key],
        ),
        returnValueForMissingStub: null,
      ) as Object?);

  @override
  bool? getBool(String? key) => (super.noSuchMethod(
        Invocation.method(
          #getBool,
          [key],
        ),
        returnValueForMissingStub: null,
      ) as bool?);

  @override
  int? getInt(String? key) => (super.noSuchMethod(
        Invocation.method(
          #getInt,
          [key],
        ),
        returnValueForMissingStub: null,
      ) as int?);

  @override
  double? getDouble(String? key) => (super.noSuchMethod(
        Invocation.method(
          #getDouble,
          [key],
        ),
        returnValueForMissingStub: null,
      ) as double?);

  @override
  String? getString(String? key) => (super.noSuchMethod(
        Invocation.method(
          #getString,
          [key],
        ),
        returnValueForMissingStub: null,
      ) as String?);

  @override
  bool containsKey(String? key) => (super.noSuchMethod(
        Invocation.method(
          #containsKey,
          [key],
        ),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  List<String>? getStringList(String? key) => (super.noSuchMethod(
        Invocation.method(
          #getStringList,
          [key],
        ),
        returnValueForMissingStub: null,
      ) as List<String>?);

  @override
  _i9.Future<bool> setBool(
    String? key,
    bool? value,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #setBool,
          [
            key,
            value,
          ],
        ),
        returnValue: _i9.Future<bool>.value(false),
        returnValueForMissingStub: _i9.Future<bool>.value(false),
      ) as _i9.Future<bool>);

  @override
  _i9.Future<bool> setInt(
    String? key,
    int? value,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #setInt,
          [
            key,
            value,
          ],
        ),
        returnValue: _i9.Future<bool>.value(false),
        returnValueForMissingStub: _i9.Future<bool>.value(false),
      ) as _i9.Future<bool>);

  @override
  _i9.Future<bool> setDouble(
    String? key,
    double? value,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #setDouble,
          [
            key,
            value,
          ],
        ),
        returnValue: _i9.Future<bool>.value(false),
        returnValueForMissingStub: _i9.Future<bool>.value(false),
      ) as _i9.Future<bool>);

  @override
  _i9.Future<bool> setString(
    String? key,
    String? value,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #setString,
          [
            key,
            value,
          ],
        ),
        returnValue: _i9.Future<bool>.value(false),
        returnValueForMissingStub: _i9.Future<bool>.value(false),
      ) as _i9.Future<bool>);

  @override
  _i9.Future<bool> setStringList(
    String? key,
    List<String>? value,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #setStringList,
          [
            key,
            value,
          ],
        ),
        returnValue: _i9.Future<bool>.value(false),
        returnValueForMissingStub: _i9.Future<bool>.value(false),
      ) as _i9.Future<bool>);

  @override
  _i9.Future<bool> remove(String? key) => (super.noSuchMethod(
        Invocation.method(
          #remove,
          [key],
        ),
        returnValue: _i9.Future<bool>.value(false),
        returnValueForMissingStub: _i9.Future<bool>.value(false),
      ) as _i9.Future<bool>);

  @override
  _i9.Future<bool> commit() => (super.noSuchMethod(
        Invocation.method(
          #commit,
          [],
        ),
        returnValue: _i9.Future<bool>.value(false),
        returnValueForMissingStub: _i9.Future<bool>.value(false),
      ) as _i9.Future<bool>);

  @override
  _i9.Future<bool> clear() => (super.noSuchMethod(
        Invocation.method(
          #clear,
          [],
        ),
        returnValue: _i9.Future<bool>.value(false),
        returnValueForMissingStub: _i9.Future<bool>.value(false),
      ) as _i9.Future<bool>);

  @override
  _i9.Future<void> reload() => (super.noSuchMethod(
        Invocation.method(
          #reload,
          [],
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);
}

/// A class which mocks [Connectivity].
///
/// See the documentation for Mockito's code generation for more information.
class MockConnectivity extends _i1.Mock implements _i10.Connectivity {
  @override
  _i9.Stream<List<_i11.ConnectivityResult>> get onConnectivityChanged =>
      (super.noSuchMethod(
        Invocation.getter(#onConnectivityChanged),
        returnValue: _i9.Stream<List<_i11.ConnectivityResult>>.empty(),
        returnValueForMissingStub:
            _i9.Stream<List<_i11.ConnectivityResult>>.empty(),
      ) as _i9.Stream<List<_i11.ConnectivityResult>>);

  @override
  _i9.Future<List<_i11.ConnectivityResult>> checkConnectivity() =>
      (super.noSuchMethod(
        Invocation.method(
          #checkConnectivity,
          [],
        ),
        returnValue: _i9.Future<List<_i11.ConnectivityResult>>.value(
            <_i11.ConnectivityResult>[]),
        returnValueForMissingStub:
            _i9.Future<List<_i11.ConnectivityResult>>.value(
                <_i11.ConnectivityResult>[]),
      ) as _i9.Future<List<_i11.ConnectivityResult>>);
}

/// A class which mocks [NetworkEventService].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkEventService extends _i1.Mock
    implements _i12.NetworkEventService {
  @override
  _i2.FilterService get filterService => (super.noSuchMethod(
        Invocation.getter(#filterService),
        returnValue: _FakeFilterService_0(
          this,
          Invocation.getter(#filterService),
        ),
        returnValueForMissingStub: _FakeFilterService_0(
          this,
          Invocation.getter(#filterService),
        ),
      ) as _i2.FilterService);

  @override
  _i9.Stream<List<_i3.NetworkEvent>> get events => (super.noSuchMethod(
        Invocation.getter(#events),
        returnValue: _i9.Stream<List<_i3.NetworkEvent>>.empty(),
        returnValueForMissingStub: _i9.Stream<List<_i3.NetworkEvent>>.empty(),
      ) as _i9.Stream<List<_i3.NetworkEvent>>);

  @override
  void clear() => super.noSuchMethod(
        Invocation.method(
          #clear,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [Server].
///
/// See the documentation for Mockito's code generation for more information.
class MockServer extends _i1.Mock implements _i3.Server {
  @override
  _i3.Options get options => (super.noSuchMethod(
        Invocation.getter(#options),
        returnValue: _FakeOptions_1(
          this,
          Invocation.getter(#options),
        ),
        returnValueForMissingStub: _FakeOptions_1(
          this,
          Invocation.getter(#options),
        ),
      ) as _i3.Options);

  @override
  set options(_i3.Options? _options) => super.noSuchMethod(
        Invocation.setter(
          #options,
          _options,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool Function(_i3.NotifyDiscovered) get loadPredicate => (super.noSuchMethod(
        Invocation.getter(#loadPredicate),
        returnValue: (_i3.NotifyDiscovered event) => false,
        returnValueForMissingStub: (_i3.NotifyDiscovered event) => false,
      ) as bool Function(_i3.NotifyDiscovered));

  @override
  set loadPredicate(bool Function(_i3.NotifyDiscovered)? _loadPredicate) =>
      super.noSuchMethod(
        Invocation.setter(
          #loadPredicate,
          _loadPredicate,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i9.Stream<_i3.Device> get devices => (super.noSuchMethod(
        Invocation.getter(#devices),
        returnValue: _i9.Stream<_i3.Device>.empty(),
        returnValueForMissingStub: _i9.Stream<_i3.Device>.empty(),
      ) as _i9.Stream<_i3.Device>);

  @override
  _i9.Future<void> stop() => (super.noSuchMethod(
        Invocation.method(
          #stop,
          [],
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);

  @override
  _i9.Future<void> listen(_i3.Options? options) => (super.noSuchMethod(
        Invocation.method(
          #listen,
          [options],
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);

  @override
  _i9.Future<void> search({
    Duration? maxResponseTime = const Duration(seconds: 5),
    String? searchTarget = r'upnp:rootdevice',
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #search,
          [],
          {
            #maxResponseTime: maxResponseTime,
            #searchTarget: searchTarget,
          },
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);
}

/// A class which mocks [VersionService].
///
/// See the documentation for Mockito's code generation for more information.
class MockVersionService extends _i1.Mock implements _i5.VersionService {
  @override
  _i9.Future<String> getVersion() => (super.noSuchMethod(
        Invocation.method(
          #getVersion,
          [],
        ),
        returnValue: _i9.Future<String>.value(_i13.dummyValue<String>(
          this,
          Invocation.method(
            #getVersion,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i9.Future<String>.value(_i13.dummyValue<String>(
          this,
          Invocation.method(
            #getVersion,
            [],
          ),
        )),
      ) as _i9.Future<String>);
}

/// A class which mocks [ChangelogService].
///
/// See the documentation for Mockito's code generation for more information.
class MockChangelogService extends _i1.Mock implements _i14.ChangelogService {
  @override
  _i4.SharedPreferences get prefs => (super.noSuchMethod(
        Invocation.getter(#prefs),
        returnValue: _FakeSharedPreferences_2(
          this,
          Invocation.getter(#prefs),
        ),
        returnValueForMissingStub: _FakeSharedPreferences_2(
          this,
          Invocation.getter(#prefs),
        ),
      ) as _i4.SharedPreferences);

  @override
  _i5.VersionService get versionService => (super.noSuchMethod(
        Invocation.getter(#versionService),
        returnValue: _FakeVersionService_3(
          this,
          Invocation.getter(#versionService),
        ),
        returnValueForMissingStub: _FakeVersionService_3(
          this,
          Invocation.getter(#versionService),
        ),
      ) as _i5.VersionService);

  @override
  _i9.Future<bool> shouldDisplayChangelog() => (super.noSuchMethod(
        Invocation.method(
          #shouldDisplayChangelog,
          [],
        ),
        returnValue: _i9.Future<bool>.value(false),
        returnValueForMissingStub: _i9.Future<bool>.value(false),
      ) as _i9.Future<bool>);

  @override
  _i9.Stream<String> changes() => (super.noSuchMethod(
        Invocation.method(
          #changes,
          [],
        ),
        returnValue: _i9.Stream<String>.empty(),
        returnValueForMissingStub: _i9.Stream<String>.empty(),
      ) as _i9.Stream<String>);

  @override
  _i9.Future<String> futureChanges() => (super.noSuchMethod(
        Invocation.method(
          #futureChanges,
          [],
        ),
        returnValue: _i9.Future<String>.value(_i13.dummyValue<String>(
          this,
          Invocation.method(
            #futureChanges,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i9.Future<String>.value(_i13.dummyValue<String>(
          this,
          Invocation.method(
            #futureChanges,
            [],
          ),
        )),
      ) as _i9.Future<String>);
}

/// A class which mocks [DeviceDescription].
///
/// See the documentation for Mockito's code generation for more information.
class MockDeviceDescription extends _i1.Mock implements _i3.DeviceDescription {
  @override
  _i3.DeviceType get deviceType => (super.noSuchMethod(
        Invocation.getter(#deviceType),
        returnValue: _FakeDeviceType_4(
          this,
          Invocation.getter(#deviceType),
        ),
        returnValueForMissingStub: _FakeDeviceType_4(
          this,
          Invocation.getter(#deviceType),
        ),
      ) as _i3.DeviceType);

  @override
  String get friendlyName => (super.noSuchMethod(
        Invocation.getter(#friendlyName),
        returnValue: _i13.dummyValue<String>(
          this,
          Invocation.getter(#friendlyName),
        ),
        returnValueForMissingStub: _i13.dummyValue<String>(
          this,
          Invocation.getter(#friendlyName),
        ),
      ) as String);

  @override
  String get manufacturer => (super.noSuchMethod(
        Invocation.getter(#manufacturer),
        returnValue: _i13.dummyValue<String>(
          this,
          Invocation.getter(#manufacturer),
        ),
        returnValueForMissingStub: _i13.dummyValue<String>(
          this,
          Invocation.getter(#manufacturer),
        ),
      ) as String);

  @override
  String get modelName => (super.noSuchMethod(
        Invocation.getter(#modelName),
        returnValue: _i13.dummyValue<String>(
          this,
          Invocation.getter(#modelName),
        ),
        returnValueForMissingStub: _i13.dummyValue<String>(
          this,
          Invocation.getter(#modelName),
        ),
      ) as String);

  @override
  String get udn => (super.noSuchMethod(
        Invocation.getter(#udn),
        returnValue: _i13.dummyValue<String>(
          this,
          Invocation.getter(#udn),
        ),
        returnValueForMissingStub: _i13.dummyValue<String>(
          this,
          Invocation.getter(#udn),
        ),
      ) as String);

  @override
  List<_i3.DeviceIcon> get iconList => (super.noSuchMethod(
        Invocation.getter(#iconList),
        returnValue: <_i3.DeviceIcon>[],
        returnValueForMissingStub: <_i3.DeviceIcon>[],
      ) as List<_i3.DeviceIcon>);

  @override
  List<_i3.ServiceData> get services => (super.noSuchMethod(
        Invocation.getter(#services),
        returnValue: <_i3.ServiceData>[],
        returnValueForMissingStub: <_i3.ServiceData>[],
      ) as List<_i3.ServiceData>);

  @override
  List<_i3.DeviceDescription> get devices => (super.noSuchMethod(
        Invocation.getter(#devices),
        returnValue: <_i3.DeviceDescription>[],
        returnValueForMissingStub: <_i3.DeviceDescription>[],
      ) as List<_i3.DeviceDescription>);

  @override
  _i6.UnmodifiableListView<_i8.XmlElement> get extensions =>
      (super.noSuchMethod(
        Invocation.getter(#extensions),
        returnValue: _FakeUnmodifiableListView_5<_i8.XmlElement>(
          this,
          Invocation.getter(#extensions),
        ),
        returnValueForMissingStub: _FakeUnmodifiableListView_5<_i8.XmlElement>(
          this,
          Invocation.getter(#extensions),
        ),
      ) as _i6.UnmodifiableListView<_i8.XmlElement>);
}

/// A class which mocks [Device].
///
/// See the documentation for Mockito's code generation for more information.
class MockDevice extends _i1.Mock implements _i3.Device {
  @override
  _i3.DeviceDescription get description => (super.noSuchMethod(
        Invocation.getter(#description),
        returnValue: _FakeDeviceDescription_6(
          this,
          Invocation.getter(#description),
        ),
        returnValueForMissingStub: _FakeDeviceDescription_6(
          this,
          Invocation.getter(#description),
        ),
      ) as _i3.DeviceDescription);

  @override
  List<_i3.Service> get services => (super.noSuchMethod(
        Invocation.getter(#services),
        returnValue: <_i3.Service>[],
        returnValueForMissingStub: <_i3.Service>[],
      ) as List<_i3.Service>);

  @override
  List<_i3.Device> get devices => (super.noSuchMethod(
        Invocation.getter(#devices),
        returnValue: <_i3.Device>[],
        returnValueForMissingStub: <_i3.Device>[],
      ) as List<_i3.Device>);

  @override
  _i9.Stream<bool> get isActive => (super.noSuchMethod(
        Invocation.getter(#isActive),
        returnValue: _i9.Stream<bool>.empty(),
        returnValueForMissingStub: _i9.Stream<bool>.empty(),
      ) as _i9.Stream<bool>);
}

/// A class which mocks [NotifyDiscovered].
///
/// See the documentation for Mockito's code generation for more information.
class MockNotifyDiscovered extends _i1.Mock implements _i3.NotifyDiscovered {
  @override
  String get st => (super.noSuchMethod(
        Invocation.getter(#st),
        returnValue: _i13.dummyValue<String>(
          this,
          Invocation.getter(#st),
        ),
        returnValueForMissingStub: _i13.dummyValue<String>(
          this,
          Invocation.getter(#st),
        ),
      ) as String);

  @override
  _i7.Notify get wrapped => (super.noSuchMethod(
        Invocation.getter(#wrapped),
        returnValue: _FakeNotify_7(
          this,
          Invocation.getter(#wrapped),
        ),
        returnValueForMissingStub: _FakeNotify_7(
          this,
          Invocation.getter(#wrapped),
        ),
      ) as _i7.Notify);

  @override
  _i15.NotificationSubtype get nts => (super.noSuchMethod(
        Invocation.getter(#nts),
        returnValue: _i15.NotificationSubtype.none,
        returnValueForMissingStub: _i15.NotificationSubtype.none,
      ) as _i15.NotificationSubtype);

  @override
  String get usn => (super.noSuchMethod(
        Invocation.getter(#usn),
        returnValue: _i13.dummyValue<String>(
          this,
          Invocation.getter(#usn),
        ),
        returnValueForMissingStub: _i13.dummyValue<String>(
          this,
          Invocation.getter(#usn),
        ),
      ) as String);

  @override
  int get bootId => (super.noSuchMethod(
        Invocation.getter(#bootId),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);

  @override
  int get configId => (super.noSuchMethod(
        Invocation.getter(#configId),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);

  @override
  _i6.UnmodifiableMapView<String, String> get headers => (super.noSuchMethod(
        Invocation.getter(#headers),
        returnValue: _FakeUnmodifiableMapView_8<String, String>(
          this,
          Invocation.getter(#headers),
        ),
        returnValueForMissingStub: _FakeUnmodifiableMapView_8<String, String>(
          this,
          Invocation.getter(#headers),
        ),
      ) as _i6.UnmodifiableMapView<String, String>);

  @override
  _i6.UnmodifiableMapView<String, String> get extensions => (super.noSuchMethod(
        Invocation.getter(#extensions),
        returnValue: _FakeUnmodifiableMapView_8<String, String>(
          this,
          Invocation.getter(#extensions),
        ),
        returnValueForMissingStub: _FakeUnmodifiableMapView_8<String, String>(
          this,
          Invocation.getter(#extensions),
        ),
      ) as _i6.UnmodifiableMapView<String, String>);

  @override
  List<Object?> get props => (super.noSuchMethod(
        Invocation.getter(#props),
        returnValue: <Object?>[],
        returnValueForMissingStub: <Object?>[],
      ) as List<Object?>);

  @override
  String? extension(String? key) => (super.noSuchMethod(
        Invocation.method(
          #extension,
          [key],
        ),
        returnValueForMissingStub: null,
      ) as String?);

  @override
  T? allowed<T>(
    String? key,
    T Function(String)? fn,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #allowed,
          [
            key,
            fn,
          ],
        ),
        returnValueForMissingStub: null,
      ) as T?);
}

/// A class which mocks [ServiceDescription].
///
/// See the documentation for Mockito's code generation for more information.
class MockServiceDescription extends _i1.Mock
    implements _i3.ServiceDescription {
  @override
  _i8.XmlDocument get xml => (super.noSuchMethod(
        Invocation.getter(#xml),
        returnValue: _FakeXmlDocument_9(
          this,
          Invocation.getter(#xml),
        ),
        returnValueForMissingStub: _FakeXmlDocument_9(
          this,
          Invocation.getter(#xml),
        ),
      ) as _i8.XmlDocument);

  @override
  String get namespace => (super.noSuchMethod(
        Invocation.getter(#namespace),
        returnValue: _i13.dummyValue<String>(
          this,
          Invocation.getter(#namespace),
        ),
        returnValueForMissingStub: _i13.dummyValue<String>(
          this,
          Invocation.getter(#namespace),
        ),
      ) as String);

  @override
  _i3.SpecVersion get specVersion => (super.noSuchMethod(
        Invocation.getter(#specVersion),
        returnValue: _FakeSpecVersion_10(
          this,
          Invocation.getter(#specVersion),
        ),
        returnValueForMissingStub: _FakeSpecVersion_10(
          this,
          Invocation.getter(#specVersion),
        ),
      ) as _i3.SpecVersion);

  @override
  List<_i3.Action> get actions => (super.noSuchMethod(
        Invocation.getter(#actions),
        returnValue: <_i3.Action>[],
        returnValueForMissingStub: <_i3.Action>[],
      ) as List<_i3.Action>);

  @override
  _i3.ServiceStateTable get serviceStateTable => (super.noSuchMethod(
        Invocation.getter(#serviceStateTable),
        returnValue: _FakeServiceStateTable_11(
          this,
          Invocation.getter(#serviceStateTable),
        ),
        returnValueForMissingStub: _FakeServiceStateTable_11(
          this,
          Invocation.getter(#serviceStateTable),
        ),
      ) as _i3.ServiceStateTable);
}

/// A class which mocks [Action].
///
/// See the documentation for Mockito's code generation for more information.
class MockAction extends _i1.Mock implements _i3.Action {
  @override
  String get name => (super.noSuchMethod(
        Invocation.getter(#name),
        returnValue: _i13.dummyValue<String>(
          this,
          Invocation.getter(#name),
        ),
        returnValueForMissingStub: _i13.dummyValue<String>(
          this,
          Invocation.getter(#name),
        ),
      ) as String);

  @override
  _i9.Future<_i3.ActionResponse> invoke(Map<String, dynamic>? args) =>
      (super.noSuchMethod(
        Invocation.method(
          #invoke,
          [args],
        ),
        returnValue:
            _i9.Future<_i3.ActionResponse>.value(_FakeActionResponse_12(
          this,
          Invocation.method(
            #invoke,
            [args],
          ),
        )),
        returnValueForMissingStub:
            _i9.Future<_i3.ActionResponse>.value(_FakeActionResponse_12(
          this,
          Invocation.method(
            #invoke,
            [args],
          ),
        )),
      ) as _i9.Future<_i3.ActionResponse>);
}

/// A class which mocks [ServiceStateTable].
///
/// See the documentation for Mockito's code generation for more information.
class MockServiceStateTable extends _i1.Mock implements _i3.ServiceStateTable {
  @override
  List<_i3.StateVariable> get stateVariables => (super.noSuchMethod(
        Invocation.getter(#stateVariables),
        returnValue: <_i3.StateVariable>[],
        returnValueForMissingStub: <_i3.StateVariable>[],
      ) as List<_i3.StateVariable>);
}

/// A class which mocks [SpecVersion].
///
/// See the documentation for Mockito's code generation for more information.
class MockSpecVersion extends _i1.Mock implements _i3.SpecVersion {
  @override
  int get major => (super.noSuchMethod(
        Invocation.getter(#major),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);

  @override
  int get minor => (super.noSuchMethod(
        Invocation.getter(#minor),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);
}

/// A class which mocks [Service].
///
/// See the documentation for Mockito's code generation for more information.
class MockService extends _i1.Mock implements _i3.Service {
  @override
  _i3.ServiceData get document => (super.noSuchMethod(
        Invocation.getter(#document),
        returnValue: _FakeServiceData_13(
          this,
          Invocation.getter(#document),
        ),
        returnValueForMissingStub: _FakeServiceData_13(
          this,
          Invocation.getter(#document),
        ),
      ) as _i3.ServiceData);

  @override
  Uri get location => (super.noSuchMethod(
        Invocation.getter(#location),
        returnValue: _FakeUri_14(
          this,
          Invocation.getter(#location),
        ),
        returnValueForMissingStub: _FakeUri_14(
          this,
          Invocation.getter(#location),
        ),
      ) as Uri);
}

/// A class which mocks [ServiceData].
///
/// See the documentation for Mockito's code generation for more information.
class MockServiceData extends _i1.Mock implements _i3.ServiceData {
  @override
  String get serviceType => (super.noSuchMethod(
        Invocation.getter(#serviceType),
        returnValue: _i13.dummyValue<String>(
          this,
          Invocation.getter(#serviceType),
        ),
        returnValueForMissingStub: _i13.dummyValue<String>(
          this,
          Invocation.getter(#serviceType),
        ),
      ) as String);

  @override
  String get serviceVersion => (super.noSuchMethod(
        Invocation.getter(#serviceVersion),
        returnValue: _i13.dummyValue<String>(
          this,
          Invocation.getter(#serviceVersion),
        ),
        returnValueForMissingStub: _i13.dummyValue<String>(
          this,
          Invocation.getter(#serviceVersion),
        ),
      ) as String);

  @override
  _i3.ServiceId get serviceId => (super.noSuchMethod(
        Invocation.getter(#serviceId),
        returnValue: _FakeServiceId_15(
          this,
          Invocation.getter(#serviceId),
        ),
        returnValueForMissingStub: _FakeServiceId_15(
          this,
          Invocation.getter(#serviceId),
        ),
      ) as _i3.ServiceId);

  @override
  Uri get scpdurl => (super.noSuchMethod(
        Invocation.getter(#scpdurl),
        returnValue: _FakeUri_14(
          this,
          Invocation.getter(#scpdurl),
        ),
        returnValueForMissingStub: _FakeUri_14(
          this,
          Invocation.getter(#scpdurl),
        ),
      ) as Uri);

  @override
  Uri get controlUrl => (super.noSuchMethod(
        Invocation.getter(#controlUrl),
        returnValue: _FakeUri_14(
          this,
          Invocation.getter(#controlUrl),
        ),
        returnValueForMissingStub: _FakeUri_14(
          this,
          Invocation.getter(#controlUrl),
        ),
      ) as Uri);

  @override
  Uri get eventSubUrl => (super.noSuchMethod(
        Invocation.getter(#eventSubUrl),
        returnValue: _FakeUri_14(
          this,
          Invocation.getter(#eventSubUrl),
        ),
        returnValueForMissingStub: _FakeUri_14(
          this,
          Invocation.getter(#eventSubUrl),
        ),
      ) as Uri);
}

/// A class which mocks [Argument].
///
/// See the documentation for Mockito's code generation for more information.
class MockArgument extends _i1.Mock implements _i3.Argument {
  @override
  String get name => (super.noSuchMethod(
        Invocation.getter(#name),
        returnValue: _i13.dummyValue<String>(
          this,
          Invocation.getter(#name),
        ),
        returnValueForMissingStub: _i13.dummyValue<String>(
          this,
          Invocation.getter(#name),
        ),
      ) as String);

  @override
  _i3.Direction get direction => (super.noSuchMethod(
        Invocation.getter(#direction),
        returnValue: _i3.Direction.input,
        returnValueForMissingStub: _i3.Direction.input,
      ) as _i3.Direction);

  @override
  String get relatedStateVariable => (super.noSuchMethod(
        Invocation.getter(#relatedStateVariable),
        returnValue: _i13.dummyValue<String>(
          this,
          Invocation.getter(#relatedStateVariable),
        ),
        returnValueForMissingStub: _i13.dummyValue<String>(
          this,
          Invocation.getter(#relatedStateVariable),
        ),
      ) as String);
}

/// A class which mocks [StateVariable].
///
/// See the documentation for Mockito's code generation for more information.
class MockStateVariable extends _i1.Mock implements _i3.StateVariable {
  @override
  String get name => (super.noSuchMethod(
        Invocation.getter(#name),
        returnValue: _i13.dummyValue<String>(
          this,
          Invocation.getter(#name),
        ),
        returnValueForMissingStub: _i13.dummyValue<String>(
          this,
          Invocation.getter(#name),
        ),
      ) as String);

  @override
  _i3.DataType get dataType => (super.noSuchMethod(
        Invocation.getter(#dataType),
        returnValue: _FakeDataType_16(
          this,
          Invocation.getter(#dataType),
        ),
        returnValueForMissingStub: _FakeDataType_16(
          this,
          Invocation.getter(#dataType),
        ),
      ) as _i3.DataType);
}

/// A class which mocks [AllowedValueRange].
///
/// See the documentation for Mockito's code generation for more information.
class MockAllowedValueRange extends _i1.Mock implements _i3.AllowedValueRange {
  @override
  String get minimum => (super.noSuchMethod(
        Invocation.getter(#minimum),
        returnValue: _i13.dummyValue<String>(
          this,
          Invocation.getter(#minimum),
        ),
        returnValueForMissingStub: _i13.dummyValue<String>(
          this,
          Invocation.getter(#minimum),
        ),
      ) as String);

  @override
  String get maximum => (super.noSuchMethod(
        Invocation.getter(#maximum),
        returnValue: _i13.dummyValue<String>(
          this,
          Invocation.getter(#maximum),
        ),
        returnValueForMissingStub: _i13.dummyValue<String>(
          this,
          Invocation.getter(#maximum),
        ),
      ) as String);

  @override
  int get step => (super.noSuchMethod(
        Invocation.getter(#step),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);
}
