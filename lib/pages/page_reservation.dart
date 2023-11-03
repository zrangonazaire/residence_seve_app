import 'package:flutter/material.dart';
import 'package:residence_seve_app/constants.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class PageReservion extends StatefulWidget {
  const PageReservion({super.key});

  @override
  State<PageReservion> createState() => _PageReservionState();
}

List _isHovering = [
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false
];

class _PageReservionState extends State<PageReservion> {
  var _range = '';

  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
    setState(() {
      if (args.value is PickerDateRange) {
        _range = 'Arrivée ${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' Départ ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
      } else if (args.value is List<DateTime>) {
      } else {
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const MenuWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: screenSize.width,
              height: 60,
              decoration: const BoxDecoration(color: Colors.black),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {},
                        onHover: (value) {
                          setState(() {
                            value
                                ? _isHovering[4] = true
                                : _isHovering[4] = false;
                          });
                        },
                        child: Text(
                          "Accueil".toUpperCase(),
                          style: TextStyle(
                              color: _isHovering[4] ? Colors.red : Colors.white,
                              fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width / 20,
                      ),
                      InkWell(
                        onTap: () {},
                        onHover: (value) {
                          setState(() {
                            value
                                ? _isHovering[5] = true
                                : _isHovering[5] = false;
                          });
                        },
                        child: Text(
                          "LOGEMENTS",
                          style: TextStyle(
                              color: _isHovering[5] ? Colors.red : Colors.white,
                              fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width / 20,
                      ),
                      InkWell(
                        onTap: () {},
                        onHover: (value) {
                          setState(() {
                            value
                                ? _isHovering[6] = true
                                : _isHovering[6] = false;
                          });
                        },
                        child: Text(
                          "VILLAS",
                          style: TextStyle(
                              color: _isHovering[6] ? Colors.red : Colors.white,
                              fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width / 20,
                      ),
                      InkWell(
                        onTap: () {},
                        onHover: (value) {
                          setState(() {
                            value
                                ? _isHovering[7] = true
                                : _isHovering[7] = false;
                          });
                        },
                        child: Text(
                          "CONTACT",
                          style: TextStyle(
                              color: _isHovering[7] ? Colors.red : Colors.white,
                              fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width / 10,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Center(
              child: SizedBox(
                width: screenSize.width * 0.6,
                height: 300,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Text('Selected date: $_selectedDate'),
                          //Text('Selected date count: $_dateCount'),
                          Text(
                            'Période de séjour : $_range',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          //Text('Selected ranges count: $_rangeCount')
                        ],
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 80,
                      right: 0,
                      bottom: 0,
                      child: SfDateRangePicker(
                        onSelectionChanged: _onSelectionChanged,
                        selectionMode: DateRangePickerSelectionMode.range,
                        initialSelectedRange: PickerDateRange(
                            DateTime.now().subtract(const Duration(days: 4)),
                            DateTime.now().add(const Duration(days: 3))),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: screenSize.width * 0.5,
              height: screenSize.height * 0.4,
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 300,
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nom et prénoms',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1)),
                                hintText: 'Nom et prénoms',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Téléphone',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1)),
                                hintText: 'Téléphone',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 650,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Numéro de la pièce d'identité",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1)),
                            hintText: 'Téléphone',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.teal,
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Valider",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
