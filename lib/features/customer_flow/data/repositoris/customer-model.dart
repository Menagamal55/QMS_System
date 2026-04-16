// data/models/ticket_model.dart
import 'package:sw2project/features/customer_flow/domain/usecase/userintity.dart';

class TicketModel extends TicketEntity {
  TicketModel({required super.ticketNumber, required super.peopleWaiting, required super.status});

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      ticketNumber: json['ticketNumber'] ?? "",
      peopleWaiting: json['peopleWaiting'] ?? 0,
      status: json['status'] ?? "Pending",
    );
  }
}