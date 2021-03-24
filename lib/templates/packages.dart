import 'package:mustache_template/mustache.dart';

String Packages() {
  var source = '''
	  {{# names }}
            <h1>{{ lastname }}, {{ firstname }}</h1>
	  {{/ names }}
	  {{^ names }}
	    <div>No packages.</div>
	  {{/ names }}
	  {{! I am a comment. }}
	''';

  var template = Template(source, name: 'home');

  var output = template.renderString({
    'names': [
      {'firstname': 'Greg', 'lastname': 'Lowe'},
      {'firstname': 'Bob', 'lastname': 'Johnson'}
    ]
  });

  return output;
}
