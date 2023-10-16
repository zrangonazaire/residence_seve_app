import 'package:flutter/material.dart';

@immutable
abstract class ImagesState {}
class SaveImageinitialState extends ImagesState {
  
}
class  SaveImageLoadedState extends ImagesState {
  final int code;
  final String message;

  SaveImageLoadedState(this.code, this.message);

}
class SaveImageErrorState extends ImagesState{
  final String errorMessage;

  SaveImageErrorState(this.errorMessage);
}