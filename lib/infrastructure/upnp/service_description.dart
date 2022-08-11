import 'package:xml/xml.dart';

import 'device.dart';

class ServiceDescription {
  final String namespace;
  final SpecVersion specVersion;
  final ActionList actionList;
  final ServiceStateTable serviceStateTable;

  ServiceDescription({
    required this.namespace,
    required this.specVersion,
    required this.actionList,
    required this.serviceStateTable,
  });

  static fromXml(XmlDocument xml) {
    final root = xml.getElement('scpd');

    return ServiceDescription(
      namespace: root!.getAttribute('xmlns')!,
      specVersion: SpecVersion.fromXml(root.getElement('specVersion')!),
      actionList: ActionList.fromXml(root.getElement('actionList')),
      serviceStateTable:
          ServiceStateTable.fromXml(root.getElement('serviceStateTable')!),
    );
  }
}

class ServiceStateTable {
  final List<_StateVariable> stateVariables;

  ServiceStateTable({
    required this.stateVariables,
  });

  static fromXml(XmlNode xml) {
    return ServiceStateTable(
      stateVariables: listOf<_StateVariable>(
          xml, 'stateVariable', (x) => _StateVariable.fromXml(x)),
    );
  }
}

class ActionList {
  final List<Action> actions;

  ActionList({
    required this.actions,
  });

  static fromXml(XmlNode? xml) {
    return ActionList(
        actions: listOf<Action>(xml, 'action', (x) => Action.fromXml(x)));
  }
}

class Action {
  final String name;
  final _ArgumentList? argumentList;

  Action({
    required this.name,
    this.argumentList,
  });

  static fromXml(XmlNode xml) {
    return Action(
      name: xml.getElement('name')!.text,
      argumentList: _ArgumentList.fromXml(xml.getElement('argumentList')),
    );
  }
}

class _ArgumentList {
  final List<_Argument> arguments;

  _ArgumentList({
    required this.arguments,
  });

  static fromXml(XmlNode? xml) {
    return _ArgumentList(
      arguments: listOf<_Argument>(
        xml,
        'argument',
        (x) => _Argument.fromXml(x),
      ),
    );
  }
}

class _DataType {
  static fromXml(XmlNode xml) {
    return _DataType();
  }
}

class _Argument {
  final String name;
  final String direction;
  final String? retval;
  final String relatedStateVariable;

  _Argument({
    required this.name,
    required this.direction,
    this.retval,
    required this.relatedStateVariable,
  });

  static fromXml(XmlNode xml) {
    return _Argument(
      name: xml.getElement('name')!.text,
      direction: xml.getElement('direction')!.text,
      retval: xml.getElement('retval')?.text,
      relatedStateVariable: xml.getElement('relatedStateVariable')!.text,
    );
  }
}

class _StateVariable {
  final bool? sendEvents;
  final bool? multicast;
  final String name;
  final _DataType dataType;
  final String? defaultValue;
  final _AllowedValueList? allowedValueList;
  final _AllowedValueRange? allowedValueRange;

  _StateVariable({
    this.sendEvents,
    this.multicast,
    required this.name,
    required this.dataType,
    this.defaultValue,
    this.allowedValueList,
    this.allowedValueRange,
  });

  static fromXml(XmlNode xml) {
    final sendEvents = xml.getAttribute('sendEvents');
    final multicast = xml.getAttribute('multicast');
    final allowedValueRange = xml.getElement('allowedValueRange');

    return _StateVariable(
      sendEvents: sendEvents != null ? sendEvents == 'yes' : false,
      multicast: multicast != null ? multicast == 'yes' : false,
      name: xml.getElement('name')!.text,
      dataType: _DataType.fromXml(xml.getElement('dataType')!),
      defaultValue: xml.getElement('defaultValue')?.text,
      allowedValueList:
          _AllowedValueList.fromXml(xml.getElement('allowedValueList')),
      allowedValueRange: allowedValueRange != null
          ? _AllowedValueRange.fromXml(allowedValueRange)
          : null,
    );
  }
}

// TODO: Enum values in new Flutter
enum DataType {
  /// Unsigned 1 byte int. Same format as {int} but without the leading sign.
  ui1,

  /// Unsigned 2 byte int. Same format as {int} but without the leading sign.
  ui2,

  /// Unsigned 4 byte int. Same format as {int} but without the leading sign.
  ui4,

  /// Unsigned 8 byte int. Same format as {int} but without the leading sign.
  ui8,

  /// 1 byte int. Same format as {int}.
  i1,

  /// 2 byte int. Same format as {int}.
  i2,

  /// 4 byte int. Same format as {int}.
  ///
  /// Shall be between `-2147483648` and `2147483647`.
  i4,

  /// 8 Byte int. Same format as int.
  ///
  /// Shall be between `−9,223,372,036,854,775,808` and `9,223,372,036,854,775,807`.
  i8,

  /// Fixed point, integer number. Is allowed to have leading zeros, which should be ignored
  /// by the recipient. (No currency symbol and no grouping of digits)
  int,

  /// 4 byte float. Same format as float.
  ///
  /// Shall be between `3.40282347E+38` to `1.17549435E-38`.
  r4,

  /// 8 byte float. Same format as float.
  ///
  /// Shall be between `-1.79769313486232E308` and `-4.94065645841247E-324` for negative values.
  /// Shall be between `4.94065645841247E-324` and `1.79769313486232E308` for positive values.
  ///
  /// See: IEEE 64-bit (8-Byte) double
  r8,

  /// Same as {r8}.
  number,

  /// Same as {r8} but with no more than 14 digits to the left of the decimal point
  /// and no more than 4 to the right.
  fixed14_4,

  /// Floating point number.
  ///
  /// Mantissa and/or exponent is allowed to have a leading sign and leading zeros.
  ///
  /// Decimal character in mantissa is a period `"."`.
  ///
  /// Mantissa separated from exponent by `"E"`.
  float,

  /// Unicode string; one character long.
  char,

  /// Unicode string; no limit on length.
  string,

  /// Date in a subset of ISO 8601 format without time data.
  date,

  /// Date in ISO 8601 format with allowed time but no time zone.
  dateTime,

  /// Date in ISO 8601 format with allowed time and time zone.
  dateTimeTz,

  /// Time in a subset of ISO 8601 format with neither date nor time zone.
  time,

  /// Time in a subset of ISO 8601 format with no date.
  timeTz,

  /// `"0"` for false or `"1"` for true.
  boolean,

  /// MIME-style Base64 encoded binary BLOB.
  binaryBase64,

  /// Hexadecimal digits represented by octets.
  binaryHex,

  /// Universal Resource Identifier.
  uri,

  /// Universally Unique ID.
  uuid
}

class _AllowedValueRange {
  final String minimum;
  final String maximum;
  final String? step;

  _AllowedValueRange({
    required this.minimum,
    required this.maximum,
    this.step,
  });

  static fromXml(XmlNode xml) {
    return _AllowedValueRange(
      minimum: xml.getElement('minimum')!.text,
      maximum: xml.getElement('maximum')!.text,
      step: xml.getElement('step')?.text,
    );
  }
}

class _AllowedValueList {
  final List<String> allowedValues;

  _AllowedValueList({
    required this.allowedValues,
  });

  static fromXml(XmlNode? xml) {
    return _AllowedValueList(
      allowedValues: listOf<String>(xml, 'allowedValue', (p0) => p0.text),
    );
  }
}
