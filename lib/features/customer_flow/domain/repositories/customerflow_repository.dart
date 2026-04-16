// domain/repositories/customer_repository.dart
import 'package:sw2project/features/customer_flow/domain/usecase/userintity.dart';

abstract class CustomerRepository {
  Future<void> addService(int serviceId); 
  Future<TicketEntity> getMyTicket();    
  Future<Map<String, dynamic>> getQueueStatus(); }