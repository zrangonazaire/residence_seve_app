import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:residence_seve_app/blocs/appartement_bloc.dart';
import 'package:residence_seve_app/blocs/appartement_event.dart';
import 'package:residence_seve_app/components/save_reservation_widget.dart';

class ResidenceCard extends StatelessWidget {
  const ResidenceCard({super.key, required this.appats});
  final dynamic appats;
  @override
  Widget build(BuildContext context) {
    print("the ID is ${appats['id']}");
     context
        .read<ListeImagesBloc>()
        .add(ListImagesParAppartementEvent(idBien: appats['id']));
    return Container(
      margin: const EdgeInsets.all(10),
      height: 230,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200,
                spreadRadius: 4,
                blurRadius: 6,
                offset: const Offset(0, 3))
          ]),
      child: Column(
        children: [
          Container(
            height: 140,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(18)),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/noimage.png'))),
            child: Stack(
              children: [
                Positioned(
                    top: 5,
                    right: -15,
                    child: MaterialButton(
                      color: Colors.white,
                      shape: const CircleBorder(),
                      onPressed: () {},
                      child: const Icon(
                        Icons.favorite_outline_rounded,
                        color: Colors.green,
                        size: 20,
                      ),
                    ))
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Row(
            
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${appats['nomBaptiserBienImmobilier']}",
                style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                " 1500 FCFA",
                style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (appats['occupied']) == true
                    ? Text("Occupé",
                        style: GoogleFonts.nunito(
                            color: Colors.red,
                            fontSize: 10,
                            fontWeight: FontWeight.w300))
                    : Text("Disponible",
                        style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w300)),
                            const Row(children: [
                              Icon(Icons.place,
                              color: Colors.green,
                              size: 14,
                              ),
                              Text("Cocody, Aghien"),
                            ],),
                            Text("La nuitée" ,style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w300)),
              ],
            ),
            
          ),
          Container(
            margin:const EdgeInsets.fromLTRB(10, 3, 10, 0),
            child: Row(
              children: [
                ElevatedButton(onPressed: (){
                    showDialog(
                          context: context,
                          builder: (ctx) =>const SaveReservationWidget());
                }, child:const Text("Réserver")),
              ],
            ),
          )
        ],
      ),
    );
  }
}
