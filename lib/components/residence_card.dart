import 'dart:convert';
// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:residence_seve_app/blocs/appartement_bloc.dart';
import 'package:residence_seve_app/blocs/appartement_event.dart';
import 'package:residence_seve_app/blocs/appartement_state.dart';
import 'package:residence_seve_app/components/save_reservation_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';

// ignore: must_be_immutable
class ResidenceCard extends StatefulWidget {
  ResidenceCard({super.key, required this.appats});
  dynamic appats;

  @override
  State<ResidenceCard> createState() => _ResidenceCardState();
}

class _ResidenceCardState extends State<ResidenceCard> {

  var carroucelIndex = 0;
  void updatePageIndicator(index) {
    carroucelIndex = index;
  }

  @override
  void initState() {
        context
        .read<ListeImagesBloc>()
        .add(ListImagesParAppartementEvent(idBien: widget.appats['id']));
  
    //print("Liste image data $listesImage");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 400,
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
          BlocBuilder<ListeImagesBloc, AppartementState>(
             
              builder: (context, state)  {              
                if (state is ListImagesParAppartementLoadedState) {
                    
                  var theData =state.imagesparAppartements ;//json.decode(snapshot.data!.bodyString);
                 // print("snapshot data : $theData");
                  if (theData.isEmpty) {
                    return Container(
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
                    );
                  } else {
                    
                    return Column(
                      children: [
                        CarouselSlider.builder(
                          itemCount: theData.length,
                          itemBuilder: (context, index, realIndex) {
                            final urlImage = theData[index]['imageData'];
                          //  print("the carroussel data $urlImage");
                            return buildImage(urlImage, index);
                          },
                          options: CarouselOptions(
                              onPageChanged: (index, _) {
                                setState(() {
                                  carroucelIndex = index;
                                });
                              },
                              viewportFraction: 1,
                              height: 140,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 10),
                              enlargeCenterPage: true,
                              enlargeStrategy:
                                  CenterPageEnlargeStrategy.height),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                       
                     Center(
                       child: Row(
                        children: [                          
                          Container(
                            padding: EdgeInsets.all(10.0),
                            height: 10,
                            width: 30,
                            decoration: BoxDecoration(
                            color: Colors.black
                          ),)
                        ],
                       ),
                     )
                      ],
                    );
                  }
                } else if (state is ListImagesParAppartementErreurState) {
                  return const Text("error");
                }else if (state is ListImagesParAppartementInitialState) {
                  return const Text("Init");
                }
                 else {
                  return const Text("Aucunes données ");
                }
              }),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.appats['nomBaptiserBienImmobilier']}",
                style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "${widget.appats['priceCategorie']}",
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
                const Row(
                  children: [
                    Icon(
                      Icons.place,
                      color: Colors.green,
                      size: 14,
                    ),
                    Text("Cocody, Aghien"),
                  ],
                ),
                (widget.appats['occupied']) == true
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
                Column(
                  children: [
                    Text("La nuitée",
                        style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w300)),
                    Text(
                        "${widget.appats['pourcentReducCategorie']}  de rémise  à partir de ${widget.appats['nbrDiffJourCategorie']} nuité",
                        style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w300)),
                  ],
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.book_online,
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black87,
                        padding: const EdgeInsets.all(20.0),
                        backgroundColor: Colors.blue,
                        elevation: 15,
                        shadowColor: Colors.blueAccent,
                        side: const BorderSide(color: Colors.black12, width: 1),
                        shape: const RoundedRectangleBorder(),
                        textStyle: const TextStyle(color: Colors.white)),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (ctx) => SaveReservationWidget(
                              appartement: widget.appats));
                    },
                    label: const Text(
                      "Réserver",
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildImage(urlImage, int index) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
         
        ),
        margin: const EdgeInsets.symmetric(horizontal: 2),
        width: double.infinity,
        child: ClipRRect(
            child: Image.memory(base64Decode(urlImage), fit: BoxFit.cover)),
      );
}
