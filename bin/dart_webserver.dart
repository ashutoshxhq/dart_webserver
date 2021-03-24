import 'package:dart_webserver/handlers/packages.dart';
import 'package:dart_webserver/handlers/restapi.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;


class Service {
  Handler get handler {
    final router = Router();
    
    router.get('/packages', (Request request) {
      return Response.movedPermanently('/packages/');
    });
    router.mount('/packages/', Packages().router);
    
    router.get('/packages', (Request request) {
      return Response.movedPermanently('/packages/');
    });
    router.mount('/api/', RestApi().router);

    router.all('/<ignored|.*>', (Request request) {
      return Response.notFound('Page not found');
    });

    return router;
  }
}

void main(List<String> arguments) async{
  final service = Service();
  final server = await io.serve(service.handler, 'localhost', 8000);
  print('Server running on http://localhost:${server.port}');
}
