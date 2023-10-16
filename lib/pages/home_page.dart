import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:residence_seve_app/blocs/appartement_bloc.dart';
import 'package:residence_seve_app/blocs/appartement_event.dart';
import 'package:residence_seve_app/blocs/appartement_state.dart';
import 'package:residence_seve_app/constants.dart';
import 'package:residence_seve_app/components/components.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
   
    context
        .read<AppartementBloc>()
        .add(ListeAppartementMeubleEvent(idAgence: 1));
         super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
    //    backgroundColor: Colors.red,
        appBar: const MenuWidget(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ResidenceRecherche(screenSize: screenSize),
              ResidenceSelect(screenSize: screenSize),
              Container(
                padding: const EdgeInsets.all(10),
                width: screenSize.width,
                height: screenSize.height*0.7,
                child: BlocBuilder<AppartementBloc, AppartementState>(
                    builder: (context, state) {
                  if (state is ListeAppartementMeubleErrorState) {
                    return Text("Erreur suivante : ${state.errorMessage}");
                  } else if (state is ListeAppartementMeubleInitialState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ListeAppartementMeubleLoadedState) {
                    var appats = state.listAppartements;
                  //  print("THE DATA IS $appats");
                    return appats.isEmpty
                        ? const Text("Pas de données")
                        : MasonryGridView.builder(
                            itemCount: appats.length,
                            gridDelegate:
                                SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: (screenSize.width < 800) ? 1 :3 ),
                            itemBuilder: (context, index) =>
                                ResidenceCard(appats: appats[index]));
                  }
                  return Text("Erreur inconue".toUpperCase());
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
