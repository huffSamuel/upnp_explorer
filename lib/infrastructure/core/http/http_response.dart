import 'dart:io';

import 'package:http/http.dart';
import 'package:upnp_explorer/infrastructure/core/http/http.dart';

/// An HTTP response where the response body is received asynchronously after
/// the headers have been received.
class MyStreamedResponse extends StreamedResponse {
  final HttpClientResponse? _inner;

  /// Creates a new streaming response.
  ///
  /// [stream] should be a single-subscription stream.
  ///
  /// If [inner] is not provided, [detachSocket] will throw.
  MyStreamedResponse(Stream<List<int>> stream, int statusCode,
      {int? contentLength,
      BaseRequest? request,
      Map<String, String> headers = const {},
      bool isRedirect = false,
      bool persistentConnection = true,
      String? reasonPhrase,
      HttpClientResponse? inner})
      : _inner = inner,
        super(stream, statusCode,
            contentLength: contentLength,
            request: request,
            headers: headers,
            isRedirect: isRedirect,
            persistentConnection: persistentConnection,
            reasonPhrase: reasonPhrase);

  /// Detaches the underlying socket from the HTTP server.
  ///
  /// Will throw if `inner` was not set or `null` when `this` was created.
  Future<Socket> detachSocket() async => _inner!.detachSocket();
}
