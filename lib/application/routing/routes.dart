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
  static String document =  '/document';

  static FluroRouter configure(FluroRouter router) {
    router.notFoundHandler = Handler(handlerFunc: (_, __) {
      print('Route was not found');
      return;
    });

    router.define(root, handler: rootHandler);
    router.define(
      deviceDocument,
      handler: deviceHandler,
      transitionType: TransitionType.custom,
      transitionBuilder: transitionBuilder,
    );
    router.define(
      document,
      handler: documentHandler,
      transitionType: TransitionType.custom,
      transitionBuilder: transitionBuilder,
    );
    router.define(
      serviceList,
      handler: serviceListHandler,
      transitionType: TransitionType.custom,
      transitionBuilder: transitionBuilder,
    );
    router.define(
      deviceList,
      handler: deviceListHandler,
      transitionType: TransitionType.custom,
      transitionBuilder: transitionBuilder,
    );
    router.define(
      _service,
      handler: serviceHandler,
      transitionType: TransitionType.custom,
      transitionBuilder: transitionBuilder,
    );
    router.define(
      actionList,
      handler: actionListHandler,
      transitionType: TransitionType.custom,
      transitionBuilder: transitionBuilder,
    );
    router.define(
      action,
      handler: actionHandler,
      transitionType: TransitionType.custom,
      transitionBuilder: transitionBuilder,
    );
    router.define(
      serviceStateTable,
      handler: serviceStateTableHandler,
      transitionType: TransitionType.custom,
      transitionBuilder: transitionBuilder,
    );
    router.define(
      traffic,
      handler: trafficHandler,
      transitionType: TransitionType.custom,
      transitionBuilder: transitionBuilder,
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
