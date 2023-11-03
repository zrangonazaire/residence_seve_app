import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:residence_seve_app/blocs/reservation/reservation_bloc.dart';
import 'package:residence_seve_app/blocs/reservation/reservation_event.dart';
import 'package:residence_seve_app/blocs/reservation/reservation_state.dart';
import 'package:residence_seve_app/generated/swagger.swagger.dart';

class SaveReservationWidget extends StatefulWidget {
  const SaveReservationWidget({
    Key? key,
    required this.appartement,
  }) : super(key: key);
  final dynamic appartement;
  @override
  State<SaveReservationWidget> createState() => _SaveReservationWidgetState();
}

class _SaveReservationWidgetState extends State<SaveReservationWidget> {
  DateTimeRange selectDates =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  final idAppartementdDtoController = TextEditingController();
  final dateDebutController = TextEditingController();
  final dateFinController = TextEditingController();
  final idClientController = TextEditingController();
  final dBienController = TextEditingController();

  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final mobileController = TextEditingController();
  final dateDeNaissanceController = TextEditingController();
  final lieuNaissanceController = TextEditingController();
  final typePieceIdentiteController = TextEditingController();
  final numeroPieceIdentiteController = TextEditingController();
  final dateDebutPieceController = TextEditingController();
  final dateFinPieceController = TextEditingController();
  final nationaliteController = TextEditingController();
  final genreController = TextEditingController();
  final montantCautionBailController = TextEditingController();
  final nbreMoisCautionBailController = TextEditingController();
  final nouveauMontantLoyerController = TextEditingController();
  final idBienImmobilierController = TextEditingController();
  final advancePaymentController = TextEditingController();
  final remainingPaymentController = TextEditingController();
  final soldReservationController = TextEditingController();
  final nmbreHommeController = TextEditingController();
  final nmbreFemmeController = TextEditingController();
  final nmbrEnfantController = TextEditingController();
  final pourcentage = TextEditingController();
  @override
  void initState() {
    idAppartementdDtoController.text = widget.appartement['id'].toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AlertDialog(
      scrollable: true,
      content: Stack(
        children: [
          SizedBox(
            width: size.height,
            height: size.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Réservation : ${widget.appartement['nomBaptiserBienImmobilier']}",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14.0,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black87,
                        padding: const EdgeInsets.all(20.0),
                        backgroundColor: Colors.blue,
                        elevation: 15,
                        shadowColor: Colors.blueAccent,
                        side: const BorderSide(color: Colors.black12, width: 1),
                        shape: const RoundedRectangleBorder(),
                        textStyle: const TextStyle(color: Colors.white)),
                    onPressed: () async {
                      final DateTimeRange? dateRange =
                          await showDateRangePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(3000));
                      if (dateRange != null) {
                        setState(() {
                          selectDates = dateRange;
                          dateDebutController.text = DateFormat('dd-MM-yyyy')
                              .format(selectDates.start);
                          dateFinController.text =
                              DateFormat('dd-MM-yyyy').format(selectDates.end);
                        });
                      }
                    },
                    child: (selectDates.duration.inDays > 0)
                        ? Center(
                          child: Text(
                              "Séjour du ${DateFormat('dd-MM-yyyy').format(selectDates.start)} au ${DateFormat('dd-MM-yyyy').format(selectDates.end)} pour une période de ${selectDates.duration.inDays} nuitée(s)",style: const TextStyle(fontWeight: FontWeight.bold)),
                        )
                        : Center(child: const Text("Choisir le séjour.")),
                  ),
                    const SizedBox(
                    height:20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: size.width,
                          height: 25,
                          child: TextFormField(
                            controller: nmbreHommeController,
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: "Nombre Homme"),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(
                        width: size.width,
                          height: 25,
                          child: TextFormField(
                            controller: nmbreFemmeController,
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: "Nombre Femme"),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                          const SizedBox(
                    height:20,
                  ),
                        SizedBox(
                         width: size.width,
                          height: 25,
                          child: TextFormField(
                            controller: nmbrEnfantController,
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: "Nombre Homme"),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                   width: size.width,
                          height: 25,
                    child: TextFormField(
                      controller: nomController,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(), labelText: "Nom"),
                      // keyboardType: TextInputType.name,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: size.width,
                          height: 25,
                    child: TextFormField(
                      controller: prenomController,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(), labelText: "Prénoms"),
                      // keyboardType: TextInputType.name,
                    ),
                  ),
                    const SizedBox(
                    height:20,
                  ),
                  SizedBox(
                    width: size.width,
                          height: 25,
                    child: TextField(
                        controller:
                            dateDeNaissanceController, //editing controller of this TextField
                        decoration: const InputDecoration(
                            icon:
                                Icon(Icons.calendar_today), //icon of text field
                            labelText: "Date de naissance" //label text of field
                            ),
                        readOnly: true, // when true user cannot edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(), //get today's date
                              firstDate: DateTime(
                                  1900), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('dd-MM-yyyy').format(pickedDate);
                            setState(() {
                              dateDeNaissanceController.text =
                                  formattedDate; //set foratted date to TextField value.
                            });
                          } else {
                            print("Aucune date sélectionnée !");
                          }
                        }),
                  ),
                  const SizedBox(
                    height:20,
                  ),
                  SizedBox(
                 width: size.width,
                          height: 25,
                    child: TextFormField(
                      controller: numeroPieceIdentiteController,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "Numéro de la pièce"),
                      //  keyboardType: TextInputType.name,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                  width: size.width,
                          height: 25,
                    child: TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "Téléphone"),
                      // keyboardType: TextInputType.phone,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                 width: size.width,
                          height: 25,
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(), labelText: "mail"),
                      // keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const Text("Facture",style: TextStyle(fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 300,
                      width: size.width,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const Text("Désignation",style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(
                                  "${widget.appartement['nomBaptiserBienImmobilier']}"
                                      .toUpperCase())
                            ],
                          ),
                          Column(
                            children: [
                              const Text("Prix",style: TextStyle(fontWeight: FontWeight.bold) ),
                              Text("${widget.appartement['priceCategorie']}"
                                  .toUpperCase())
                            ],
                          ),
                          Column(
                            children: [
                              const Text("Catégorie",style: TextStyle(fontWeight: FontWeight.bold)),
                              Text("${widget.appartement['nameCategorie']}"
                                  .toUpperCase())
                            ],
                          ),
                          Column(
                            children: [
                              const Text("Nuité",style: TextStyle(fontWeight: FontWeight.bold)),
                              Text("${selectDates.duration.inDays}"
                                  .toUpperCase())
                            ],
                          ),
                          if ((selectDates.duration.inDays >=
                              widget.appartement['pourcentReducCategorie']))
                            Column(
                              children: [
                                const Text("Réduction"),
                                Text(
                                    "${widget.appartement['pourcentReducCategorie']}"
                                        .toUpperCase())
                              ],
                            ),
                          Column(
                            children: [
                              const Text("Total",style: TextStyle(fontWeight: FontWeight.bold),),
                              (selectDates.duration.inDays >=
                                      widget.appartement[
                                          'pourcentReducCategorie'])
                                  ? Text(
                                      "${selectDates.duration.inDays * widget.appartement['priceCategorie'] * (1 - widget.appartement['pourcentReducCategorie'] / 100)}"
                                          .toUpperCase())
                                  : Text(
                                      "${selectDates.duration.inDays * widget.appartement['priceCategorie']} FCFA"
                                          .toUpperCase())
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                          width: size.width * 0.40,
                          child: ElevatedButton(
                            
                            onPressed: () {
                              // setState(() {
                              context.read<SaveReservationBloc>().add(
                                  SaveReservationEvent(
                                      reservationRequestDto:
                                          ReservationRequestDto(
                                              montantCautionBail: 0,
                                              nmbrEnfant: int.tryParse(
                                                  nmbrEnfantController.text),
                                              // genre: "F",
                                              nouveauMontantLoyer: 0,
                                              nmbreFemme: int.tryParse(
                                                  nmbreFemmeController.text),
                                              nmbreHomme: int.tryParse(
                                                  nmbreHommeController.text),
                                              soldReservation: (selectDates
                                                          .duration.inDays >=
                                                      widget.appartement[
                                                          'pourcentReducCategorie'])
                                                  ? double.tryParse(
                                                      "${selectDates.duration.inDays * widget.appartement['priceCategorie'] * (1 - widget.appartement['pourcentReducCategorie'])}")
                                                  : double.tryParse(
                                                      "${selectDates.duration.inDays * widget.appartement['priceCategorie']}"),
                                              typePieceIdentite: "CNI",
                                              nationalite: "IVOIRIEN",
                                              lieuNaissance: "POY",
                                              id: 0,
                                              utilisateurIdApp: "",
                                              idUtilisateur: 0,
                                              nbreMoisCautionBail:
                                                  selectDates.duration.inDays,
                                              remainingPayment: 0,
                                              numeroPieceIdentite:
                                                  numeroPieceIdentiteController
                                                      .text,
                                              username: usernameController.text,
                                              prenom: prenomController.text,
                                              nom: nomController.text,
                                              idAgence: 1,
                                              mobile: usernameController.text,
                                              idBienImmobilier: int.tryParse(
                                                  idAppartementdDtoController.text),
                                              idBien: int.tryParse(idAppartementdDtoController.text),
                                              idAppartementdDto: int.tryParse(idAppartementdDtoController.text),
                                              email: emailController.text,
                                              dateFin: selectDates.end,
                                              dateDebut: selectDates.start,
                                              advancePayment: double.tryParse(advancePaymentController.text),
                                              dateDeNaissance: DateTime.tryParse(dateDeNaissanceController.text))));
                              // });
                            },
                            style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black87,
                        padding: const EdgeInsets.all(20.0),
                        backgroundColor: Colors.blue,
                        elevation: 15,
                        shadowColor: Colors.blueAccent,
                        side: const BorderSide(color: Colors.black12, width: 1),
                        shape: const RoundedRectangleBorder(),
                        textStyle: const TextStyle(color: Colors.white)),
                            child: const Text(
                              'Valider',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Center(
                          child: BlocBuilder<SaveReservationBloc,
                              ReservationState>(builder: (context, state) {
                            if (state is SaveReservationErrorState) {
                              return Text(
                                "Erreur : ${state.errorMessage}",
                                style: const TextStyle(color: Colors.red),
                              );
                            } else if (state is SaveReservationLoaded) {
                              return const Text(
                                "Enrégistrement éffectué avec succès .",
                                style: TextStyle(color: Colors.green),
                              );
                            }
                            return const Text("");
                          }),
                        )
                      ],
                    ),
                  ),
                  // const SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
