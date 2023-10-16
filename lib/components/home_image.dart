import 'package:flutter/material.dart';
import 'package:residence_seve_app/components/image_card_widget.dart';
import 'package:residence_seve_app/components/save_reservation_widget.dart';
import 'package:residence_seve_app/pages/page_detail.dart';

class HomeImageWidget extends StatefulWidget {
  const HomeImageWidget({
    super.key,
    required this.appats,
  });

  final dynamic appats;

  @override
  State<HomeImageWidget> createState() => _HomeImageWidgetState();
}

class _HomeImageWidgetState extends State<HomeImageWidget> {
  final descController = TextEditingController();
  final prixController = TextEditingController();
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                //color: Colors.black,
                blurRadius: 10,
                spreadRadius: 0,
                offset: Offset(0, 0)),
          ],
        ),
        height: 450,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    //   print("objec is ${appats[index]}");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PageDetail(appats: widget.appats)),
                    );
                  },
                  child: CardImageAppart(
                      idBien: int.parse(widget.appats['id'].toString())),
                ),
                TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (ctx) => SaveReservationWidget());
                    },
                    child: Text("Réserver"))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                              color: Colors.green.shade400,
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        widget.appats['occupied'] == true
                            ? const Text(
                                "Appartement (Occupé)",
                              )
                            : const Text(
                                "Appartement (Disponible)",
                              ),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Catégorie 1 de 1 à 5 jours :",
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          "2500 XOF",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          "la nuitée",
                        ),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "1 ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Salon(s)",
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              "2 ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Douche(s)",
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              "1 ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Télévision(s)",
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      "${widget.appats['nomCompletBienImmobilier']!}",
                      maxLines: 4,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
