import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

// to save token in local storage

void write (String token)async {
  await storage.write(key: 'token', value: token);
}
// to get token from local storage

void read () async{
  var value = await storage.read(key: 'token');
}

