import 'package:flutter/material.dart';
import 'package:residence_seve_app/generated/swagger.swagger.dart';

@immutable
abstract class PrixParCategorieEvent {}

class SavePrixParCategorieEvent extends PrixParCategorieEvent {
  final PrixParCategorieChambreDto prixParCategorieChambreDto;
  SavePrixParCategorieEvent({required this.prixParCategorieChambreDto});
}
