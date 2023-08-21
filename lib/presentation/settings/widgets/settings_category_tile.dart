import 'package:flutter/material.dart';

class SettingsDivider extends StatelessWidget {
  const SettingsDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(thickness: 2.0);
  }
}

class SettingsTile extends StatelessWidget {
  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool centerLeading;

  const SettingsTile({
    this.title,
    this.subtitle,
    this.leading,
    this.onTap,
    this.trailing,
    this.centerLeading = true,
  });

  MainAxisAlignment _effectiveAlignment() {
    if (centerLeading) {
      return MainAxisAlignment.center;
    }

    return MainAxisAlignment.start;
  }

  Widget _effectiveLeading(BuildContext context) {

    final _leading = CircleAvatar(
      child: leading ?? const Icon(null),
      backgroundColor: Colors.transparent,
      foregroundColor: Theme.of(context).colorScheme.onBackground,
    );

    if (!centerLeading) {
      return _leading;
    }

    return Column(
      mainAxisAlignment: _effectiveAlignment(),
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [_leading],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: DefaultTextStyle.merge(
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontWeight: FontWeight.w400),
        child: title ?? const SizedBox(),
      ),
      subtitle: subtitle,
      trailing: trailing,
      leading: _effectiveLeading(context),
      onTap: onTap,
    );
  }
}
