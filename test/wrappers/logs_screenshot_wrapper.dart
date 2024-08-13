import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogsScreenshotWrapper extends StatelessWidget {
  final Image golden;

  const LogsScreenshotWrapper({super.key, required this.golden});

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
            padding: const EdgeInsets.only(top: 64),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 64.0),
                  child: Text(
                    'Monitory Your Network',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(fontSize: 58),
                  ),
                ),
                const SizedBox(height: 64),
                Transform.translate(
                  offset: Offset(150, 0),
                  child: DeviceFrame(
                    device: Devices.android.samsungGalaxyS20,
                    isFrameVisible: true,
                    orientation: Orientation.portrait,
                    screen: Container(
                      color: Color.fromRGBO(24, 38, 36, 1),
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
