import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ResidenceRecherche extends StatelessWidget {
  const ResidenceRecherche({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    //Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: 150,
      color: Colors.grey[200],
      padding: const EdgeInsets.fromLTRB(10, 25, 10, 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow:  [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 4,
                          offset: const Offset(0, 3))
                    ]),
                padding: const EdgeInsets.only(left: 5),
                child: const TextField(
                  decoration: InputDecoration(
                      hintText: "Rechercher un une résidence",
                      contentPadding: EdgeInsets.all(10),
                      border: InputBorder.none),
                ),
              )),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                    color: Colors.green,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: Offset(0, 4)),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(), backgroundColor: Colors.white, padding: const EdgeInsets.all(10)),
                  child: const Icon(Icons.search,color: Colors.white,),
                ),
              )
            ],
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin:const  EdgeInsets.all(10),
               child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Choisir une date",style: GoogleFonts.nunito(color: Colors.grey,fontSize: 15),),
                  Text("12 Dec - 22 Dec",style: GoogleFonts.nunito(color: Colors.black,fontSize: 17))
                ],
               ),
              ),
               Container(
                margin:const  EdgeInsets.all(10),
               child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nombre de chambre",style: GoogleFonts.nunito(color: Colors.grey,fontSize: 15)),
                  Text("1 Salon - 2 Adultes",style: GoogleFonts.nunito(color: Colors.black,fontSize: 17))
                ],
               ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
