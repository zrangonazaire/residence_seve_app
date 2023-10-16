import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:residence_seve_app/blocs/appartement_bloc.dart';
import 'package:residence_seve_app/blocs/appartement_state.dart';

import '../blocs/appartement_event.dart';

// ignore: must_be_immutable
class CardImageAppart extends StatefulWidget {
  CardImageAppart({
    required this.idBien,
    super.key,
  });
  int idBien;

  @override
  State<CardImageAppart> createState() => _CardImageAppartState();
}

class _CardImageAppartState extends State<CardImageAppart> {
  @override
  Widget build(BuildContext context) {
    context
        .read<ListeImagesBloc>()
        .add(ListImagesParAppartementEvent(idBien: widget.idBien));

    return BlocBuilder<ListeImagesBloc, AppartementState>(
        builder: (context, state) {
      if (state is ListImagesParAppartementErreurState) {
        return Text("Erreur : ${state.erreurMessage}");
      } else if (state is ListImagesParAppartementInitialState) {
        return const Center(
          child: CircularProgressIndicator(color: Colors.red),
        );
      } else if (state is ListImagesParAppartementLoadedState) {
        var images = state.imagesparAppartements;
        return Container(
          height: 250,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
             // color: Colors.yellow,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: images.isNotEmpty
                      ? MemoryImage( base64Decode(images[0]['imageData']))
                      : const AssetImage('assets/images/noimage.png')
                          as ImageProvider)),
        );
      }
      return const Text("Erreur inconue est survenu");
    });
  }
}
