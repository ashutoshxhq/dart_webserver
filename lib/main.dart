import 'dart:async' show Future;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

class Service {

  Handler get handler {
    final router = Router();

    router.get('/say-hi/<name>', (Request request, String name) {
      return Response.ok('hi $name');
    });

    router.get('/user/<userId|[0-9]+>', (Request request, String userId) {
      return Response.ok('User has the user-number: $userId');
    });

    router.get('/wave', (Request request) async {
      await Future.delayed(Duration(milliseconds: 100));
      return Response.ok('_o/');
    });

    router.mount('/api/', Api().router);

    router.all('/<ignored|.*>', (Request request) {
      return Response.notFound('Page not found');
    });

    return router;
  }
}

class Api {
  Future<Response> _messages(Request request) async {
    return Response.ok('[]');
  }

  // By exposing a [Router] for an object, it can be mounted in other routers.
  Router get router {
    final router = Router();

    // A handler can have more that one route.
    router.get('/messages', _messages);
    router.get('/messages/', _messages);

    // This nested catch-all, will only catch /api/.* when mounted above.
    // Notice that ordering if annotated handlers and mounts is significant.
    router.all('/<ignored|.*>', (Request request) => Response.notFound('null'));

    return router;
  }
}

// Run shelf server and host a [Service] instance on port 8080.
void StartWebServer() async {
  final service = Service();
  final server = await shelf_io.serve(service.handler, 'localhost', 8080);
  print('Server running on localhost:${server.port}');
}