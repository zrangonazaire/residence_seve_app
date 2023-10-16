import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:residence_seve_app/blocs/reservation/reservation_event.dart';
import 'package:residence_seve_app/blocs/reservation/reservation_state.dart';
import 'package:residence_seve_app/generated/client_index.dart';
import 'package:residence_seve_app/generated/swagger.swagger.dart';

class SaveReservationBloc extends Bloc<ReservationEvent,ReservationState>{
  SaveReservationBloc():super(SaveReservationInitState()){
    Swagger seveSwagger=Swagger.create();
    on((SaveReservationEvent event, emit) async{
      emit(SaveReservationInitState());
      try {
        var reservationAfficheDto=seveSwagger.gestimowebApiV1ReservationSaveorupdatereservationPost(body: event.reservationRequestDto);
   //var   reservationAfficheDtoEmit=json.decode(reservationAfficheDto.);
      print("The reservation back is : $reservationAfficheDto");
      emit(SaveReservationLoaded(reservationAfficheDto: reservationAfficheDto));
      } catch (e) {
        emit(SaveReservationErrorState(errorMessage: e.toString()));
      }
    });
  }
}