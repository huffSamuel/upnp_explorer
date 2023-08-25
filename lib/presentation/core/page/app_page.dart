import 'package:flutter/material.dart';

class AppPage extends StatelessWidget {
  final Widget title;
  final List<Widget> children;
  final List<Widget>? actions;
  final Widget? bottomNavigationBar;

  const AppPage({
    super.key,
    required this.title,
    required this.children,
    this.actions,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (children.length == 1) {
      child = SliverFillRemaining(child: children[0]);
    } else {
      child = SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => children[index],
          childCount: children.length,
        ),
      );
    }

    return Scaffold(
      bottomNavigationBar: bottomNavigationBar,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar.medium(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: FittedBox(
              child: title,
            ),
            actions: actions,
          ),
          child,
        ],
      ),
    );
  }
}
