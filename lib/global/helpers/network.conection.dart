import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkConnection {
  InternetConnectionChecker connectionChecker = new InternetConnectionChecker();
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
