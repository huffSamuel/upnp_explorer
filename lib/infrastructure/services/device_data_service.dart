import 'package:http/http.dart' as http;

import 'logging/logger_factory.dart';

class DeviceDataService {
  final Logger logger;

  DeviceDataService(LoggerFactory loggerFactory)
      : logger = loggerFactory.build('DeviceDataService');

  Future<String> download(String url) async {
    logger.debug('Downloading $url');

    final uri = Uri.parse(url);

    final response = await http.get(uri);

    return response.body;
  }
}
