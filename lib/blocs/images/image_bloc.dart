import 'dart:developer';
// ignore: depend_on_referenced_packages
import "package:http/http.dart" as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:residence_seve_app/blocs/images/images_event.dart';
import 'package:residence_seve_app/blocs/images/images_state.dart';

import '../../generated/swagger.swagger.dart';

class ImageBloc extends Bloc<ImagesEvent,ImagesState> {
  ImageBloc():super(SaveImageinitialState()){
    final seveSwagger = Swagger.create();
    on((SaveImageEvent event, emit) async{
      emit(SaveImageinitialState());
         try {
      final request = http.MultipartRequest(
          "POST",
          Uri.parse(
              "${seveSwagger.client.baseUrl}gestimoweb/api/v1/image/upload/${event.idBien}/${event.imageName}/"));
      request.fields["id"] = "${event.idBien}";
      request.fields["name"] = event.imageName;
      request.files.add(http.MultipartFile.fromBytes("file", event.file.bytes!,
          filename: event.imageName));
      http.StreamedResponse resp = await request.send();
      emit(SaveImageLoadedState(resp.statusCode, resp.toString()));

    } catch (e) {
      log("L'Erreur suivante c'est produite : ${e.toString()}");
      emit(SaveImageErrorState(e.toString()));
    }
    });
  }
  
}