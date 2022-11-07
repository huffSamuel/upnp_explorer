import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upnp_explorer/application/settings/options.dart';
import 'package:upnp_explorer/application/settings/options_repository.dart';
import 'package:upnp_explorer/infrastructure/upnp/models/search_target.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences mockSharedPreferences;
  late SettingsRepository repository;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    repository = SettingsRepository(mockSharedPreferences);
  });

  group('get', () {
    test(
      'when a value is null should return Options.base',
      () async {
        // arrange
        when(mockSharedPreferences.getString('ThemeMode')).thenReturn(null);
        when(mockSharedPreferences.getDouble('visualDensity_horizontal'))
            .thenReturn(null);
        when(mockSharedPreferences.getDouble('visualDensity_vertical'))
            .thenReturn(null);
        when(mockSharedPreferences.getInt('maxDelay')).thenReturn(null);
        when(mockSharedPreferences.getInt('hops')).thenReturn(null);
        when(mockSharedPreferences.getBool('advanced')).thenReturn(null);

        final expected = Options.base();

        // act
        final actual = repository.get();

        // assert
        expect(actual, equals(expected));
      },
    );

    test(
      'when an exception is thrown should return Options.base',
      () async {
        // arrange
        when(mockSharedPreferences.getString('ThemeMode')).thenThrow(Exception());
        final expected = Options.base();

        // act
        final actual = repository.get();

        // assert
        expect(actual, equals(expected));
      },
    );

    test(
      'when all values present in storage should return stored Options',
      () async {
        // arrange
        final expected = Options(
          protocolOptions: ProtocolOptions(
            hops: 1,
            maxDelay: 3,
            advanced: false,
            searchTarget: SearchTarget.rootDevice().toString(),
          ),
          visualDensity: VisualDensity.standard,
          themeMode: ThemeMode.dark
        );

        when(mockSharedPreferences.getString('ThemeMode')).thenReturn(enumToString(expected.themeMode));
        when(mockSharedPreferences.getDouble('visualDensity_horizontal'))
            .thenReturn(expected.visualDensity.horizontal);
        when(mockSharedPreferences.getDouble('visualDensity_vertical'))
            .thenReturn(expected.visualDensity.vertical);
        when(mockSharedPreferences.getInt('maxDelay')).thenReturn(expected.protocolOptions.maxDelay);
        when(mockSharedPreferences.getInt('hops')).thenReturn(expected.protocolOptions.hops);
        when(mockSharedPreferences.getBool('advanced')).thenReturn(expected.protocolOptions.advanced);

        // act
        final actual = repository.get();

        // assert
        expect(actual, equals(expected));
      },
    );
  });

  group('set', () {
    test(
      'should write to shared preferences',
      () async {
        // arrange
        final options = Options.base();

        when(mockSharedPreferences.setString(any, any)).thenAnswer((_) async => true);
        when(mockSharedPreferences.setDouble(any, any)).thenAnswer((_) async => true);
        when(mockSharedPreferences.setInt(any, any)).thenAnswer((_) async => true);
        when(mockSharedPreferences.setBool(any, any)).thenAnswer((_) async => true);

        // act
        await repository.set(options);

        // assert
        verify(mockSharedPreferences.setString('ThemeMode', enumToString(options.themeMode)));
        verify(mockSharedPreferences.setDouble('visualDensity_horizontal', options.visualDensity.horizontal));
        verify(mockSharedPreferences.setDouble('visualDensity_vertical', options.visualDensity.vertical));
        verify(mockSharedPreferences.setInt('maxDelay', options.protocolOptions.maxDelay));
        verify(mockSharedPreferences.setInt('hops', options.protocolOptions.hops));
        verify(mockSharedPreferences.setBool('advanced', options.protocolOptions.advanced));
        verifyNoMoreInteractions(mockSharedPreferences);
      },
    );
  });
}
