import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../application/application.dart';
import '../../../application/ioc.dart';
import '../../../application/l10n/generated/l10n.dart';
import '../../../application/settings/options.dart';
import '../../../domain/value_converter.dart';
import '../../../infrastructure/core/bug_report_service.dart';
import '../../changelog/widgets/changelog_dialog.dart';
import '../../core/widgets/model_binding.dart';
import '../../core/widgets/number_ticker.dart';
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

    return Scaffold(
      appBar: AppBar(title: Text(i18n.settings)),
      body: ListView(
        children: [
          SettingsCategoryTile(
            leading: Icon(Icons.display_settings),
            leadingBackgroundColor: Colors.amber[700],
            title: Text(i18n.display),
            subtitle: Text('${i18n.theme}, ${i18n.density}'),
            onTap: _nav(
              context,
              _DisplaySettingsPage(),
            ),
          ),
          SettingsCategoryTile(
            leading: Icon(Icons.wifi_tethering_rounded),
            leadingBackgroundColor: Colors.deepPurpleAccent,
            title: Text(i18n.discovery),
            subtitle: Text('${i18n.maxResponseDelay}, ${i18n.multicastHops}'),
            onTap: _nav(
              context,
              _ProtocolSettingsPage(),
            ),
          ),
          SettingsCategoryTile(
            leading: Icon(Icons.info_outline_rounded),
            leadingBackgroundColor: Colors.grey[700],
            title: Text(i18n.about),
            subtitle: Text(Application.name),
            onTap: _nav(
              context,
              _AboutSettingsPage(),
            ),
          ),
        ],
      ),
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
        MaterialSettingsTile(
          title: Text(i18n.theme),
          subtitle: Text(i18n.themeMode(options.themeMode)),
          leading: Icon(Icons.brightness_medium_outlined),
          onTap: _nav(
            context,
            _ThemeSettingsPage(),
          ),
        ),
        MaterialSettingsTile(
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
        SettingsAboutItem(child: Text(i18n.systemThemeDescription)),
        SettingsAboutItem(
          child: Text(i18n.darkThemeDescription),
          leading: Icon(Icons.info_outline_rounded),
        ),
      ],
    );
  }
}

class _ProtocolSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = S.of(context);
    final options = Options.of(context);

    return SettingsCategoryPage(category: i18n.discovery, children: [
      MaterialSettingsTile(
        title: Text(i18n.maxResponseDelay),
        leading: Icon(Icons.timer_outlined),
        subtitle: Text(i18n.responseDelay(options.protocolOptions.maxDelay)),
        onTap: _nav(context, _MaximumResponseDelayPage()),
      ),
      MaterialSettingsTile(
        title: Text(i18n.multicastHops),
        leading: Icon(Icons.network_ping_rounded),
        subtitle: Text(options.protocolOptions.hops.toString()),
        onTap: _nav(context, _MulticastHopsPage()),
      ),
    ]);
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
          SettingsAboutItem(
            child: Text(i18n.multicastHopsDescription),
            leading: Icon(Icons.info_outline_rounded),
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

    return WillPopScope(
      onWillPop: () {
        Options.update(
            context,
            options.copyWith(
                protocolOptions: options.protocolOptions
                    .copyWith(maxDelay: _delay, advanced: _advanced)));
        return Future.value(true);
      },
      child: SettingsCategoryPage(
        category: i18n.maxResponseDelay,
        children: [
          HighlightSwitchTile(
            title: Text(i18n.advancedMode),
            value: _advanced,
            activeColor: Theme.of(context).brightness == Brightness.dark
                ? Theme.of(context).appBarTheme.backgroundColor
                : Theme.of(context).toggleableActiveColor,
            onChanged: (v) => setState(
              () {
                if (_delay > 5 && !v) {
                  _delay = 5;
                }
                _advanced = v;
              },
            ),
          ),
          AnimatedCrossFade(
              firstChild: NumberTickerListTile(
                  minValue: 1,
                  title: Text(''),
                  onChanged: _setDelay,
                  value: _delay),
              secondChild: Slider(
                divisions: _advanced ? 19 : 4,
                value: _delay.toDouble(),
                onChanged: (v) => _setDelay(v.toInt()),
                label: i18n.responseDelay(_delay),
                min: 1,
                max: _advanced ? 20 : 5,
              ),
              crossFadeState: _advanced
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: Duration(milliseconds: 150)),
          SettingsAboutItem(
            child: Text(i18n.advancedModeWarning),
          ),
          SettingsAboutItem(
            child: Text(i18n.maxDelayDescription),
            leading: Icon(Icons.info_outline_rounded),
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

    return SettingsCategoryPage(category: i18n.about, children: [
      MaterialSettingsTile(
        leading: Icon(Icons.rate_review_outlined),
        title: Text(i18n.rateOnGooglePlay),
        subtitle: Text(i18n.letUsKnowHowWereDoing),
        onTap: () => InAppReview.instance
            .openStoreListing(appStoreId: Application.appId),
      ),
      MaterialSettingsTile(
        leading: Icon(Icons.history_rounded),
        title: Text(i18n.changelog),
        subtitle: VersionText(),
        onTap: () => showChangelogDialog(context),
      ),
      MaterialSettingsTile(
        leading: Icon(Icons.bug_report_outlined),
        title: Text(i18n.foundBug),
        subtitle: Text(i18n.openAnIssueOnOurGithub),
        onTap: () => _submitBug(context),
      ),
      SettingsDivider(),
      MaterialSettingsTile(
        leading: Icon(Icons.privacy_tip_outlined),
        title: Text(i18n.privacyPolicy),
        onTap: () => launchUrl(
          Uri.parse(
            Application.privacyPolicyUrl,
          ),
        ),
      ),
      MaterialSettingsTile(
        title: Text(i18n.licenses),
        onTap: _nav(
          context,
          LicensePage(),
        ),
      ),
      SettingsDivider(),
      SettingsAboutItem(
        child: Text(i18n.legalese),
        leading: Icon(Icons.info_outline_rounded),
      )
    ]);
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
