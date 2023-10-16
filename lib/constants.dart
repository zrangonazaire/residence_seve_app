import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuWidget extends StatelessWidget implements PreferredSize {
  const MenuWidget({
    super.key,
  });
  Size get preferredSize => const Size.fromHeight(40.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        "Les résidences Seve",
        style: GoogleFonts.nunito(
            color: Colors.black, fontSize: 22, fontWeight: FontWeight.w800),
      ),
      centerTitle: true,
      leading: IconButton(
          onPressed: null,
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey[800],
          )),
          actions: [
            IconButton(onPressed: null, icon: Icon(
            Icons.favorite_border_outlined,
            color: Colors.grey[800],
          )),
           IconButton(onPressed: null, icon: Icon(
            Icons.place_rounded,
            color: Colors.grey[800],
          )),
         
          ],
    );
  }

  @override
  Widget get child => throw UnimplementedError();
}
