import 'package:sw2project/core/base_usecase/Api%20constants.dart';
import 'package:sw2project/core/network/dio_client.dart';
import 'package:sw2project/features/customer_flow/data/repositories/customer-model.dart';

abstract class CustomerRemoteDataSource {
  Future<TicketModel> fetchMyTicket();
  Future<void> requestService(int serviceId);
  Future<Map<String, dynamic>> getQueueStatus();
}

class CustomerRemoteDataSourceImpl implements CustomerRemoteDataSource {
  final DioClient dioClient;

  CustomerRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<TicketModel> fetchMyTicket() async {
    final response = await dioClient.get(ApiConstants.myTicketEndpoint);
    return TicketModel.fromJson(response.data);
  }

  @override
  Future<void> requestService(int serviceId) async {
    await dioClient.post(
      ApiConstants.addServiceEndpoint,
      data: {'serviceId': serviceId},
    );
  }

  @override
  Future<Map<String, dynamic>> getQueueStatus() async {
    final response = await dioClient.get(ApiConstants.queueStatusEndpoint);
    return response.data;
  }
}
