import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuWidget extends StatelessWidget implements PreferredSize {
  const MenuWidget({
    super.key,
  });
  @override
  Size get preferredSize => const Size.fromHeight(40.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.purple,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
      elevation: 2,
      title: Text(
        "Les résidences Seve",
        style: GoogleFonts.nunito(
            color: Colors.white),
      ),
      centerTitle: true,
      leading:  IconButton(
          onPressed: (){},
          icon: const Icon(
            Icons.menu
          )),
          actions: [
            
           IconButton(onPressed: (){
            Navigator.pushNamed(context, '/admin');
           }, icon: const Icon(
            Icons.admin_panel_settings,color: Colors.white,
          )),
          IconButton(onPressed: (){}, icon: const Icon(
            Icons.search,color: Colors.white,
          )),
          ],
    );
  }

  @override
  Widget get child => throw UnimplementedError();
}
