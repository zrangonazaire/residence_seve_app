
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:residence_seve_app/blocs/appartement_bloc.dart';
import 'package:residence_seve_app/blocs/appartement_event.dart';
import 'package:residence_seve_app/blocs/appartement_state.dart';
import 'package:residence_seve_app/components/home_image.dart';

class ListImageGridViewWidget extends StatefulWidget {
  const ListImageGridViewWidget({
    super.key,
  });

  @override
  State<ListImageGridViewWidget> createState() => _ListImageGridViewWidgetState();
}

class _ListImageGridViewWidgetState extends State<ListImageGridViewWidget> {
  @override
  Widget build(BuildContext context) {
      Size size=MediaQuery.of(context).size;
    context
        .read<AppartementBloc>()
        .add(ListeAppartementMeubleEvent(idAgence: 1));
    return BlocBuilder<AppartementBloc, AppartementState>(
        builder: (context, state) {
      if (state is ListeAppartementMeubleErrorState) {
        return Text("Erreur suivante : ${state.errorMessage}");
      } else if (state is ListeAppartementMeubleInitialState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is ListeAppartementMeubleLoadedState) {
        var appats = state.listAppartements;
        return appats.isEmpty
            ? const Text("Pas de données")
            : MasonryGridView.builder(
                itemCount: appats.length,
                gridDelegate:
                     SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:(size.width<800)?1: 4),
                itemBuilder: (context, index) => HomeImageWidget(appats: appats[index]));
      }
      return Text("Erreur inconue".toUpperCase());
    });
  }
}
