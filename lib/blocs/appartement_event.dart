import 'package:flutter/widgets.dart';

@immutable
abstract class AppartementEvent {}

class ListeAppartementEvent extends AppartementEvent {
  final int idAgence;
  ListeAppartementEvent({required this.idAgence});
}

class ListeAppartementMeubleEvent extends AppartementEvent {
  final int idAgence;
  ListeAppartementMeubleEvent({required this.idAgence});
}

class ListImagesParAppartementEvent extends AppartementEvent {
  final int idBien;
  ListImagesParAppartementEvent({required this.idBien});
}

class GetAppartementByIdEvent extends AppartementEvent {
  final int idAppart;
  GetAppartementByIdEvent({required this.idAppart});
}
