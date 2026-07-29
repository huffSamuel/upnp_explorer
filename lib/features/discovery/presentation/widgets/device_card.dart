import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:upnped/upnped.dart';

import '../../../../../application/routing/routes.dart';
import '../../../core/presentation/widgets/my_card.dart';
import '../pages/device_info_page.dart';
import 'device_image.dart';

class DeviceCard extends StatelessWidget {
  final Device device;
  final int depth;

  const DeviceCard({
    super.key,
    required this.device,
    this.depth = 1,
  });

  @override
  Widget build(BuildContext context) {
    return MyCard(
      onTap: () => context.push('/device/${device.description.udn}'),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              DeviceImage2(
                device: device.description,
                deviceIp: device.notify?.location,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    device.description.friendlyName,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 20, letterSpacing: -.25),
                  ),
                  if (device.notify != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: IpAddressChip(host: device.notify!.location!.host),
                    ),
                ],
              ),
            ),
            SizedBox(width: 12),
            Align(
              alignment: Alignment.center,
              child: Icon(Icons.chevron_right),
            ),
          ],
        ),
      ),
    );
  }
}

class IpAddressChip extends StatelessWidget {
  final String host;

  const IpAddressChip({super.key, required this.host});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(4)),
      child: DefaultTextStyle.merge(
        child: Text(host),
        style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
            letterSpacing: -.3),
      ),
    );
  }
}
