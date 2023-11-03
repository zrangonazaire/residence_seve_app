import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:residence_seve_app/blocs/categories/categorie_event.dart';
import 'package:residence_seve_app/blocs/categories/categorie_state.dart';
import 'package:residence_seve_app/blocs/categories/categorrie_bloc.dart';
import 'package:residence_seve_app/blocs/prix_par_categorie/prix_par_categorie_bloc.dart';
import 'package:residence_seve_app/blocs/prix_par_categorie/prix_par_categorie_event.dart';
import 'package:residence_seve_app/blocs/prix_par_categorie/prix_par_categorie_state.dart';
import 'package:residence_seve_app/generated/swagger.swagger.dart';

class SavePrixParCategorieWidget extends StatefulWidget {
  const SavePrixParCategorieWidget({super.key});

  @override
  State<SavePrixParCategorieWidget> createState() =>
      _SavePrixParCategorieWidgetState();
}

class _SavePrixParCategorieWidgetState
    extends State<SavePrixParCategorieWidget> {
  final descController = TextEditingController();
  final prixController = TextEditingController();
  final nameController = TextEditingController();
  final double idCat = 0;
  final nombreDeJourController = TextEditingController();
  final idCatController = TextEditingController();
  final intervalPrixController = TextEditingController();
  final nbrDiffJourController = TextEditingController();
  final idCategorieChambreController = TextEditingController();

  @override
  void initState() {
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     context.read<FindAllCategorieBloc>().add(FindAllCategorieEvent());
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
                      builder: (ctx) => AlertDialog(
                          scrollable: true,
                          content: Stack(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Création d'un prix par catégorie !",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 24.0,
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),
                                  Column(
                                    children: [
                                      Container(
                                        width: 400,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.black, width: 1)),
                                        child: Column(
                                          children: [
                                            const Text("Catégorie"),
                                            BlocBuilder<FindAllCategorieBloc,
                                                    CategorieState>(
                                                builder: (context, state) {
                                                
                                              if (state
                                                  is FindAllCategorieInitialState) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.black,
                                                  ),
                                                );
                                              } else if (state
                                                  is FindAllCategorieErrorState) {
                                                return Text(
                                                  "Erreur : ${state.errorMessage}",
                                                  style: const TextStyle(
                                                      color: Colors.red),
                                                );
                                              } else if (state
                                                  is FindAllCategorieLoadedState) {
                                                    
                                                var allCat =
                                                    state.categorieList;
                                            
                                               
                                                return DropdownButton(
                                                    isExpanded: true,
                                                    icon: const Icon(
                                                      Icons.arrow_drop_down,
                                                      color: Colors.black,
                                                    ),
                                                    items: allCat.map((e) {
                                                      return DropdownMenuItem(
                                                        value:
                                                            e, // Set the value of the item
                                                        child: Text(
                                                            "${e['name']}"),
                                                      );
                                                    }).toList(),
                                                    onChanged: (dynamic e) {
                                                      setState(() {
                                                        nameController.text =
                                                            "${e['name']} ";
                                                        prixController.text =
                                                            "${e['price']}";
                                                        idCatController.text =
                                                            "${e['id']}";
                                                        // print(
                                                        //     "the select is $e ");
                                                      });
                                                    });
                                              }
                                              return const Text(
                                                  "Erreur test");
                                            }),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: false,
                                        child: TextFormField(
                                          controller: idCatController,
                                          decoration: const InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelText:
                                                  "Entrer l'id de la catégorie"),
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                    
                                      TextFormField(
                                        controller: nameController,
                                        decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelText:
                                                "Entrer le nom de la catégorie"),
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
                                         
                                        controller: nombreDeJourController,
                                        decoration: const InputDecoration(
                                          hintText: '0-5 jours',
                                            border: UnderlineInputBorder(),
                                            labelText: "Nombre de jours en lettre"),
                                       
                                      ),
                                      const SizedBox(height: 10.0),
                                        TextFormField(
                                         
                                        controller: nbrDiffJourController,
                                        decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelText: "Différences entre les nombres de jours"),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                      ),
                                      const SizedBox(height: 30.0),
                                      TextFormField(
                                        controller: prixController,
                                        decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelText: "Entrer le Montant"),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                      ),
                                      const SizedBox(height: 30.0),
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: 400.0,
                                            height: 40.0,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                context
                                                    .read<SavePrixParCategorieBloc>()
                                                    .add(SavePrixParCategorieEvent(
                                                        prixParCategorieChambreDto:
                                                            PrixParCategorieChambreDto(
                                                                id: 0,
                                                                idCreateur: 2,
                                                                idAgence: 1,
                                                                idCategorieChambre: int.tryParse(idCatController.text),
                                                                prix: double
                                                                    .tryParse(
                                                                        prixController
                                                                            .text),
                                                                description:
                                                                    descController
                                                                        .text,
                                                                nbrDiffJour:int.tryParse(nbrDiffJourController
                                                                        .text),
                                                                         nombreDeJour:nombreDeJourController.text,
                                                                         intervalPrix:int.tryParse(prixController
                                                                        .text)
                                                                    )));
                                              },
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Theme.of(context)
                                                            .primaryColor),
                                              ),
                                              child: const Text(
                                                'Valider',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          BlocBuilder<SavePrixParCategorieBloc,
                                                  PrixParCategorieState>(
                                              builder: (context, state) {
                                            // print("THE STATE IS $state");
                                            if (state
                                                is SavePrixParCategorieErrorState) {
                                              return Text(
                                                "Erreur : ${state.errorMessage}",
                                                style: const TextStyle(
                                                    color: Colors.red),
                                              );
                                            } else if (state
                                                is SavePrixParCategorieLoadedState) {
                                              return const Text(
                                                "Enrégistrement éffectué avec succès .",
                                                style: TextStyle(
                                                    color: Colors.green),
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
                          )));
                },
                child: const Text(
                  "Nouveau +",
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ),
      ],
    );
  }
}
