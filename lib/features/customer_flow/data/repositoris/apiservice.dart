// data/datasources/customer_remote_data_source.dart
import 'package:dio/dio.dart';
import 'package:sw2project/features/customer_flow/data/repositoris/customer-model.dart';

class CustomerRemoteDataSource {
  final Dio dio;
  CustomerRemoteDataSource(this.dio);

  Future<TicketModel> fetchMyTicket() async {
    final response = await dio.get('https://qms-api.runasp.net/api/Ticket/my-ticket');
    return TicketModel.fromJson(response.data);
  }

  Future<void> requestService(int serviceId) async {
    await dio.post(
      'https://qms-api.runasp.net/api/Service/add-services',
      data: {'serviceId': serviceId},
    );
  }
}