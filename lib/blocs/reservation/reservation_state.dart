import 'package:flutter/material.dart';


@immutable
abstract class ReservationState{}

class SaveReservationLoaded extends ReservationState {
  final dynamic reservationAfficheDto;
  SaveReservationLoaded({required this.reservationAfficheDto});
}
class SaveReservationInitState extends ReservationState{
  
}
class SaveReservationErrorState extends ReservationState {
  final String errorMessage;
  SaveReservationErrorState({required this.errorMessage});
}