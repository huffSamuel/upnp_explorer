import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import 'logger_factory.dart';

@Singleton()
class DownloadService {
  final Logger logger;

  DownloadService(LoggerFactory loggerFactory)
      : logger = loggerFactory.build('DeviceDataService');

  Future<String> get(Uri uri) async {
    return download(uri.toString());
  }

  Future<String> download(String url) async {
    logger.debug('Downloading $url');

    final uri = Uri.parse(url);

    final response = await http.get(uri);

    return response.body;
  }
}
