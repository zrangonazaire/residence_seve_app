import 'package:davi/davi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:residence_seve_app/blocs/categories/categorie_event.dart';
import 'package:residence_seve_app/blocs/categories/categorie_state.dart';
import 'package:residence_seve_app/blocs/categories/categorrie_bloc.dart';
import 'package:residence_seve_app/generated/swagger.swagger.dart';

class SaveCategorieChambreWidget extends StatefulWidget {
  const SaveCategorieChambreWidget({
    super.key,
  });

  @override
  State<SaveCategorieChambreWidget> createState() =>
      _SaveCategorieChambreWidgetState();
}

class _SaveCategorieChambreWidgetState
    extends State<SaveCategorieChambreWidget> {
  final descController = TextEditingController();
  final prixController = TextEditingController();
  final nameController = TextEditingController();
  @override
  void initState() {
    context.read<FindAllCategorieBloc>().add(FindAllCategorieEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 30,
            width: 200,
            color: Colors.green,
            child: TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (ctx) => AlertFormSaveCategorieWidget(
                          nameController: nameController,
                          descController: descController,
                          prixController: prixController));
                },
                child: const Text(
                  "Nouveau +",
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ),
        Container(
          height: 400,
          width: 500,
          color: Colors.yellow,
          child: BlocBuilder<FindAllCategorieBloc, CategorieState>(
              builder: (context, state) {
            //   print("Ths find State is $state");
            if (state is FindAllCategorieInitialState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            } else if (state is FindAllCategorieErrorState) {
              return Text(
                "Erreur : ${state.errorMessage}",
                style: const TextStyle(color: Colors.red),
              );
            } else if (state is FindAllCategorieLoadedState) {
              var allCat = state.categorieList;
              // print("THE DATA IS ${allCat[0]['description']}");
              return allCat.isEmpty
                  ? const Text("Pas de données")
                  : DaviTheme(
                      data: const DaviThemeData(
                          row: RowThemeData(cursorOnTapGesturesOnly: false)),
                      child: Davi<dynamic>(
                          //  rowColor: _rowColor,
                          DaviModel(rows: allCat, columns: [
                        DaviColumn(
                          name: "Nom",
                          stringValue: (data) => data['name'],
                        ),
                        DaviColumn(
                            grow: 1.5,
                            name: "Description",
                            stringValue: (data) => data['description']),
                        DaviColumn(
                            name: "Prix", doubleValue: (data) => data['price']),
                      ])),
                    );
            }
            return const Text("Erreur inatendue");
          }),
        )
      ],
    );
  }

  // Color? _rowColor(DaviRow<dynamic> row) {
  //   var couleur = row.data['occupied']!;

  //   if (couleur == false) {
  //     return Colors.green[50];
  //   } else {
  //     return Colors.orange[50]!;
  //   }
  // }
}

class AlertFormSaveCategorieWidget extends StatelessWidget {
  const AlertFormSaveCategorieWidget({
    Key? key,
    required this.nameController,
    required this.descController,
    required this.prixController,
  }) : super(key: key);

  final TextEditingController nameController;
  final TextEditingController descController;
  final TextEditingController prixController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        scrollable: true,
        content: Stack(
          children: [
            Column(
              children: [
                Text(
                  "Création d'une catégorie",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 24.0,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 20.0),
                // SocialBtn(),
                
                Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "Entrer le nom de la catégorie"),
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      controller: descController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "Description"),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      controller: prixController,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "Entrer le prix"),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    const SizedBox(height: 30.0),
                    Column(
                      children: [
                        SizedBox(
                          width: 400.0,
                          height: 40.0,
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<CategorieBloc>().add(
                                  SaveCategorieEvent(
                                      categoryChambreSaveOrUpdateDto:
                                          CategoryChambreSaveOrUpdateDto(
                                              id: 0,
                                              idCreateur: 2,
                                              idAgence: 1,
                                              price: double.tryParse(
                                                  prixController.text),
                                              description: descController.text,
                                              name: nameController.text)));
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor),
                            ),
                            child: const Text(
                              'Valider',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        BlocBuilder<CategorieBloc, CategorieState>(
                            builder: (context, state) {
                          if (state is SaveCategorieErrorState) {
                            return Text(
                              "Erreur : ${state.errorMessage}",
                              style: const TextStyle(color: Colors.red),
                            );
                          } else if (state is SaveCategorieLoadedState) {
                            return const Text(
                              "Enrégistrement éffectué avec succès .",
                              style: TextStyle(color: Colors.green),
                            );
                          }
                          return const Text("");
                        })
                      ],
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
