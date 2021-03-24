import 'package:mustache_template/mustache.dart';

String Package(String name) {
  var source = '''
	 <h1>{{ lastname }}, {{ firstname }}</h1>
	''';

  var template = Template(source, name: 'home');

  var output = template.renderString({'firstname': name, 'lastname': 'Lowe'});

  return output;
}
