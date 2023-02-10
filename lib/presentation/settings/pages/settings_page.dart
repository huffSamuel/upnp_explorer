import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../application/application.dart';
import '../../../application/device.dart';
import '../../../application/ioc.dart';
import '../../../application/l10n/generated/l10n.dart';
import '../../../application/routing/routes.dart';
import '../../../application/settings/options.dart';
import '../../../domain/value_converter.dart';
import '../../../infrastructure/core/bug_report_service.dart';
import '../../core/page/app_page.dart';
import '../../core/widgets/model_binding.dart';
import '../../core/widgets/number_ticker.dart';
import '../widgets/settings/about_tile.dart';
import '../widgets/settings/category_tile.dart';
import '../widgets/settings/highlight_switch_tile.dart';
import '../widgets/settings/switch_tile.dart';
import '../widgets/settings_category_page.dart';
import '../widgets/settings_category_tile.dart';

Function() _nav(BuildContext context, Widget page) {
  return () =>
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
}

class MaterialDesignSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = S.of(context);

    final children = <Widget>[
      CategoryTile(
        leading: Icon(Icons.display_settings),
        leadingBackgroundColor: Colors.amber[700],
        title: Text(i18n.display),
        subtitle: Text('${i18n.theme}, ${i18n.density}'),
        onTap: _nav(
          context,
          _DisplaySettingsPage(),
        ),
      ),
      CategoryTile(
        leading: Icon(Icons.wifi_tethering_rounded),
        leadingBackgroundColor: Colors.deepPurpleAccent,
        title: Text(i18n.discovery),
        subtitle: Text('${i18n.maxResponseDelay}, ${i18n.multicastHops}'),
        onTap: _nav(
          context,
          _ProtocolSettingsPage(),
        ),
      ),
      CategoryTile(
        leading: Icon(Icons.info_outline_rounded),
        leadingBackgroundColor: Colors.grey[700],
        title: Text(i18n.about),
        subtitle: Text(Application.name),
        onTap: _nav(
          context,
          _AboutSettingsPage(),
        ),
      ),
    ];

    return AppPage(
      title: Text(i18n.settings),
      children: children,
    );
  }
}

class _DisplaySettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = S.of(context);
    final options = ModelBinding.of<Options>(context);

    return SettingsCategoryPage(
      category: i18n.display,
      children: [
        SettingsTile(
          title: Text(i18n.theme),
          subtitle: Text(i18n.themeMode(options.themeMode)),
          leading: Icon(Icons.brightness_medium_outlined),
          onTap: _nav(
            context,
            _ThemeSettingsPage(),
          ),
        ),
        SettingsTile(
          title: Text(i18n.density),
          leading: Icon(Icons.density_medium_rounded),
          subtitle: Text(
            i18n.visualDensity(
              kVisualDensityConverter.from(
                options.visualDensity,
              ),
            ),
          ),
          onTap: _nav(context, _VisualDensityPage()),
        ),
        if (sl<DeviceInfo>().supportsMaterial3)
          SettingsTile(
            title: Text('Adaptive layout'),
            leading: Icon(Icons.layers_outlined),
            subtitle: Text(options.material3 ? i18n.on : i18n.off),
            onTap: _nav(
              context,
              _AdaptiveLayoutPage(),
            ),
          ),
      ],
    );
  }
}

class _AdaptiveLayoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final value = Options.of(context).material3;

    return SettingsCategoryPage(
      category: 'Adaptive layout',
      children: [
        SwitchTile(
          title: Text('Adaptive Layout'),
          value: value,
          onChanged: (v) {
            final options = Options.of(context);

            Options.update(
              context,
              options.copyWith(material3: v),
            );
          },
        ),
        AboutTile(
          child: Text(
            'Adapt the layout and color scheme of the app to the platform\'s operating system and dynamic color settings.',
          ),
        ),
      ],
    );
  }
}

class _VisualDensityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = S.of(context);
    final options = Options.of(context);

    final currentValue = kVisualDensityConverter.from(options.visualDensity);

    final density = Density.values
        .map(
          (value) => RadioListTile(
            value: value,
            groupValue: currentValue,
            onChanged: (Density? v) {
              if (v == null) {
                return;
              }

              Options.update(
                context,
                options.copyWith(visualDensity: kVisualDensityConverter.to(v)),
              );
            },
            title: Text(i18n.visualDensity(value)),
          ),
        )
        .toList();

    return SettingsCategoryPage(
      category: i18n.density,
      children: density,
    );
  }
}

class _ThemeSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = S.of(context);
    final options = Options.of(context);

    final themes = ThemeMode.values
        .map(
          (value) => RadioListTile(
            value: value,
            groupValue: options.themeMode,
            onChanged: (ThemeMode? v) {
              if (v == null) {
                return;
              }

              Options.update(
                context,
                options.copyWith(themeMode: v),
              );
            },
            title: Text(i18n.themeMode(value)),
          ),
        )
        .toList();

    return SettingsCategoryPage(
      category: i18n.theme,
      children: [
        ...themes,
        SettingsDivider(),
        AboutTile(
          child: Text.rich(
            TextSpan(
              text: i18n.systemThemeDescription,
              children: [
                TextSpan(text: '\r\n\r\n'),
                TextSpan(
                  text: i18n.darkThemeDescription,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _ProtocolSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = S.of(context);
    final options = Options.of(context);

    return SettingsCategoryPage(
      category: i18n.discovery,
      children: [
        SettingsTile(
          title: Text(i18n.maxResponseDelay),
          leading: Icon(Icons.timer_outlined),
          subtitle: Text(i18n.responseDelay(options.protocolOptions.maxDelay)),
          onTap: _nav(context, _MaximumResponseDelayPage()),
        ),
        SettingsTile(
          title: Text(i18n.multicastHops),
          leading: Icon(Icons.network_ping_rounded),
          subtitle: Text(options.protocolOptions.hops.toString()),
          onTap: _nav(context, _MulticastHopsPage()),
        ),
        SettingsTile(
          title: Text(i18n.advancedMode),
          leading: Icon(Icons.admin_panel_settings_outlined),
          subtitle: Text(options.protocolOptions.advanced ? i18n.on : i18n.off),
          onTap: _nav(context, _AdvancedModePage()),
        ),
      ],
    );
  }
}

class _AdvancedModePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final options = Options.of(context);
    final i18n = S.of(context);

    return SettingsCategoryPage(
      category: i18n.advancedMode,
      children: [
        const SizedBox(height: 20),
        HighlightSwitchTile(
          title: Text(i18n.advancedMode),
          value: options.protocolOptions.advanced,
          onChanged: (v) => Options.update(
            context,
            options.copyWith(
              protocolOptions: options.protocolOptions.copyWith(
                advanced: v,
              ),
            ),
          ),
        ),
        AboutTile(
          child: Text(i18n.advancedModeWarning),
        ),
      ],
    );
  }
}

class _MulticastHopsPage extends StatefulWidget {
  @override
  State<_MulticastHopsPage> createState() => _MulticastHopsPageState();
}

class _MulticastHopsPageState extends State<_MulticastHopsPage> {
  late int _hops;
  @override
  void didChangeDependencies() {
    _hops = Options.of(context).protocolOptions.hops;
    super.didChangeDependencies();
  }

  _setHops(int hops) {
    setState(() {
      _hops = hops;
    });
  }

  @override
  Widget build(BuildContext context) {
    final i18n = S.of(context);
    final options = Options.of(context);

    return WillPopScope(
      onWillPop: () {
        Options.update(
          context,
          options.copyWith(
            protocolOptions: options.protocolOptions.copyWith(hops: _hops),
          ),
        );
        return Future.value(true);
      },
      child: SettingsCategoryPage(
        category: i18n.multicastHops,
        children: [
          NumberTickerListTile(
            title: SizedBox(height: 8.0),
            value: _hops,
            minValue: 1,
            onChanged: _setHops,
          ),
          SettingsDivider(),
          AboutTile(
            child: Text(i18n.multicastHopsDescription),
          ),
        ],
      ),
    );
  }
}

class _MaximumResponseDelayPage extends StatefulWidget {
  @override
  State<_MaximumResponseDelayPage> createState() =>
      _MaximumResponseDelayPageState();
}

class _MaximumResponseDelayPageState extends State<_MaximumResponseDelayPage> {
  late int _delay;
  late bool _advanced;

  @override
  void didChangeDependencies() {
    final options = Options.of(context).protocolOptions;
    _delay = options.maxDelay;
    _advanced = options.advanced;
    super.didChangeDependencies();
  }

  void _setDelay(int delay) {
    setState(() {
      _delay = delay;
    });
  }

  @override
  Widget build(BuildContext context) {
    final i18n = S.of(context);
    final options = Options.of(context);
    final advanced = options.protocolOptions.advanced;

    return WillPopScope(
      onWillPop: () {
        Options.update(
          context,
          options.copyWith(
            protocolOptions: options.protocolOptions.copyWith(
              maxDelay: _delay,
              advanced: _advanced,
            ),
          ),
        );
        return Future.value(true);
      },
      child: SettingsCategoryPage(
        category: i18n.maxResponseDelay,
        children: [
          if (advanced)
            NumberTickerListTile(
              minValue: 1,
              title: Text(''),
              onChanged: _setDelay,
              value: _delay,
            ),
          if (!advanced)
            Slider(
              divisions: _advanced ? 19 : 4,
              value: _delay.toDouble(),
              onChanged: (v) => _setDelay(v.toInt()),
              label: i18n.responseDelay(_delay),
              min: 1,
              max: _advanced ? 20 : 5,
            ),
          AboutTile(
            child: Text(i18n.maxDelayDescription),
          ),
        ],
      ),
    );
  }
}

class _AboutSettingsPage extends StatelessWidget {
  void _submitBug(BuildContext c) async {
    final i18n = S.of(c);
    final bugService = sl<BugReportService>();
    final info = await PackageInfo.fromPlatform();

    bugService.submitBug(
      i18n.mailSubject,
      i18n.mailBody(info.version),
      () {
        final snackbar = SnackBar(
          content: Text(i18n.unableToSubmitFeedback),
        );
        ScaffoldMessenger.of(c).showSnackBar(snackbar);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final i18n = S.of(context);

    return SettingsCategoryPage(
      category: i18n.about,
      children: [
        SettingsTile(
          leading: Icon(Icons.rate_review_outlined),
          title: Text(i18n.rateOnGooglePlay),
          subtitle: Text(i18n.letUsKnowHowWereDoing),
          onTap: () => InAppReview.instance
              .openStoreListing(appStoreId: Application.appId),
        ),
        SettingsTile(
          leading: Icon(Icons.history_rounded),
          title: Text(i18n.changelog),
          subtitle: VersionText(),
          onTap: () => Application.router!.navigateTo(
            context,
            Routes.changelog,
          ),
        ),
        SettingsTile(
          leading: Icon(Icons.bug_report_outlined),
          title: Text(i18n.foundBug),
          subtitle: Text(i18n.openAnIssueOnOurGithub),
          onTap: () => _submitBug(context),
        ),
        SettingsDivider(),
        SettingsTile(
          leading: Icon(Icons.privacy_tip_outlined),
          title: Text(i18n.privacyPolicy),
          onTap: () => launchUrl(
            Uri.parse(
              Application.privacyPolicyUrl,
            ),
          ),
        ),
        SettingsTile(
          title: Text(i18n.licenses),
          onTap: _nav(
            context,
            LicensePage(),
          ),
        ),
        SettingsDivider(),
        AboutTile(
          child: Text(i18n.legalese),
        )
      ],
    );
  }
}

class VersionText extends StatefulWidget {
  @override
  State<VersionText> createState() => _VersionTextState();
}

class _VersionTextState extends State<VersionText> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then(
      (info) => setState(
        () {
          _version = S.of(context).version(info.version);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(_version);
  }
}
