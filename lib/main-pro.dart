import 'package:flutter/material.dart';
import 'package:upnp_explorer/constants.dart';

import 'main-common.dart';
import 'presentation/core/widgets/app-config.dart';

void main() {
  var config = AppConfigData(kAppName, 2);

  mainCommon().then(
    (_) => runApp(
      AppConfig(
        config,
        UpnpExplorer(),
      ),
    ),
  );
}
