import 'package:flutter/material.dart';

class HighlightSwitchTile extends StatelessWidget {
  final Widget title;
  final bool value;
  final Color? activeColor;
  final void Function(bool)? onChanged;

  const HighlightSwitchTile(
      {required this.title,
      required this.value,
      this.onChanged,
      this.activeColor});

  Color _color(BuildContext context) {
    if (!value) {
      return Theme.of(context).disabledColor;
    }

    return activeColor ?? Theme.of(context).toggleableActiveColor;
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      color: _color(context),
      child: SwitchSettingsTile(
        activeColor: Colors.white,
        title: DefaultTextStyle.merge(
          child: title,
          style: TextStyle(color: Colors.white),
        ),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}

class SwitchSettingsTile extends StatelessWidget {
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final bool value;
  final void Function(bool)? onChanged;
  final Color? activeColor;

  const SwitchSettingsTile({
    this.leading,
    required this.title,
    required this.value,
    this.onChanged,
    this.subtitle,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return _SettingsTile(
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: activeColor,
      ),
    );
  }
}

class SettingsCategoryTile extends StatelessWidget {
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final VoidCallback? onTap;
  final Color? leadingBackgroundColor;
  final Color? leadingForegroundColor;

  const SettingsCategoryTile({
    Key? key,
    this.leading,
    this.leadingBackgroundColor,
    this.leadingForegroundColor,
    required this.title,
    this.subtitle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? effectiveLeading;

    if (leading != null && leadingBackgroundColor != null) {
      effectiveLeading = CircleAvatar(
        backgroundColor: leadingBackgroundColor,
        foregroundColor: leadingForegroundColor ?? Colors.white,
        child: leading,
      );
    } else if (leading != null) {
      effectiveLeading = leading;
    }

    return ListTile(
      leading: effectiveLeading,
      title: title,
      subtitle: subtitle ?? const Text(''),
      onTap: onTap,
    );
  }
}

class MaterialSettingsTile extends StatelessWidget {
  final Widget title;
  final Widget? leading;
  final Widget? subtitle;
  final VoidCallback onTap;

  const MaterialSettingsTile({
    required this.title,
    required this.onTap,
    this.leading,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return _SettingsTile(
      title: title,
      subtitle: subtitle,
      leading: leading,
      onTap: onTap,
    );
  }
}

class SettingsAboutItem extends StatelessWidget {
  final Widget child;
  final Widget? leading;

  const SettingsAboutItem({
    this.leading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return _SettingsTile(
      title: Container(height: 12.0),
      subtitle: DefaultTextStyle(
        child: child,
        style: theme.textTheme.bodyText2!.copyWith(color: theme.disabledColor),
      ),
      leading: leading,
      centerLeading: false,
    );
  }
}

class SettingsDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(thickness: 2.0);
  }
}

class _SettingsTile extends StatelessWidget {
  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool centerLeading;

  const _SettingsTile({
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

  Widget effectiveLeading() {
    final _leading = leading ?? const Icon(null);

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
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      leading: effectiveLeading(),
      onTap: onTap,
    );
  }
}
