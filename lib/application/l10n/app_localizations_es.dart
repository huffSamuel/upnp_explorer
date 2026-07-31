// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get viewContributors => 'Ver colaboradores';

  @override
  String get contributors => 'Colaboradores';

  @override
  String get filters => 'Filtros';

  @override
  String get noActions => 'Sin acciones';

  @override
  String get about => 'Acerca de';

  @override
  String get action => 'Acción';

  @override
  String get actions => 'Acciones';

  @override
  String get platformNotSupported => 'Plataforma no compatible';

  @override
  String get clearAll => 'Borrar todo';

  @override
  String get clearMessages => '¿Borrar mensajes?';

  @override
  String get discovery => 'Descubrimiento';

  @override
  String get display => 'Pantalla';

  @override
  String get filter => 'Filtrar';

  @override
  String get deviceInformation => 'Información del dispositivo';

  @override
  String fromAddress(String address) {
    return 'De $address';
  }

  @override
  String get deviceDetails => 'Detalles del dispositivo';

  @override
  String get timestamp => 'Marca de tiempo';

  @override
  String get inputParameters => 'Parámetros de entrada';

  @override
  String get requestHeaders => 'Encabezados de solicitud';

  @override
  String get responseHeaders => 'Encabezados de respuesta';

  @override
  String get payload => 'Carga útil';

  @override
  String timestampValue(DateTime time) {
    final intl.DateFormat timeDateFormat =
        intl.DateFormat('HH:mm:ss.SSS', localeName);
    final String timeString = timeDateFormat.format(time);

    return '$timeString';
  }

  @override
  String mailBody(String version) {
    return 'Versión $version';
  }

  @override
  String get mailSubject => 'Comentarios de la app';

  @override
  String get manufacturer => 'Fabricante';

  @override
  String get seconds => 'Segundos';

  @override
  String get displaySettings => 'Configuración de pantalla';

  @override
  String get oledDark => 'OLED oscuro';

  @override
  String get oledDarkDescription =>
      'Usa un fondo negro puro en modo oscuro para ahorrar batería y aumentar el contraste.';

  @override
  String get discoverySubtitle => 'Retraso, saltos';

  @override
  String get maxDelayDescription =>
      'El tiempo máximo de retraso en segundos que un dispositivo puede tardar en responder. Este intento busca superar un problema de escalado implícito en SSDP.\n\nEl valor debe estar entre 1 y 5. Retrasos más largos pueden provocar problemas con el protocolo SSDP.';

  @override
  String get maxResponseDelay => 'Retraso de respuesta';

  @override
  String get unknown => 'Desconocido';

  @override
  String get responseBody => 'Cuerpo de la respuesta';

  @override
  String get messages => 'Mensajes';

  @override
  String get modelDescription => 'Descripción del modelo';

  @override
  String get modelName => 'Nombre del modelo';

  @override
  String get modelNumber => 'Número de modelo';

  @override
  String get multicastHops => 'Saltos multicast';

  @override
  String get hops => 'Saltos (TTL)';

  @override
  String get resetToDefaults => 'Restablecer a los valores predeterminados';

  @override
  String get multicastHopsDescription =>
      'Número máximo de saltos de red para paquetes multicast originados desde este dispositivo.';

  @override
  String get noDevicesFound => 'No se encontraron dispositivos.';

  @override
  String get devicesUnavailableWhenNoNetwork =>
      'Los dispositivos UPnP no están disponibles mientras no hay red.';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get rateOnGooglePlay => 'Calificar en Google Play';

  @override
  String get refresh => 'Actualizar';

  @override
  String get response => 'Respuesta';

  @override
  String get scanningForDevices => 'Buscando dispositivos';

  @override
  String get serialNumber => 'Número de serie';

  @override
  String get settings => 'Configuración';

  @override
  String get autoRefresh => 'Actualización automática';

  @override
  String get autoRefreshDescription =>
      'Iniciar automáticamente un escaneo al abrir la aplicación.';

  @override
  String get theme => 'Tema';

  @override
  String themeMode(String themeMode) {
    String _temp0 = intl.Intl.selectLogic(
      themeMode,
      {
        'light': 'Claro',
        'dark': 'Oscuro',
        'system': 'Predeterminado del sistema',
        'other': 'Desconocido',
      },
    );
    return '$_temp0';
  }

  @override
  String get thisWillClearAllMessages =>
      'Esto borrará el historial de mensajes de red.';

  @override
  String get networkDisabled => 'Red deshabilitada';

  @override
  String get checkNetworkSettings => 'Revise la configuración de red';

  @override
  String get openNetworkSettings => 'Abrir configuración de red';

  @override
  String get clearAllMessages => 'Borrar todos los mensajes';

  @override
  String get keepMessages => 'Mantener mensajes';

  @override
  String get applyFilters => 'Aplicar filtros';

  @override
  String get resetFilters => 'Restablecer filtros';

  @override
  String get viewSourceCode => 'Ver código fuente';

  @override
  String get viewChangelog => 'Ver historial de cambios';

  @override
  String get unableToLoadChangelog =>
      'No se pudo cargar el historial de cambios';

  @override
  String get unableToSubmitFeedback => 'No se pudo enviar comentarios';

  @override
  String get submitABug => 'Enviar un informe de error';

  @override
  String get filterByType => 'filtrar por tipo';

  @override
  String get filterByIp => 'Filtrar por IP';

  @override
  String get invalidIpAddress => 'Dirección IP no válida';

  @override
  String get success => 'Éxito';

  @override
  String get failed => 'Fallido';

  @override
  String get status => 'Estado';

  @override
  String get statusMessage => 'Mensaje de estado';

  @override
  String codeAndReason(int code, String reason) {
    return '$code $reason';
  }

  @override
  String get latency => 'Latencia';

  @override
  String ms(num count) {
    return '$count ms';
  }

  @override
  String get details => 'Detalles';

  @override
  String get serviceDetails => 'Detalles del servicio';

  @override
  String get executeAction => 'Ejecutar acción';

  @override
  String get explorer => 'Explorador';

  @override
  String get method => 'Método';

  @override
  String get notExecuted => 'No ejecutado';

  @override
  String get note => 'Nota: ';

  @override
  String get discoverySettings => 'Configuración de descubrimiento';

  @override
  String get discoverySettingsDescription =>
      'Ajusta el comportamiento de UPnP al descubrir dispositivos.';

  @override
  String get protocolSettingsNote =>
      'Los cambios en la configuración de descubrimiento solo tendrán efecto en el siguiente escaneo. Los ajustes agresivos pueden provocar congestión de red en algunos entornos.';

  @override
  String version(String version) {
    return 'Versión $version';
  }

  @override
  String get viewInBrowser => 'Ver en el navegador';

  @override
  String get msearchSent => 'M-SEARCH enviado';

  @override
  String get ssdpMulticastDiscovery => 'Descubrimiento multicast SSDP';

  @override
  String get notifyReceived => 'NOTIFY recibido';

  @override
  String httpRequest(Object method) {
    return 'Solicitud $method';
  }

  @override
  String get whatsNew => 'Novedades';

  @override
  String get childDevices => 'Dispositivos secundarios';

  @override
  String get openSourceLicenses => 'Licencias de código abierto';

  @override
  String get upnpServices => 'Servicios UPnP';

  @override
  String toAddress(Object address) {
    return 'A: $address';
  }

  @override
  String get upnpDevices => 'Dispositivos UPnP';

  @override
  String get copy => 'Copiar';
}
