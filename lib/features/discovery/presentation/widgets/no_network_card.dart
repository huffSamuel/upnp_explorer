import 'package:flutter/material.dart';
import 'package:open_settings_plus/core/open_settings_plus.dart';
import 'package:upnp_explorer/extension/build_context.dart';
import '../../../core/presentation/widgets/my_card.dart';
import '../../../core/presentation/widgets/my_icon.dart';

class NoNetworkErrorCard extends StatelessWidget {
  const NoNetworkErrorCard({super.key});

  @override
  Widget build(BuildContext context) {
    final i18n = context.i18n();

    return MyCard(
      highlight: Theme.of(context).colorScheme.error,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultTextStyle.merge(
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -.4,
                    ),
                    child: Text(i18n.networkDisabled),
                  ),
                  DefaultTextStyle.merge(
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
                      letterSpacing: -.2,
                    ),
                    child: Text(i18n.checkNetworkSettings),
                  )
                ],
              ),
              Spacer(),
              MyIcon(
                icon: Icons.signal_wifi_off_rounded,
                color: Theme.of(context).colorScheme.error,
                backgroundColor: Theme.of(context).colorScheme.errorContainer,
              ),
            ],
          ),
          SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(8),
                ),
              ),
              onPressed: () => switch (OpenSettingsPlus.shared) {
                OpenSettingsPlusAndroid settings => settings.wifi(),
                OpenSettingsPlusIOS settings => settings.wifi(),
                _ => throw Exception(i18n.platformNotSupported),
              },
              child: Text(i18n.openNetworkSettings),
            ),
          ),
        ],
      ),
    );
  }
}
