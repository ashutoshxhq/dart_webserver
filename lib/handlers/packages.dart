import 'package:dart_webserver/templates/package.dart';
import 'package:dart_webserver/templates/packages.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class Packages {
  Future<Response> _getPackages(Request request) async {
    return Response.ok(PackagesTemplate(), headers: {'Content-Type':'text/html'});
  }
  Future<Response> _getPackage(Request request, String name) async {
    return Response.ok(PackageTemplate(name), headers: {'Content-Type':'text/html'});
  }

  Router get router {
    final router = Router();

    router.get('/', _getPackages);
    router.get('/<name>', _getPackage);

    router.all('/<ignored|.*>', (Request request) => Response.notFound('null'));

    return router;
  }
}