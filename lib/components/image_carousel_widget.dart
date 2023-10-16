import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:residence_seve_app/blocs/appartement_state.dart';

import '../blocs/appartement_bloc.dart';
import '../blocs/appartement_event.dart';

// ignore: must_be_immutable
class ImageCarouselWidget extends StatefulWidget {
  const ImageCarouselWidget({super.key, required this.idBien});
  final int idBien;
  @override
  // ignore: library_private_types_in_public_api
  _ImageCarouselWidgetState createState() => _ImageCarouselWidgetState();
}

class _ImageCarouselWidgetState extends State<ImageCarouselWidget> {
  bool _isPlaying = true;
  late CarouselSliderController _sliderController;
  @override
  void initState() {
    super.initState();
    _sliderController = CarouselSliderController();
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<ListeImagesBloc>()
        .add(ListImagesParAppartementEvent(idBien: widget.idBien));
    Size screenSize = MediaQuery.of(context).size;
    return Expanded(
      child: Column(
        children: <Widget>[
          BlocBuilder<ListeImagesBloc, AppartementState>(
            builder: (context, state) {
              if (state is ListImagesParAppartementInitialState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ListImagesParAppartementErreurState) {
                return Center(
                  child: Text(state.erreurMessage),
                );
              } else if (state is ListImagesParAppartementLoadedState) {
                var images = state.imagesparAppartements;
                return CarouselSlider.builder(
                  unlimitedMode: true,
                  controller: _sliderController,
                  slideBuilder: (index) {
                    return Container(
                      width: screenSize.width * 0.3,
                      height: screenSize.height * 0.3,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: images[index].imageData!.length != 0 &&
                                      images.isNotEmpty
                                  ? MemoryImage(base64Decode(
                                      images[index].imageData!.first))
                                  : const AssetImage(
                                          'assets/images/noimage.png')
                                      as ImageProvider)),
                    );
                  },
                  slideTransform: const CubeTransform(),
                  slideIndicator: CircularSlideIndicator(
                    padding: const EdgeInsets.only(bottom: 32),
                    indicatorBorderColor: Colors.black,
                  ),
                  itemCount: images.isEmpty ? 1 : images.length,
                  initialPage: 0,
                  enableAutoSlider: true,
                  
                );
              }
              return const Center(
                child: Text("Erreur inconnue"),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1),
            child: Align(
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      iconSize: 24,
                      icon: const Icon(Icons.skip_previous),
                      onPressed: () {
                        _sliderController.previousPage();
                      },
                    ),
                    IconButton(
                      iconSize: 24,
                      icon: Icon(
                        _isPlaying
                            ? Icons.pause_circle_outline
                            : Icons.play_circle_outline,
                      ),
                      onPressed: () {
                        setState(
                          () {
                            _isPlaying = !_isPlaying;
                            _sliderController.setAutoSliderEnabled(_isPlaying);
                          },
                        );
                      },
                    ),
                    IconButton(
                      iconSize: 24,
                      icon: const Icon(Icons.skip_next),
                      onPressed: () {
                        _sliderController.nextPage();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
