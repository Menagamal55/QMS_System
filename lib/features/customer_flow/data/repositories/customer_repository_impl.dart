import 'package:sw2project/features/customer_flow/data/datasources/customer_remote_data_source.dart';
import 'package:sw2project/features/customer_flow/domain/repositories/customerflow_repository.dart';
import 'package:sw2project/features/customer_flow/domain/usecase/userintity.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerRemoteDataSource remoteDataSource;

  CustomerRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> addService(int serviceId) async {
    return await remoteDataSource.requestService(serviceId);
  }

  @override
  Future<TicketEntity> getMyTicket() async {
    return await remoteDataSource.fetchMyTicket();
  }

  @override
  Future<Map<String, dynamic>> getQueueStatus() async {
    return await remoteDataSource.getQueueStatus();
  }
}
