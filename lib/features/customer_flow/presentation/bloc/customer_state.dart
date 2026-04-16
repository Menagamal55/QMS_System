import 'package:sw2project/features/customer_flow/domain/usecase/userintity.dart';

abstract class CustomerState {}

class CustomerInitial extends CustomerState {}

class CustomerLoading extends CustomerState {}

class CustomerSuccess extends CustomerState {
  final TicketEntity ticket;
  CustomerSuccess(this.ticket);
}

class QueueStatusSuccess extends CustomerState {
  final Map<String, dynamic> status;
  QueueStatusSuccess(this.status);
}

class CustomerError extends CustomerState {
  final String message;
  CustomerError(this.message);
}