import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:upnp_explorer/features/core/dark.dart';
import 'package:upnp_explorer/features/core/light.dart';
import '../../../../application/settings/settings.dart';
import '../../../core/presentation/widgets/model_binding.dart';

import '../../../../application/settings/palette.dart';
import '../../../core/presentation/widgets/my_bottom_app_bar.dart';
import '../../../core/presentation/widgets/my_card.dart';
import '../../../core/presentation/widgets/page_title.dart';

class DisplaySettingsPage extends StatefulWidget {
  @override
  State<DisplaySettingsPage> createState() => _DisplaySettingsPageState();
}

class _DisplaySettingsPageState extends State<DisplaySettingsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: PageTitle(
          child: Text('Settings'),
        ),
      ),
      bottomNavigationBar: MyBottomAppBar(currentIndex: 2),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 8),
            child: Text(
              'Display Settings',
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
                      'OLED Dark',
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
                          'Use a pure black background in dark mode to save power and increase contrast.',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Switch(
                      value: false,
                      onChanged: (_) {},
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
    final themeMode = ModelBinding.of<Settings>(context).themeMode;

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
                'Theme',
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
              title: Text('Light'),
              value: ThemeMode.light,
              child: ThemePreview(
                theme: PrecisionObserverTheme.lightTheme,
              ),
            ),
            const SizedBox(height: 16),
            ThemeOption(
              title: Text('Dark'),
              value: ThemeMode.dark,
              child: ThemePreview(
                theme: PrecisionObserverDarkTheme.darkTheme,
              ),
            ),
            const SizedBox(height: 16),
            ThemeOption(
              title: Text('System'),
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
  @override
  Widget build(BuildContext context) {
    final light = AppTheme.light(null, VisualDensity.standard);
    final dark = AppTheme.dark(null, VisualDensity.standard);

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
