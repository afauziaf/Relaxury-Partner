import 'package:get_storage/get_storage.dart';

class Storage {
  final GetStorage _storage = GetStorage('RelaxuryPartner');
  final String _path = 'RelaxuryPartner/';
  final String _name;

  Storage(this._name);

  Future<void> write(dynamic value) => _storage.write(_path + _name, value);
  dynamic read() => _storage.read(_path + _name);
  remove() => _storage.remove(_path + _name);
  erase() => _storage.erase();
}

class StorageName {
  // Authentication
  static const baseUrl = 'baseUrl';
  static const token = 'token';

  // Save Login
  static const userId = 'userId';
  static const email = 'email';
  static const username = 'username';
  static const password = 'password';
}
