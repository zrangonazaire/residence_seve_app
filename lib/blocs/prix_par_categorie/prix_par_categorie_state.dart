import 'package:flutter/material.dart';
import 'package:residence_seve_app/generated/swagger.swagger.dart';

@immutable
abstract class PrixParCategorieState {}

class SavePrixParCategorieLoadedState extends PrixParCategorieState {
  final PrixParCategorieChambreDto prixParCategorieChambreDto;
  SavePrixParCategorieLoadedState({required this.prixParCategorieChambreDto});
}
class SavePrixParCategorieInitState extends PrixParCategorieState {  
}
class SavePrixParCategorieErrorState extends PrixParCategorieState {
  final String errorMessage;
  SavePrixParCategorieErrorState({required this.errorMessage});
}