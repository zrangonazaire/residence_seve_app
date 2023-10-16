import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ResidenceSelect extends StatelessWidget {
  const ResidenceSelect({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
    padding:const EdgeInsets.all(10),

      color: Colors.white,
      child: Column(
        children: [
          SizedBox(           
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("550 hotels trouvées",style: GoogleFonts.nunito(color: Colors.black,fontSize: 15)),
              Row(
                children: [ Text("Filtre",style: GoogleFonts.nunito(color: Colors.black,fontSize: 15)),
                const IconButton(onPressed: null, icon: Icon(Icons.filter_list_outlined,color: Colors.green,))
              ],
              )
              ],
            ),
          ),
            
        ],
      ),
    );
  }
}
