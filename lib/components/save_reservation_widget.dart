import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SaveReservationWidget extends StatefulWidget {
  const SaveReservationWidget({super.key});

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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AlertDialog(
      scrollable: false,
      content: Stack(
        children: [
          SizedBox(
            width: size.height ,
            height: size.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Validation de la réservation",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14.0,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final DateTimeRange? dateRange = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(3000));
                      if (dateRange != null) {
                        setState(() {
                          selectDates = dateRange;
                        });
                      }
                    },
                    child: (selectDates.duration.inDays > 0)
                        ? Text(
                            "Séjour du ${DateFormat('dd-MM-yyyy').format(selectDates.start)} au ${DateFormat('dd-MM-yyyy').format(selectDates.end)} pour une période de ${selectDates.duration.inDays - 1} nuitée(s)")
                        : const Text("Choisir le séjour."),
                  ),
            
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.2,
                        width: size.width * 0.15,
                        child: TextFormField(
                          controller: nomController,
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(), labelText: "Nom"),
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      SizedBox(
                        height: size.height * 0.2,
                        width: size.width * 0.2,
                        child: TextFormField(
                          controller: prenomController,
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: "Prénoms"),
                          keyboardType: TextInputType.name,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.2,
                        width: size.width * 0.15,
                        child: TextField(
                            controller:
                                dateDeNaissanceController, //editing controller of this TextField
                            decoration: const InputDecoration(
                                icon: Icon(
                                    Icons.calendar_today), //icon of text field
                                labelText:
                                    "Date de naissance" //label text of field
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
                                String formattedDate = DateFormat('dd-MM-yyyy')
                                    .format(
                                        pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
            
                                setState(() {
                                  dateDeNaissanceController.text =
                                      formattedDate; //set foratted date to TextField value.
                                });
                              } else {
                                print("Date is not selected");
                              }
                            }),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      SizedBox(
                        height: size.height * 0.2,
                        width: size.width * 0.2,
                        child: TextFormField(
                          controller: prenomController,
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: "Prénoms"),
                          keyboardType: TextInputType.name,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.2,
                        width: size.width * 0.15,
                        child: TextFormField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: "Téléphone"),
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      SizedBox(
                        height: size.height * 0.2,
                        width: size.width * 0.2,
                        child: TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(), labelText: "mail"),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 40,
                        width: size.height * 0.50,
                        child: ElevatedButton(
                          onPressed: () {},
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
                    ],
                  ),
                  // const SizedBox(height: 10.0),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
