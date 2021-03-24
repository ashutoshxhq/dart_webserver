import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class RestApi {
  Future<Response> _getPackages(Request request) async {
    return Response.ok('[]');
  }
  Future<Response> _getPackage(Request request) async {
    return Response.ok('{}');
  }

  Router get router {
    final router = Router();

    router.get('/packages', _getPackages);
    router.get('/packages/<name>', _getPackage);

    router.all('/<ignored|.*>', (Request request) => Response.notFound('null'));

    return router;
  }
}