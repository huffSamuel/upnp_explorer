import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../application/settings/settings.dart';
import '../../../../extension/build_context.dart';
import '../../../core/presentation/widgets/model_binding.dart';
import '../../../core/presentation/widgets/my_card.dart';
import '../../../core/presentation/widgets/page_title.dart';
import '../../../core/theme.dart';

class DisplaySettingsPage extends StatefulWidget {
  const DisplaySettingsPage({super.key});

  @override
  State<DisplaySettingsPage> createState() => _DisplaySettingsPageState();
}

class _DisplaySettingsPageState extends State<DisplaySettingsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final i18n = context.i18n();

    return Scaffold(
      appBar: AppBar(
        title: PageTitle(
          child: Text(i18n.settings),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 8),
            child: Text(
              i18n.displaySettings,
              style: TextTheme.of(context).bodyMedium!.copyWith(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -.3,
                  ),
            ),
          ),
          const SizedBox(height: 16),
          ThemeModeCard(),
          MyCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.sunny,
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      i18n.oledDark,
                      style: TextTheme.of(context).bodyMedium!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -.3,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: DefaultTextStyle.merge(
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: theme.hintColor,
                        ),
                        child: Text(
                          i18n.oledDarkDescription,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Switch(
                      value: Settings.of(context).oledDark,
                      onChanged: (value) {
                        final s = Settings.of(context);
                        Settings.update(context, s.copyWith(oledDark: value));
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class ThemeModeCard extends StatefulWidget {
  const ThemeModeCard({super.key});

  @override
  State<ThemeModeCard> createState() => _ThemeModeCardState();
}

class _ThemeModeCardState extends State<ThemeModeCard> {
  void _updateThemeMode(ThemeMode? value) {
    final v = ModelBinding.of<Settings>(context).copyWith(themeMode: value);
    ModelBinding.update<Settings>(context, v);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final i18n = context.i18n();
    final settings = Settings.of(context);
    final themeMode = settings.themeMode;

    return MyCard(
      padding: const EdgeInsets.all(16),
      child: RadioGroup<ThemeMode>(
        groupValue: themeMode,
        onChanged: (v) {
          _updateThemeMode(v);
        },
        child: Column(
          children: [
            Row(children: [
              Icon(
                Icons.palette,
                color: theme.colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                i18n.theme,
                style: TextTheme.of(context).bodyMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -.3,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ]),
            const SizedBox(height: 16),
            ThemeOption(
              title: Text(i18n.themeMode('light')),
              value: ThemeMode.light,
              child: ThemePreview(
                theme: AppTheme.light(),
              ),
            ),
            const SizedBox(height: 16),
            ThemeOption(
              title: Text(i18n.themeMode('dark')),
              value: ThemeMode.dark,
              child: ThemePreview(
                theme: AppTheme.dark(oled: settings.oledDark),
              ),
            ),
            const SizedBox(height: 16),
            ThemeOption(
              title: Text(i18n.themeMode('system')),
              value: ThemeMode.system,
              child: SystemThemePreview(),
            )
          ],
        ),
      ),
    );
  }
}

class SystemThemePreview extends StatelessWidget {
  const SystemThemePreview({super.key});

  @override
  Widget build(BuildContext context) {
    final oled = Settings.of(context).oledDark;
    final light = AppTheme.light();
    final dark = AppTheme.dark(oled: oled);

    return Row(
      children: [
        Expanded(
          child: ThemePreview(theme: light),
        ),
        Expanded(
          child: ThemePreview(theme: dark),
        ),
      ],
    );
  }
}

class ThemePreview extends StatelessWidget {
  final ThemeData theme;

  const ThemePreview({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        padding: const EdgeInsets.all(8),
        width: constraints.maxWidth,
        height: 100,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 10,
              width: math.min(constraints.maxWidth / 3, 50),
              constraints: BoxConstraints(minWidth: 25),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 10,
              width: math.min(constraints.maxWidth / 3, 75),
              constraints: BoxConstraints(minWidth: 50),
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurface,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 40,
              width: math.min(constraints.maxWidth / 1.5, 200),
              constraints: BoxConstraints(minWidth: 100),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                boxShadow: theme.brightness == Brightness.dark
                    ? null
                    : [
                        BoxShadow(
                          offset: Offset(0, 8),
                          blurRadius: 24,
                          color: Color.fromRGBO(25, 28, 29, 0.04),
                        ),
                      ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class ThemeOption extends StatelessWidget {
  final Widget title;
  final Widget child;
  final ThemeMode value;

  const ThemeOption({
    super.key,
    required this.title,
    required this.child,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final group = RadioGroup.maybeOf<ThemeMode>(context);

    return GestureDetector(
      onTap: () {
        group?.onChanged(value);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: value == group?.groupValue
                ? theme.colorScheme.primary
                : theme.dividerColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            child,
            const SizedBox(height: 4),
            Row(
              children: [
                Radio(value: value),
                title,
              ],
            )
          ],
        ),
      ),
    );
  }
}
