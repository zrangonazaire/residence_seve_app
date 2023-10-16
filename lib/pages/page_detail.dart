// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:residence_seve_app/components/image_carousel_widget.dart';
import 'package:residence_seve_app/constants.dart';
import 'package:residence_seve_app/pages/admin_page.dart';
import 'package:residence_seve_app/pages/page_reservation.dart';

import '../blocs/appartement_bloc.dart';
import '../blocs/appartement_state.dart';

class PageDetail extends StatefulWidget {
  const PageDetail({super.key, required this.appats});
  final dynamic appats;
  @override
  State<PageDetail> createState() => _PageDetailState();
}

List _isHovering = [
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false
];

class _PageDetailState extends State<PageDetail> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const MenuWidget(),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: screenSize.width,
              height: 60,
              decoration: const BoxDecoration(color: Colors.black),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {},
                        onHover: (value) {
                          setState(() {
                            value
                                ? _isHovering[4] = true
                                : _isHovering[4] = false;
                          });
                        },
                        child: Text(
                          "Accueil".toUpperCase(),
                          style: TextStyle(
                              color: _isHovering[4] ? Colors.red : Colors.white,
                              fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width / 20,
                      ),
                      InkWell(
                        onTap: () {},
                        onHover: (value) {
                          setState(() {
                            value
                                ? _isHovering[5] = true
                                : _isHovering[5] = false;
                          });
                        },
                        child: Text(
                          "LOGEMENTS",
                          style: TextStyle(
                              color: _isHovering[5] ? Colors.red : Colors.white,
                              fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width / 20,
                      ),
                      InkWell(
                        onTap: () {},
                        onHover: (value) {
                          setState(() {
                            value
                                ? _isHovering[6] = true
                                : _isHovering[6] = false;
                          });
                        },
                        child: Text(
                          "VILLAS",
                          style: TextStyle(
                              color: _isHovering[6] ? Colors.red : Colors.white,
                              fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width / 20,
                      ),
                      InkWell(
                        onTap: () {},
                        onHover: (value) {
                          setState(() {
                            value
                                ? _isHovering[7] = true
                                : _isHovering[7] = false;
                          });
                        },
                        child: Text(
                          "CONTACT",
                          style: TextStyle(
                              color: _isHovering[7] ? Colors.red : Colors.white,
                              fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width / 10,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              width: screenSize.width,
              child: ImageCarouselWidget(idBien: widget.appats['id']),
            ),
            Center(
                child: Text(
              "${widget.appats['nomCompletBienImmobilier']}",
              style: const TextStyle(fontSize: 40, color: Colors.greenAccent),
            )),
            Text(
              "L'appartement est équipé de climatisation réversible, TV plasma/LCD avec service TNT et couverture Wifi.Il possède une grande terrasse couverte de 20 m², offrant une belle vue montagne.",
              maxLines: 4,
              style: TextStyle(color: Colors.grey.shade300),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PageReservion()),
                      );
                    },
                    child: Container(
                      width: 200,
                      height: 30,
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: Colors.greenAccent)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "RÉSERVER",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenSize.height * 0.5,
                    width: screenSize.width * 0.7,
                    child: BlocBuilder<ListeImagesBloc, AppartementState>(
                        builder: (context, state) {
                      if (state is ListImagesParAppartementInitialState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is ListImagesParAppartementErreurState) {
                        return Center(
                          child: Text("Erreur ${state.erreurMessage}"),
                        );
                      } else if (state is ListImagesParAppartementLoadedState) {
                        var images = state.imagesparAppartements;
                        // print(images);
                        return MasonryGridView.builder(
                            itemCount: images.length,
                            gridDelegate:
                                const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4),
                            itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Container(
                                    width: screenSize.width * 0.3,
                                    height: screenSize.height * 0.3,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: images[index].imageData!=
                                                        '' &&
                                                    images.isNotEmpty
                                                ? MemoryImage(base64Decode(
                                                    images[index].imageData!.first))
                                                : const AssetImage(
                                                        'assets/images/noimage.png')
                                                    as ImageProvider)),
                                  ),
                                ));
                      }
                      return const Center(
                        child: Text("Une erreur inatendue c'est produite."),
                      );
                    }),
                  ),
                  Container(
                    color: Colors.white,
                    width: screenSize.width * 0.25,
                    height: 300,
                    child: const Center(
                      child: Text("VIDEO D'ILLUSTRATION"),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
