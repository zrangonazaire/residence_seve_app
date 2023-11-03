//import 'package:flutter/material.dart';


abstract class AppartementEvent {}

class ListeAppartementEvent extends AppartementEvent {
  final int idAgence;
  ListeAppartementEvent({required this.idAgence});
}

class ListeAppartementMeubleEvent extends AppartementEvent {
  final int idAgence;
  ListeAppartementMeubleEvent({required this.idAgence});
}

// ignore: must_be_immutable
class ListImagesParAppartementEvent extends AppartementEvent {
   int idBien;
  ListImagesParAppartementEvent({required this.idBien});
}

class GetAppartementByIdEvent extends AppartementEvent {
  final int idAppart;
  GetAppartementByIdEvent({required this.idAppart});
}
