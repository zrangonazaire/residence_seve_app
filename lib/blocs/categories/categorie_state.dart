import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CategorieState {}

class SaveCategorieInitialState extends CategorieState {}

class SaveCategorieErrorState extends CategorieState {
  final String errorMessage;
  SaveCategorieErrorState({required this.errorMessage});
}

// ignore: must_be_immutable
class SaveCategorieLoadedState extends CategorieState {
  Response<dynamic> categorieList;
  SaveCategorieLoadedState({required this.categorieList});
}

class FindAllCategorieInitialState extends CategorieState {}

class FindAllCategorieErrorState extends CategorieState {
  final String errorMessage;
  FindAllCategorieErrorState({required this.errorMessage});
}

class FindAllCategorieLoadedState extends CategorieState {
  final List<dynamic> categorieList;
  FindAllCategorieLoadedState({required this.categorieList});
}
