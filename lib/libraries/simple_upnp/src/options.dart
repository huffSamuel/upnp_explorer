part of simple_upnp;

const _osNameVar = '{os}';
const _verVar = '{ver}';
const _osTemplate = '{os}/{ver}';

class Options {
  /// Scan IPv4 addresses.
  final bool ipv4;

  /// Scan IPv6 addresses.
  final bool ipv6;

  /// Maximum network hops for multicast packages.
  final int multicastHops;

  // Maximum response delay.
  final int maxDelay;

  Options({
    this.ipv4 = true,
    this.ipv6 = true,
    this.multicastHops = 1,
    this.maxDelay = 3,
  });

  factory Options.base() {
    return Options(
      ipv4: true,
      ipv6: true,
      multicastHops: 1,
      maxDelay: 3,
    );
  }
}

class StaticOptions {
  final String operatingSystem;
  final String userAgent;
  final String locale;

  StaticOptions._(this.operatingSystem, this.userAgent, this.locale);

  static Future<StaticOptions> create() async {
    // TODO: Evaluate operating system
    // TODO: Evaluate user agent

    return StaticOptions._(
      await _resolveOS(),
      'simple_upnp/1.0',
      // TODO: Listen to locale changes
      Platform.localeName.substring(0, 2),
    );
  }
}

Future<String> _resolveOS() async {
  String os;
  String version;

  final plugin = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    final info = await plugin.androidInfo;
    os = 'Android';
    version = info.version.sdkInt.toString();
  } else if (Platform.isIOS) {
    final info = await plugin.iosInfo;
    os = 'iOS';
    version = info.systemVersion;
  } else if (Platform.isWindows) {
    final info = await plugin.windowsInfo;
    os = 'Windows';
    version = info.displayVersion;
  } else if (Platform.isMacOS) {
    final info = await plugin.macOsInfo;
    os = 'MacOS';
    version = info.osRelease;
  } else if (Platform.isLinux) {
    final info = await plugin.linuxInfo;
    os = 'Linux';
    version = info.version.toString();
  } else {
    throw PlatformNotSupportedError();
  }

  return replaceMany(_osTemplate, {_osNameVar: os, _verVar: version});
}

class PlatformNotSupportedError extends Error {}
