class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'http://qms-api.runasp.net/api';

  static const String loginEndpoint = '/User/login';
  static const String registerEndpoint = '/User/register';
  static const String myTicketEndpoint = '/Ticket/my-ticket';
  static const String addServiceEndpoint = '/Service/add-services';
  static const String queueStatusEndpoint = '/Service/queue-status';

  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
}