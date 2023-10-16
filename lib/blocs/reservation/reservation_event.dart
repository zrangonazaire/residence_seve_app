import 'package:flutter/material.dart';
import 'package:residence_seve_app/generated/swagger.swagger.dart';

@immutable
abstract class ReservationEvent {}

class SaveReservationEvent extends ReservationEvent {
  final ReservationRequestDto reservationRequestDto;
  SaveReservationEvent({required this.reservationRequestDto});
}
