import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:postgres/postgres.dart';

void main() async {
  final dbUrl = Platform.environment['DATABASE_URL']!;
  final connection = PostgreSQLConnection.fromConnectionString(dbUrl);
  await connection.open();

  final app = Router();

  // مسار لإضافة مستخدم جديد
  app.post('/add', (Request request) async {
    final payload = await request.readAsString();
    // هنا نضيف المنطق لاستقبال البيانات وإضافتها لقاعدة البيانات
    return Response.ok('Data Received: $payload');
  });

  // مسار للبحث
  app.get('/search', (Request request) async {
    return Response.ok('Search results here');
  });

  final handler = Pipeline().addMiddleware(logRequests()).addHandler(app);
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  await serve(handler, InternetAddress.anyIPv4, port);
  print('Server running on port $port');
}
