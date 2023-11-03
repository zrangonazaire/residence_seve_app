import '../generated/swagger.swagger.dart';

abstract class AppartementState {}

class ListeAppartementInitialState extends AppartementState {
  ListeAppartementInitialState();
}

class ListeAppartementLoadedState extends AppartementState {
  final List<dynamic> listAppartements;
  ListeAppartementLoadedState({required this.listAppartements});
}

class ListeAppartementErrorState extends AppartementState {
  final String errorMessage;
  ListeAppartementErrorState({required this.errorMessage});
}

//APPARTEMENTS MEUBLÉES
class ListeAppartementMeubleInitialState extends AppartementState {
  ListeAppartementMeubleInitialState();
}

class ListeAppartementMeubleLoadedState extends AppartementState {
  final List<dynamic> listAppartements;
  ListeAppartementMeubleLoadedState({required this.listAppartements});
}

class ListeAppartementMeubleErrorState extends AppartementState {
  final String errorMessage;
  ListeAppartementMeubleErrorState({required this.errorMessage});
}

// STATE DES IMAGES PAR APPARTEMENTS
class ListImagesParAppartementInitialState extends AppartementState {
  ListImagesParAppartementInitialState();
}

class ListImagesParAppartementLoadedState extends AppartementState {
   List<dynamic> imagesparAppartements;  
  ListImagesParAppartementLoadedState({required this.imagesparAppartements});
}

class ListImagesParAppartementErreurState extends AppartementState {
  final String erreurMessage;
  ListImagesParAppartementErreurState({required this.erreurMessage});
}

// GEST APPARTEMENT PAR ID STATE
class GetAppartementByIdInitState extends AppartementState {}

class GetAppartementByIdLoadedState extends AppartementState {
  final AppartementDto appartementDto;
  GetAppartementByIdLoadedState({required this.appartementDto});
}
class GetAppartementByIdErrorState extends AppartementState {
  final String errorMessage;
  GetAppartementByIdErrorState(this.errorMessage);
}