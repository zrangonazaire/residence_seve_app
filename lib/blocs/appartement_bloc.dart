import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:chopper/src/response.dart';
import 'package:residence_seve_app/blocs/appartement_event.dart';
import 'package:residence_seve_app/blocs/appartement_state.dart';
import 'package:residence_seve_app/generated/swagger.swagger.dart';

class GetAppartementByIdBloc extends Bloc<AppartementEvent, AppartementState> {
  GetAppartementByIdBloc() : super(GetAppartementByIdInitState()) {
    final seveSwagger = Swagger.create();
    on((GetAppartementByIdEvent event, emit) async {
      emit(GetAppartementByIdInitState());
      try {
        var getApppart = await seveSwagger
            .gestimowebApiV1AppartementFindByIdIdGet(id: event.idAppart);
        AppartementDto appartEmit = const AppartementDto();
        if (getApppart.isSuccessful) {
          appartEmit = json.decode(getApppart.bodyString);
        }
        emit(GetAppartementByIdLoadedState(appartementDto: appartEmit));
      } catch (e) {
        emit(GetAppartementByIdErrorState(e.toString()));
      }
    });
  }
}

class ListeImagesBloc extends Bloc<AppartementEvent, AppartementState> {
  ListeImagesBloc() : super(ListImagesParAppartementInitialState()) {
    final seveSwagger = Swagger.create();
    on((ListImagesParAppartementEvent event, emit) async {
      emit(ListImagesParAppartementInitialState());

      try {
   
        Response<List<ImageDataDto>> listesDesAppartements = await seveSwagger
            .gestimowebApiV1ImageImagesbybienIdGet(id: event.idBien);
        
 
        if (listesDesAppartements.isSuccessful) {
          // listesDesAppartementsEmit =
          //     json.decode(listesDesAppartements.bodyString);
                emit(ListImagesParAppartementLoadedState(
            imagesparAppartements: json.decode(listesDesAppartements.bodyString)));
          
        }else{
  emit(ListImagesParAppartementErreurState(
            erreurMessage: "Erreur inconnue."));
        }
        } catch (e) {
        emit(ListImagesParAppartementErreurState(
            erreurMessage: e.toString().toUpperCase()));
      }
    });
  }
}

class AppartementBloc extends Bloc<AppartementEvent, AppartementState> {
  AppartementBloc() : super(ListeAppartementInitialState()) {
    final seveSwagger = Swagger.create();
    on((ListeAppartementEvent event, emit) async {
      emit(ListeAppartementInitialState());
      try {
        var list = await seveSwagger.gestimowebApiV1AppartementAllmeubleIdGet(id: 1);
        var listAppartEmit = [];
        if (list.isSuccessful) {
          listAppartEmit = json.decode(list.bodyString);
        }
        emit(ListeAppartementLoadedState(listAppartements: listAppartEmit));
      } catch (e) {
        emit(ListeAppartementErrorState(errorMessage: e.toString()));
      }
    });
    on((ListeAppartementMeubleEvent event, emit) async {
      emit(ListeAppartementMeubleInitialState());
      try {
        var list =
            await seveSwagger.gestimowebApiV1AppartementAllmeubleIdGet(id: 1);
        var listAppartEmit = [];
        if (list.isSuccessful) {
          listAppartEmit = json.decode(list.bodyString);
        }
        emit(ListeAppartementMeubleLoadedState(
            listAppartements: listAppartEmit));
      } catch (e) {
        emit(ListeAppartementMeubleErrorState(errorMessage: e.toString()));
      }
    });
  }
}
