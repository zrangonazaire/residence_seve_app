import 'package:flutter/material.dart';
import 'package:residence_seve_app/generated/swagger.swagger.dart';

@immutable
abstract class CategorieEvent {}

class SaveCategorieEvent extends CategorieEvent {
  final CategoryChambreSaveOrUpdateDto categoryChambreSaveOrUpdateDto;
  SaveCategorieEvent({required this.categoryChambreSaveOrUpdateDto});
}
class FindAllCategorieEvent extends CategorieEvent {
  
}
