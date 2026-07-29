// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get viewContributors => 'View Contributors';

  @override
  String get contributors => 'Colaboradores';

  @override
  String get filters => 'Filtros';

  @override
  String get noActions => 'No actions';

  @override
  String get about => 'Acerca de';

  @override
  String get action => 'Action';

  @override
  String get actions => 'Acciones';

  @override
  String get platformNotSupported => 'Platform not supported';

  @override
  String get clearAll => 'Limpiar todo';

  @override
  String get clearMessages => 'Borrar mensajes?';

  @override
  String get discovery => 'Descubrimiento';

  @override
  String get display => 'Monstrar';

  @override
  String get filter => 'Filtrar';

  @override
  String get deviceInformation => 'Device Information';

  @override
  String fromAddress(String address) {
    return 'De $address';
  }

  @override
  String get deviceDetails => 'Device Details';

  @override
  String get timestamp => 'Timestamp';

  @override
  String get inputParameters => 'Input Parameters';

  @override
  String get requestHeaders => 'Request Headers';

  @override
  String get responseHeaders => 'Response Headers';

  @override
  String get payload => 'Payload';

  @override
  String timestampValue(DateTime time) {
    final intl.DateFormat timeDateFormat =
        intl.DateFormat('HH:mm:ss.SSS', localeName);
    final String timeString = timeDateFormat.format(time);

    return '$timeString';
  }

  @override
  String mailBody(String version) {
    return 'Version $version';
  }

  @override
  String get mailSubject => 'App feedback';

  @override
  String get manufacturer => 'Fabricante';

  @override
  String get seconds => 'Seconds';

  @override
  String get displaySettings => 'Display Settings';

  @override
  String get oledDark => 'OLED Dark';

  @override
  String get oledDarkDescription =>
      'Use a pure black background in dark mode to save power and increase contrast.';

  @override
  String get discoverySubtitle => 'Delay, Hops';

  @override
  String get maxDelayDescription =>
      'El tiempo máximo de retraso en segundos que un dispositivo puede tomar antes de responder. Este es un intento de superar un problema de escala implícito con SSDP.\n\nEl valor debe estar entre 1 y 5. Los retrasos más prolongados pueden generar problemas con el protocolo SSDP.';

  @override
  String get maxResponseDelay => 'Retardo de respuesta';

  @override
  String get unknown => 'Unknown';

  @override
  String get responseBody => 'Response Body';

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
  String get hops => 'Hops (TTL)';

  @override
  String get resetToDefaults => 'Reset to Defaults';

  @override
  String get multicastHopsDescription =>
      'Número máximo de saltos de red para paquetes de multidifusión que se originan en este dispositivo.';

  @override
  String get noDevicesFound => 'No se encontraron dispositivos.';

  @override
  String get devicesUnavailableWhenNoNetwork =>
      'UPnP devices are unavailable while disconnected from the network.';

  @override
  String get privacyPolicy => 'Política de Privacidad';

  @override
  String get rateOnGooglePlay => 'Valora en Google Play';

  @override
  String get refresh => 'Actualizar';

  @override
  String get response => 'Respuesta';

  @override
  String get scanningForDevices => 'Escaneo de dispositivos';

  @override
  String get serialNumber => 'Número de Serie';

  @override
  String get settings => 'Ajustes';

  @override
  String get autoRefresh => 'Auto-refresh';

  @override
  String get autoRefreshDescription =>
      'Automatically trigger a scan when opening the app.';

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
  String get thisWillClearAllMessages =>
      'Esto borrará todo el historial de mensajes de la red.';

  @override
  String get networkDisabled => 'Network Disabled';

  @override
  String get checkNetworkSettings => 'Please check your network settings';

  @override
  String get openNetworkSettings => 'Open Network Settings';

  @override
  String get clearAllMessages => 'Clear all messages';

  @override
  String get keepMessages => 'Keep Messages';

  @override
  String get applyFilters => 'Apply Filters';

  @override
  String get resetFilters => 'Reset Filters';

  @override
  String get viewSourceCode =>
      'Ver el código fuente de esta aplicación en GitHub';

  @override
  String get viewChangelog => 'View Changelog';

  @override
  String get unableToLoadChangelog =>
      'No se puede cargar el registro de cambios';

  @override
  String get unableToSubmitFeedback => 'No se pueden enviar comentarios';

  @override
  String get submitABug => 'Submit a Bug';

  @override
  String get filterByType => 'filter by type';

  @override
  String get filterByIp => 'Filter by IP';

  @override
  String get invalidIpAddress => 'Invalid IP address';

  @override
  String get success => 'Success';

  @override
  String get failed => 'Failed';

  @override
  String get status => 'Status';

  @override
  String get statusMessage => 'Status Message';

  @override
  String codeAndReason(int code, String reason) {
    return '$code $reason';
  }

  @override
  String get latency => 'Latency';

  @override
  String ms(num count) {
    return '$count ms';
  }

  @override
  String get details => 'Details';

  @override
  String get serviceDetails => 'Service Details';

  @override
  String get executeAction => 'Execute Action';

  @override
  String get explorer => 'Explorer';

  @override
  String get method => 'Method';

  @override
  String get notExecuted => 'Not Executed';

  @override
  String get note => 'Note: ';

  @override
  String get discoverySettings => 'Discovery Settings';

  @override
  String get discoverySettingsDescription =>
      'Fine-tune UPnP behavior when discovering devices.';

  @override
  String get protocolSettingsNote =>
      'Changes to discovery settings will only take effect on the next scan. Aggressive settings may cause network congestion in some environments.';

  @override
  String version(String version) {
    return 'Versión $version';
  }

  @override
  String get viewInBrowser => 'Ver en el navegador';

  @override
  String get msearchSent => 'M-SEARCH Sent';

  @override
  String get ssdpMulticastDiscovery => 'SSDP Multicast Discovery';

  @override
  String get notifyReceived => 'NOTIFY Received';

  @override
  String httpRequest(Object method) {
    return '$method Request';
  }

  @override
  String get whatsNew => 'Qué hay de nuevo';

  @override
  String get childDevices => 'Child Devices';

  @override
  String get openSourceLicenses => 'Open Source Licenses';

  @override
  String get upnpServices => 'UPnP Services';

  @override
  String toAddress(Object address) {
    return 'To: $address';
  }

  @override
  String get upnpDevices => 'UPnP Devices';
}
