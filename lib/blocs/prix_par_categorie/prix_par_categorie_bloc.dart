import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:residence_seve_app/blocs/prix_par_categorie/prix_par_categorie_event.dart';
import 'package:residence_seve_app/blocs/prix_par_categorie/prix_par_categorie_state.dart';
import 'package:residence_seve_app/generated/swagger.swagger.dart';

class SavePrixParCategorieBloc extends Bloc<PrixParCategorieEvent,PrixParCategorieState> {
  SavePrixParCategorieBloc():super(SavePrixParCategorieInitState()){
   final seveSwagger = Swagger.create(); 
    on((SavePrixParCategorieEvent event, emit)async {
      emit(SavePrixParCategorieInitState());
      PrixParCategorieChambreDto prixParCategorieChambreDto=const PrixParCategorieChambreDto();
   
      try {
        var pc=await seveSwagger.gestimowebApiV1PrixparcategorieSaveOrUpDatePrixParCategoriePost(body: event.prixParCategorieChambreDto);
      emit(SavePrixParCategorieLoadedState(prixParCategorieChambreDto: prixParCategorieChambreDto));
      } catch (e) {
        emit(SavePrixParCategorieErrorState(errorMessage: e.toString()));
      }
    });
  }
  
}