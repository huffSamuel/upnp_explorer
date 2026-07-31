import 'package:injectable/injectable.dart';
import 'package:highlight/highlight.dart';
import 'package:highlight/languages/xml.dart' as lang;

@lazySingleton
class HighlightService {
  final Highlight _highlight = Highlight()..registerLanguage('xml', lang.xml);
  Highlight get highlight => _highlight;
}
