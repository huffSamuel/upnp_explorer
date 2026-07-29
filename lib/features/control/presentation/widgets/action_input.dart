import 'package:flutter/material.dart';
import 'package:upnped/upnped.dart';

import '../../../../application/validators.dart';

class DataTypeConfig {
  final String? Function(String?)? validator;
  final TextInputType? inputType;

  DataTypeConfig(
    this.validator,
    this.inputType,
  );

  static Map<DataTypeValue?, DataTypeConfig> values = {
    for (var e in DataTypeValue.values) e: fromDataType(e)
  };

  static DataTypeConfig fromDataType(DataTypeValue type) {
    return DataTypeConfig(
      _validator(type),
      _inputType(type),
    );
  }
}

TextInputType? _inputType(DataTypeValue type) {
  switch (type) {
    case DataTypeValue.ui1:
    case DataTypeValue.ui2:
    case DataTypeValue.ui4:
    case DataTypeValue.ui8:
      return TextInputType.number;
    case DataTypeValue.i1:
    case DataTypeValue.i2:
    case DataTypeValue.i4:
    case DataTypeValue.i8:
    case DataTypeValue.int:
      return TextInputType.numberWithOptions(
        signed: true,
      );
    case DataTypeValue.r4:
    case DataTypeValue.r8:
    case DataTypeValue.number:
    case DataTypeValue.fixed_14_4:
    case DataTypeValue.float:
      return TextInputType.numberWithOptions(
        signed: true,
        decimal: true,
      );
    case DataTypeValue.date:
    case DataTypeValue.dateTime:
    case DataTypeValue.dateTime_tz:
    case DataTypeValue.time:
    case DataTypeValue.time_tz:
      return TextInputType.datetime;
    case DataTypeValue.uri:
      return TextInputType.url;
    default:
      return null;
  }
}

String? Function(String?)? _validator(DataTypeValue dataType) {
  switch (dataType) {
    case DataTypeValue.char:
      return Validators.isChar;
    case DataTypeValue.bin_base64:
      return Validators.isBase64;
    case DataTypeValue.bin_hex:
      return Validators.isHexadecimal;
    case DataTypeValue.uri:
      return Validators.isURI;
    // TODO: Split out individually for each specific format
    case DataTypeValue.date:
    case DataTypeValue.dateTime:
    case DataTypeValue.dateTime_tz:
    case DataTypeValue.time:
    case DataTypeValue.time_tz:
      return Validators.isDateTime;
    case DataTypeValue.boolean:
      return Validators.isBoolean;
    case DataTypeValue.uuid:
      return Validators.isUUID;
    // TODO: numerical constraints
    default:
      return (s) => s == null || s.isEmpty ? '*' : null;
  }
}
