import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:residence_seve_app/blocs/categories/categorie_event.dart';
import 'package:residence_seve_app/blocs/categories/categorie_state.dart';
import 'package:residence_seve_app/generated/swagger.swagger.dart';

class CategorieBloc extends Bloc<CategorieEvent, CategorieState> {
  CategorieBloc() : super(SaveCategorieInitialState()) {
    Swagger seveSwagger = Swagger.create();

    on((SaveCategorieEvent event, emit) async {
      emit(SaveCategorieInitialState());
      try {
        Response<dynamic> saveCategorie = await seveSwagger
            .gestimowebApiV1CategoriechambreSaveOrUpdateCategoryChambrePost(
                body: event.categoryChambreSaveOrUpdateDto);
               emit(SaveCategorieLoadedState(categorieList: saveCategorie));
      } catch (e) {
        emit(SaveCategorieErrorState(errorMessage: e.toString()));
      }
    });
  }
}

class FindAllCategorieBloc extends Bloc<CategorieEvent, CategorieState> {
  FindAllCategorieBloc() : super(FindAllCategorieInitialState()) {
    Swagger seveSwagger = Swagger.create();

    on((FindAllCategorieEvent event, emit) async {
      emit(FindAllCategorieInitialState());
      try {         
        var findAllCategorie =
            await seveSwagger.gestimowebApiV1CategoriechambreAllGet();
    
        List<dynamic> emitCate = [];

        emitCate = json.decode(findAllCategorie.bodyString);
        emit(FindAllCategorieLoadedState(categorieList: emitCate));
      } catch (e) {
        emit(SaveCategorieErrorState(errorMessage: e.toString()));
      }
    });
  }
}
