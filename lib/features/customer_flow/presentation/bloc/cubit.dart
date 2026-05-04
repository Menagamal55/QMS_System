import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw2project/features/customer_flow/domain/repositories/customerflow_repository.dart';
import 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  final CustomerRepository repository;

  CustomerCubit(this.repository) : super(CustomerInitial());

  Future<void> bookTicket(int serviceId) async {
    emit(CustomerLoading());
    try {
      await repository.addService(serviceId);
      await getMyTicket();
    } catch (e) {
      emit(CustomerError("error in booking ticket ${e.toString()}"));
    }
  }

  Future<void> getMyTicket() async {
    try {
      final ticket = await repository.getMyTicket();
      emit(CustomerSuccess(ticket));
    } catch (e) {
      emit(CustomerError("error in fetching ticket data ${e.toString()}"));
    }
  }

  Future<void> getQueueStatus() async {
    try {
      final status = await repository.getQueueStatus();
      emit(QueueStatusSuccess(status));
    } catch (e) {
      emit(CustomerError("error in fetching queue status ${e.toString()}"));
    }
  }
}