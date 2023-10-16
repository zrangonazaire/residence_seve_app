import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ImagesEvent {}

class SaveImageEvent extends ImagesEvent {
  final int idBien;
  final String imageName;
  final PlatformFile file;
  SaveImageEvent(this.idBien, this.imageName, this.file);
}
