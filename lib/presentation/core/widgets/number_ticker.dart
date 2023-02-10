import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class NumberTicker extends StatelessWidget {
  final int? minValue;
  final int? maxValue;
  final int value;
  final Function(int) onChanged;

  const NumberTicker({
    Key? key,
    required this.onChanged,
    this.value = 0,
    this.minValue,
    this.maxValue,
  }) : super(key: key);

  bool get _downEnabled => minValue == null || value > minValue!;
  bool get _upEnabled => maxValue == null || value < maxValue!;

  get _up => _upEnabled ? () => onChanged(value + 1) : null;
  get _down => _downEnabled ? () => onChanged(value - 1) : null;

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return Row(
      children: [
        IconButton(
          tooltip: _downEnabled ? i18n.decrease : i18n.decreaseDisabled,
          icon: Icon(Icons.remove),
          onPressed: _down,
        ),
        Text(value.toString(), style: Theme.of(context).textTheme.headline5),
        IconButton(
          tooltip: _upEnabled ? i18n.increase : i18n.increaseDisabled,
          icon: Icon(Icons.add),
          onPressed: _up,
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }
}

class NumberTickerListTile extends StatelessWidget {
  final Widget title;
  final EdgeInsets titlePadding;
  final int? minValue;
  final int? maxValue;
  final int value;
  final Function(int) onChanged;

  const NumberTickerListTile({
    Key? key,
    this.minValue,
    this.maxValue,
    required this.value,
    required this.onChanged,
    required this.title,
    this.titlePadding = const EdgeInsets.only(left: 16.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: titlePadding,
          child: title,
        ),
        NumberTicker(
          value: value,
          minValue: minValue,
          maxValue: maxValue,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
