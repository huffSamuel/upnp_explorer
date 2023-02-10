import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'route_handlers.dart';

class Routes {
  static String root = '/';
  static String deviceDocument = '/device-document';
  static String serviceList = '/service-list';
  static String deviceList = '/device-list';
  static String service(String id) => '/service/$id';
  static String _service = '/service/:id';
  static String actionList = '/action-list';
  static String action = '/action';
  static String serviceStateTable = '/service-state-table';
  static String traffic = '/traffic';
  static String document = '/document';
  static String changelog = '/changelog';

  static FluroRouter configure(FluroRouter router) {
    router.notFoundHandler = Handler(handlerFunc: (_, __) {
      print('Route was not found');
      return;
    });

    router.define(root, handler: rootHandler);

    final Map<String, Handler> map = {
      deviceDocument: deviceHandler,
      document: documentHandler,
      serviceList: serviceListHandler,
      deviceList: deviceListHandler,
      _service: serviceHandler,
      actionList: actionListHandler,
      action: actionHandler,
      serviceStateTable: serviceStateTableHandler,
      traffic: trafficHandler,
      changelog: changelogHandler
    };

    map.forEach(
      (route, handler) => router.define(
        route,
        handler: handler,
        transitionType: TransitionType.custom,
        transitionBuilder: transitionBuilder,
      ),
    );

    return router;
  }
}

Widget transitionBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  const begin = Offset(1.0, 0.0);
  const end = Offset.zero;
  const curve = Curves.ease;

  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  return SlideTransition(position: animation.drive(tween), child: child);
}
