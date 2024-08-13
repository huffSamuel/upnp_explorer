import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommandsScreenshotWrapper extends StatelessWidget {
  final Image golden;

  const CommandsScreenshotWrapper({super.key, required this.golden});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
      home: Builder(
        builder: (context) {
          return Container(
            padding: const EdgeInsets.only(left: 64, right: 64, top: 64),
            child: ListView(
              children: [
                Text(
                  'Send Commands',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontSize: 54),
                ),
                const SizedBox(height: 64),
                DeviceFrame(
                  device: Devices.android.samsungGalaxyS20,
                  isFrameVisible: true,
                  orientation: Orientation.portrait,
                  screen: Container(
                    color: Color.fromRGBO(244, 251, 249, 1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 28,
                        ),
                        golden,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
