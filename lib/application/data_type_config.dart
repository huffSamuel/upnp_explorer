import 'package:flutter/services.dart';
import 'package:string_validator/string_validator.dart';

import '../infrastructure/upnp/models/service_description.dart';

class DataTypeConfig {
  final String? defaultValue;
  final String? Function(String?)? validator;
  final TextInputType? inputType;

  DataTypeConfig(
    this.defaultValue,
    this.validator,
    this.inputType,
  );

  static Map<DataType?, DataTypeConfig> values = Map.fromIterable(
    DataType.values,
    key: (e) => e as DataType,
    value: (e) => fromDataType(e),
  );

  static DataTypeConfig fromDataType(DataType type) {
    return DataTypeConfig(
      _defaultValue(type),
      _validator(type),
      _inputType(type),
    );
  }
}

TextInputType? _inputType(DataType type) {
  switch (type) {
    case DataType.ui1:
    case DataType.ui2:
    case DataType.ui4:
    case DataType.ui8:
      return TextInputType.number;
    case DataType.i1:
    case DataType.i2:
    case DataType.i4:
    case DataType.i8:
    case DataType.int:
      return TextInputType.numberWithOptions(
        signed: true,
      );
    case DataType.r4:
    case DataType.r8:
    case DataType.number:
    case DataType.fixed14_4:
    case DataType.float:
      return TextInputType.numberWithOptions(
        signed: true,
        decimal: true,
      );
    case DataType.date:
    case DataType.dateTime:
    case DataType.dateTimeTz:
    case DataType.time:
    case DataType.timeTz:
      return TextInputType.datetime;
    case DataType.uri:
      return TextInputType.url;
    default:
      return null;
  }
}

String? Function(String?)? _validator(DataType dataType) {
  switch (dataType) {
    case DataType.char:
      return (s) => s == null || s.length != 1 ? '*' : null;
    case DataType.binaryBase64:
      return (s) => s == null || !isBase64(s) ? '*' : null;
    case DataType.binaryHex:
      return (s) => s == null || !isHexadecimal(s) ? '*' : null;
    case DataType.uri:
      return (s) => s == null || Uri.tryParse(s) == null ? '*' : null;
    // TODO: Split out individually for each specific format
    case DataType.date:
    case DataType.dateTime:
    case DataType.dateTimeTz:
    case DataType.time:
    case DataType.timeTz:
      return (s) => s == null || DateTime.tryParse(s) == null ? '*' : null;
    case DataType.boolean:
      return (s) => s == null || !['true', 'false'].contains(s) ? '*' : null;
    case DataType.uuid:
      return (s) => s == null || !isUUID(s) ? '*' : null;
    // TODO: numerical constraints
    default:
      return (s) => s == null || s.length == 0 ? '*' : null;
  }
}

String? _defaultValue(DataType type) {
  switch (type) {
    case DataType.char:
    case DataType.string:
    case DataType.binaryBase64:
    case DataType.binaryHex:
    case DataType.uri:
      return null;
    case DataType.date:
      return '1985-04-12';
    case DataType.dateTime:
      return '1985-04-12T10:15:30';
    case DataType.dateTimeTz:
      return '1985-04-12T10:15:30+0400';
    case DataType.time:
      return '23:20:50';
    case DataType.timeTz:
      return '23:20:50+0100';
    case DataType.boolean:
      return 'true';
    case DataType.uuid:
      return '00000000-0000-0000-0000-000000000000';
    default:
      return '0';
  }
}
