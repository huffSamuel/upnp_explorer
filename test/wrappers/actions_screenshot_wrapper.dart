import 'package:flutter/material.dart';
import 'package:device_frame/device_frame.dart';
import 'package:google_fonts/google_fonts.dart';

class LowerSplitClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class ActionsScreenshotWrapper extends StatelessWidget {
  final Image light;
  final Image dark;

  const ActionsScreenshotWrapper({
    super.key,
    required this.light,
    required this.dark,
  });

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
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.black,
                ],
              ),
            ),
            padding: const EdgeInsets.only(left: 64, right: 64, top: 24),
            child: Column(
              children: [
                Text(
                  'Light',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontSize: 58),
                ),
                const SizedBox(height: 32),
                DeviceFrame(
                  device: Devices.android.samsungGalaxyS20,
                  isFrameVisible: true,
                  orientation: Orientation.portrait,
                  screen: Container(
                    color: Color.fromRGBO(221, 236, 235, 1),
                    padding: const EdgeInsets.only(top: 22),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        light,
                        ClipPath(
                          clipper: LowerSplitClipper(),
                          child: dark,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'And Dark',
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontSize: 58,
                        color: Colors.white,
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
