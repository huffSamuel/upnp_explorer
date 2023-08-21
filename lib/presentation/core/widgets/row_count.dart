import 'package:flutter/material.dart';

// Based on https://github.com/anilraok/row_overflow_count/blob/main/lib/row_overflow_count_computation_widget.dart

class RowCountOverflowed extends StatelessWidget {
  const RowCountOverflowed({
    Key? key,
    required this.labels,
  });

  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => _RowCount(
        labels: labels,
        width: constraints.maxWidth,
      ),
    );
  }
}

class _RowCount extends StatefulWidget {
  const _RowCount({
    Key? key,
    required this.labels,
    required this.width,
  }) : super(key: key);

  final List<String> labels;
  final double width;

  @override
  State<_RowCount> createState() => _RowCountState();
}

class _RowCountState extends State<_RowCount> {
  List<Widget> _rowItems = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _makeRowItems();
  }

  @override
  void didUpdateWidget(covariant _RowCount oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.width != widget.width || oldWidget.labels != widget.labels) {
      _makeRowItems();
    }
  }

  double calculateTextWidth(String text, {TextStyle? style}) {
    final effectiveStyle = style ?? DefaultTextStyle.fallback().style;

    final painter = TextPainter(
      text: TextSpan(text: text, style: effectiveStyle),
      textDirection: TextDirection.ltr,
      textScaleFactor: WidgetsBinding.instance.window.textScaleFactor,
    )..layout();

    return painter.size.width;
  }

  String _moreText(int remaining) {
    return '+$remaining more';
  }

  void _makeRowItems() {
    final moreText = _moreText(widget.labels.length);

    final overflowTextWidth = calculateTextWidth(moreText);

    final maxWidth = widget.width - overflowTextWidth;

    final items = <Widget>[];
    var currentWidth = 0.0;
    for (var i = 0; i < widget.labels.length; ++i) {
      final effectiveLabel = i == widget.labels.length - 1
          ? widget.labels[i]
          : widget.labels[i] + ', ';

      var localWidth = currentWidth +
          calculateTextWidth(
            effectiveLabel,
          );

      if (localWidth <= maxWidth) {
        currentWidth = localWidth;
        items.add(Text(
          effectiveLabel,
        ));
      }
    }

    final remaining = widget.labels.length - items.length;

    if (remaining > 0) {
      items.add(
        Text(
          _moreText(widget.labels.length - items.length),
        ),
      );
    }

    setState(() {
      _rowItems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Row(
        children: _rowItems,
      ),
    );
  }
}
