import 'dart:convert';
import 'dart:math';

import 'package:davi/davi.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:residence_seve_app/blocs/appartement_state.dart';
import 'package:residence_seve_app/blocs/images/image_bloc.dart';
import 'package:residence_seve_app/blocs/images/images_event.dart';
import 'package:residence_seve_app/blocs/images/images_state.dart';
import 'package:residence_seve_app/components/save_categorie_widget.dart';
import 'package:residence_seve_app/components/save_prix_par_categorie.dart';
import 'package:residence_seve_app/constants.dart';

import '../blocs/appartement_bloc.dart';
import '../blocs/appartement_event.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

List<PlatformFile>? _paths;

class _AdminPageState extends State<AdminPage> {
  int indexColors = -1;
  int selectedIndex = -1;
  int idBien = 0;
  PlatformFile? objFile;
  bool isSelected = false;
  void chooseFileUsingFilePicker() async {
    try {
      if (kIsWeb == true) {
        _paths = (await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowMultiple: false,
                onFileLoading: (FilePickerStatus status) =>
                    print(" THE STATUS IS $status"),
                allowedExtensions: ['png', 'jpg', 'jpeg', 'heic']))
            ?.files;
      }
    } on PlatformException catch (e) {
    } catch (e) {
    }
    setState(() {
      if (_paths != null) {
        if (_paths != null) {
          objFile = _paths!.single;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    context
        .read<AppartementBloc>()
        .add(ListeAppartementMeubleEvent(idAgence: 1));
    return Scaffold(
      appBar: const MenuWidget(),
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Text("Appartemens"),
                Text("Categorie"),
                Text("Prix par Catégorie")
              ],
            ),
          ),
          body: TabBarView(children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: screenSize.width,
                    height: 100,
                    color: Colors.white,
                    child: BlocBuilder<AppartementBloc, AppartementState>(
                        builder: (context, state) {
                      if (state is ListeAppartementInitialState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is ListeAppartementMeubleErrorState) {
                        return Center(
                          child: Text(" Erreur :  ${state.errorMessage}"),
                        );
                      } else if (state is ListeAppartementMeubleLoadedState) {
                        var appats = state.listAppartements;

                        return appats.isEmpty
                            ? const Text("Pas de données")
                            : ListView.separated(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.all(20),
                                itemCount: appats.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        indexColors = index;
                                        idBien = appats[index]['id'];
                                           context.read<ListeImagesBloc>().add(
                                            ListImagesParAppartementEvent(
                                                idBien: idBien));
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: indexColors == index ? 3 : 1,
                                            color: indexColors == index
                                                ? Colors.red
                                                : Colors.black),
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.primaries[Random()
                                            .nextInt(Colors.primaries.length)],
                                      ),
                                      width: (screenSize.width > 800)
                                          ? screenSize.width * 0.3
                                          : screenSize.width * 0.7,
                                      child: Column(
                                        children: [
                                          Text("${appats[index]['id']}"),
                                          Text(
                                            "${appats[index]['nomBaptiserBienImmobilier']}"
                                                .toUpperCase(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(
                                    width: 10,
                                  );
                                },
                              );
                      }
                      return const Text("Erreur inconnue");
                    }),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: screenSize.width,
                    height: screenSize.height * 0.5,
                    child: Row(
                      children: [
                        SizedBox(
                          height: screenSize.height * 0.6,
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  _paths != null
                                      ? kIsWeb == true
                                          ? Container(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              height: screenSize.height * 0.4,
                                              width: screenSize.width * 0.3,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 2),
                                                  image: DecorationImage(
                                                      image: MemoryImage(_paths!
                                                          .first.bytes!))),
                                            )
                                          : Container(
                                              width: 30,
                                              height: 30,
                                              color: Colors.black,
                                            )
                                      : InkWell(
                                          onTap: () {
                                            chooseFileUsingFilePicker();
                                          },
                                          child: Container(
                                            color: Colors.amber,
                                            height: screenSize.height * 0.3,
                                            width: screenSize.width * 0.2,
                                            child: DottedBorder(
                                              borderType: BorderType.RRect,
                                              radius: const Radius.circular(20),
                                              dashPattern: const [10, 10],
                                              color: Colors.grey,
                                              strokeWidth: 2,
                                              child: Card(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: const Center(
                                                    child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.image_outlined,
                                                      size: 30,
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text("Choisir une image",
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 16)),
                                                  ],
                                                )),
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 30,
                                        color: Colors.red,
                                        child: TextButton(
                                          onPressed: () {
                                            if (_paths != null) {
                                              setState(() {
                                                _paths = null;
                                              });
                                            }
                                          },
                                          child: SizedBox(
                                            height: 30,
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.warning,
                                                  size: 11,
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Text("Supprimer",
                                                    style: GoogleFonts.montaga(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 12))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      Container(
                                        height: 30,
                                        margin: const EdgeInsets.all(1.0),
                                        padding: const EdgeInsets.all(1.0),
                                        width: 120,
                                        color: Colors.blue,
                                        child: TextButton(
                                          onPressed: () {
                                            context.read<ImageBloc>().add(
                                                SaveImageEvent(idBien, "images",
                                                    objFile!));
                                          },
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.save,
                                                size: 10,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text("Sauvegarder",
                                                  style: GoogleFonts.montaga(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 12))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  BlocBuilder<ImageBloc, ImagesState>(
                                      builder: (context, state) {
                                    if (state is SaveImageinitialState) {
                                      return const Text("");
                                    } else if (state is SaveImageErrorState) {
                                      return const Text(
                                        "data",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      );
                                    } else if (state is SaveImageLoadedState) {
                                      if (state.code == 200) {

                                        context.read<ListeImagesBloc>().add(
                                            ListImagesParAppartementEvent(
                                                idBien: idBien));
                                      }
                                    }
                                    return const Text("");
                                  })
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.blue,
                          height: screenSize.height * 0.5,
                          width: screenSize.width * 0.7,
                          child: BlocBuilder<ListeImagesBloc, AppartementState>(
                              builder: (context, state) {
                            if (state is ListImagesParAppartementInitialState) {
                              return const Center(
                                child: Text("En attente de donées"),
                              );
                            } else if (state
                                is ListImagesParAppartementErreurState) {
                              return Center(
                                child: Text("Erreur ${state.erreurMessage}"),
                              );
                            } else if (state
                                is ListImagesParAppartementLoadedState) {
                              var images = state.imagesparAppartements;
                              //print(images);
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
                                                  image: images[index]
                                                                  ['imageData']
                                                              .isNotEmpty &&
                                                          images.isNotEmpty
                                                      ? MemoryImage(
                                                          base64Decode(images[
                                                                      index]
                                                                  ['imageData']))
                                                      : const AssetImage(
                                                              'assets/images/noimage.png')
                                                          as ImageProvider)),
                                        ),
                                      ));
                            }
                            return const Center(
                              child:
                                  Text("Une erreur inatendue c'est produite."),
                            );
                          }),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SaveCategorieChambreWidget(),
            const SavePrixParCategorieWidget(),
          ]),
        ),
      ),
    );
  }

  List<dynamic> selectedUsers = [];
  onSelectedRow(bool selected, dynamic user) async {
    //setState(() {
    if (selected) {
      selectedUsers.add(user);
    } else {
      selectedUsers.remove(user);
    }
    // });
  }

  Color? _rowColor(DaviRow<dynamic> row) {
    var couleur = row.data['occupied']!;

    if (couleur == false) {
      return Colors.green[50];
    } else {
      return Colors.orange[50]!;
    }
  }
}
