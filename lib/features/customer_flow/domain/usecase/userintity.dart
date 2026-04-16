// domain/entities/ticket_entity.dart
class TicketEntity {
  final String ticketNumber;
  final int peopleWaiting;
  final String status;

  TicketEntity({required this.ticketNumber, required this.peopleWaiting, required this.status});
}