import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../application/logger_factory.dart';

@Singleton()
class DownloadService {
  final Logger logger;

  DownloadService(LoggerFactory loggerFactory)
      : logger = loggerFactory.build('DeviceDataService');

  String _currentLanguage() {
    return Platform.localeName.substring(0, 2);
  }

  Future<http.Response?> get(Uri uri) async {
    return download(uri.toString());
  }

  Future<http.Response?> download(String url) async {
    logger.debug('Downloading $url');

    try {
      final uri = Uri.parse(url);

      final response = await http.get(uri, headers: {
        'ACCEPT-LANGUAGE': _currentLanguage(),
      });

      return response;
    } catch (err) {
      logger.error('Unable to download $url: $err');
      return null;
    }
  }
}
