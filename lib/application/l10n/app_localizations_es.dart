// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get contributors => 'Colaboradores';

  @override
  String get aSpecialThanks => '¡Un agradecimiento especial!';

  @override
  String get filters => 'Filtros';

  @override
  String get directionDescription => 'Dirección';

  @override
  String get protocolDescription => 'Protocolo';

  @override
  String get online => 'Conectado';

  @override
  String get offline => 'Desconectado';

  @override
  String get aboutThisDevice => 'Acerca de este dispositivo';

  @override
  String get from => 'De';

  @override
  String get noActionsForThisService => 'No hay acciones para este servicio';

  @override
  String sendCommand(Object name) {
    return 'Enviar comando de $name';
  }

  @override
  String get to => 'A';

  @override
  String get about => 'Acerca de';

  @override
  String get type => 'Tipo';

  @override
  String get actions => 'Acciones';

  @override
  String actionsN(num count) {
    return 'Acciones ($count)';
  }

  @override
  String countVisible(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count visibles',
      one: '1visible',
      zero: '0 visibles',
    );
    return '$_temp0';
  }

  @override
  String get adaptiveLayout => 'Layout adattivo';

  @override
  String get adaptiveLayoutDescription => 'Adatta il layout e la combinazione di colori dell\'app al sistema operativo della piattaforma e alle impostazioni di colore dinamiche.';

  @override
  String get advancedMode => 'Modo avanzado';

  @override
  String get advancedModeWarning => 'El modo avanzado permite demoras más largas de lo recomendado. Habilitar el modo avanzado puede tener efectos negativos.';

  @override
  String get back => 'Atrás';

  @override
  String get changelog => 'Registro de cambios';

  @override
  String changelogItem(String item) {
    return '- $item';
  }

  @override
  String get clearAll => 'Limpiar todo';

  @override
  String get clearHistory => 'Sí, borrar historial';

  @override
  String get clearMessages => 'Borrar mensajes?';

  @override
  String get close => 'Cerrar';

  @override
  String commandFailedWithError(String error) {
    return 'Error de comando $error';
  }

  @override
  String get controlUnavailable => 'Control no disponible';

  @override
  String get copy => 'Copiar';

  @override
  String get copyJson => 'Copiar JSON';

  @override
  String get darkThemeDescription => 'El tema oscuro utiliza un fondo negro para ayudar a que la batería dure más tiempo.';

  @override
  String get decrease => 'Disminuir';

  @override
  String get decreaseDisabled => 'Disminución deshabilitado';

  @override
  String get density => 'Densidad visual';

  @override
  String get devices => 'Dispositivos';

  @override
  String devicesN(num count) {
    return 'Dispositivos ($count)';
  }

  @override
  String direction(String direction) {
    String _temp0 = intl.Intl.selectLogic(
      direction,
      {
        'incoming': 'Entrante',
        'outgoing': 'Saliente',
        'other': 'Desconocido',
      },
    );
    return '$_temp0';
  }

  @override
  String discoveredDevice(String name) {
    return 'Dispositivo Descubierto $name';
  }

  @override
  String get discovery => 'Descubrimiento';

  @override
  String get discoveryRequiresNetwork => 'La detección de dispositivos requiere acceso a la red';

  @override
  String get display => 'Monstrar';

  @override
  String get filter => 'Filtrar';

  @override
  String get foundBug => '¿Encontraste un error?';

  @override
  String fromAddress(String address) {
    return 'De $address';
  }

  @override
  String get increase => 'Aumentar';

  @override
  String get increaseDisabled => 'Aumentar deshabilitado';

  @override
  String get input => 'Aporte';

  @override
  String get keepHistory => 'No, mantener la historia';

  @override
  String knownValue(String name, String value) {
    return '$name $value';
  }

  @override
  String get legalese => 'Yo tomo tu privacidad muy en serio. Más allá de la información que Google proporciona a los desarrolladores de aplicaciones, no utilizo análisis ni marcos publicitarios de terceros. No registro información sobre usted y no tengo ningún interés en hacerlo.\n\nNo recopilo, transmito, distribuyo ni vendo sus datos.';

  @override
  String get letUsKnowHowWereDoing => 'Háganos saber cómo lo estamos haciendo';

  @override
  String get licenses => 'Licencias';

  @override
  String get listSeparator => ', ';

  @override
  String mailBody(String version) {
    return 'Version $version';
  }

  @override
  String get mailSubject => 'App feedback';

  @override
  String get manufacturer => 'Fabricante';

  @override
  String get maxDelayDescription => 'El tiempo máximo de retraso en segundos que un dispositivo puede tomar antes de responder. Este es un intento de superar un problema de escala implícito con SSDP.\n\nEl valor debe estar entre 1 y 5. Los retrasos más prolongados pueden generar problemas con el protocolo SSDP.';

  @override
  String get maxResponseDelay => 'Retardo de respuesta';

  @override
  String messageLog(String direction, String time, String type) {
    String _temp0 = intl.Intl.selectLogic(
      direction,
      {
        'inn': 'recibida',
        'out': 'enviada',
        'other': 'Unknown',
      },
    );
    return '$type $_temp0 a las $time';
  }

  @override
  String get messages => 'Mensajes';

  @override
  String get modelDescription => 'Descripcion del Modelo';

  @override
  String get modelName => 'Nombre del Modelo';

  @override
  String get modelNumber => 'Número de Modelo';

  @override
  String get multicastHops => 'Saltos de Multidifusión';

  @override
  String get multicastHopsDescription => 'Número máximo de saltos de red para paquetes de multidifusión que se originan en este dispositivo.';

  @override
  String get neverAskAgain => 'Nunca preguntes de nuevo';

  @override
  String get noDevicesFound => 'No se encontraron dispositivos.';

  @override
  String get nothingHere => 'No hay nada aquí.';

  @override
  String get notNow => 'Ahora no';

  @override
  String get off => 'Apagado';

  @override
  String get ok => 'OK';

  @override
  String get on => 'Encendido';

  @override
  String get open => 'Abierto';

  @override
  String get openAnIssueOnOurGithub => 'Abre un tema en nuestro GitHub';

  @override
  String get openInBrowser => 'Abierta XML en el navegador';

  @override
  String get openPresentationInBrowser => 'Abrir URL de presentación en el navegador';

  @override
  String get output => 'Producción';

  @override
  String pleaseRateAppName(String appName) {
    return 'Si te gusta $appName o has encontrado algo en lo que debemos trabajar, nos encantaría saberlo. Le agradeceríamos mucho que calificara la aplicación en Play Store. ¡Gracias!';
  }

  @override
  String get privacyPolicy => 'Política de Privacidad';

  @override
  String protocol(String protocol) {
    String _temp0 = intl.Intl.selectLogic(
      protocol,
      {
        'upnp': 'UPnP',
        'ssdp': 'SSDP',
        'soap': 'SOAP',
        'other': 'Desconocido',
      },
    );
    return '$_temp0';
  }

  @override
  String rateAppName(String appName) {
    return 'Valora $appName';
  }

  @override
  String get rateOnGooglePlay => 'Valora en Google Play';

  @override
  String receivedAt(DateTime time) {
    final intl.DateFormat timeDateFormat = intl.DateFormat('HH:mm:ss.SSS', localeName);
    final String timeString = timeDateFormat.format(time);

    return 'Recibido a las $timeString';
  }

  @override
  String get refresh => 'Actualizar';

  @override
  String get request => 'Pedido';

  @override
  String get response => 'Respuesta';

  @override
  String responseDelay(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count segundos',
      one: '1 segundo',
    );
    return '$_temp0';
  }

  @override
  String get scanningForDevices => 'Escaneo de dispositivos';

  @override
  String sentAt(DateTime time) {
    final intl.DateFormat timeDateFormat = intl.DateFormat('HH:mm:ss.SSS', localeName);
    final String timeString = timeDateFormat.format(time);

    return 'Enviado a las $timeString';
  }

  @override
  String get serialNumber => 'Número de Serie';

  @override
  String get serviceControlUnavailable => 'El control del servicio UPnP no está disponible en este momento.';

  @override
  String get services => 'Servicios';

  @override
  String servicesN(num count) {
    return 'Servicios ($count)';
  }

  @override
  String get settings => 'Ajustes';

  @override
  String get stateVariables => 'Variables de Estado';

  @override
  String stateVariablesN(num count) {
    return 'Variables de Estado ($count)';
  }

  @override
  String get systemThemeDescription => 'El tema predeterminado del sistema usa la configuración de su dispositivo para determinar cuándo usar el modo claro u oscuro.';

  @override
  String get theme => 'Tema';

  @override
  String themeMode(String themeMode) {
    String _temp0 = intl.Intl.selectLogic(
      themeMode,
      {
        'light': 'Ligero',
        'dark': 'Oscuro',
        'system': 'Sistema por Defecto',
        'other': 'Desconocido',
      },
    );
    return '$_temp0';
  }

  @override
  String get thisWillClearAllMessages => 'Esto borrará todo el historial de mensajes de la red.';

  @override
  String get traffic => 'Tráfico';

  @override
  String get turnOnWifi => 'Activar wifi';

  @override
  String get unableToLoadChangelog => 'No se puede cargar el registro de cambios';

  @override
  String get unableToObtainInformation => 'No se puede obtener la información del servicio';

  @override
  String get unableToSubmitFeedback => 'No se pueden enviar comentarios';

  @override
  String get unavailable => 'Indisponible';

  @override
  String unknownValue(String name) {
    return '$name desconocido';
  }

  @override
  String version(String version) {
    return 'Versión $version';
  }

  @override
  String get viewInBrowser => 'Ver en el navegador';

  @override
  String get viewNetworkTraffic => 'Ver tráfico de red';

  @override
  String get viewXml => 'Ver XML';

  @override
  String visualDensity(String visualDensity) {
    String _temp0 = intl.Intl.selectLogic(
      visualDensity,
      {
        'comfortable': 'Cómodo',
        'standard': 'Estándar',
        'compact': 'Compacto',
        'other': 'Desconocido',
      },
    );
    return '$_temp0';
  }

  @override
  String get whatsNew => 'Qué hay de nuevo';

  @override
  String get wereOpenSource => 'Nosotros somos de código abierto';

  @override
  String get viewSourceCode => 'Ver el código fuente de esta aplicación en GitHub';
}
