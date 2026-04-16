class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'http://qms-api.runasp.net/api';

  static const String loginEndpoint = '/User/login';
  static const String registerEndpoint = '/User/register';

  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
}