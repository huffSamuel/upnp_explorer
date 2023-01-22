import 'package:flutter/material.dart';

class AppPage extends StatelessWidget {
  final Widget title;
  final List<Widget> children;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  const AppPage({
    super.key,
    required this.title,
    required this.children,
    this.actions,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    print(theme.colorScheme);

    if (theme.useMaterial3) {
      return Scaffold(
        floatingActionButton: floatingActionButton,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar.large(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
                color: theme.colorScheme.onPrimary,
              ),
              title: FittedBox(
                child: DefaultTextStyle.merge(
                  style: TextStyle(color: theme.colorScheme.onPrimary),
                  child: title,
                ),
              ),
              actions: actions,
              foregroundColor: Colors.white,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => children[index],
                childCount: children.length,
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: title,
        elevation: 0,
      ),
      body: ListView(children: children),
    );
  }
}
