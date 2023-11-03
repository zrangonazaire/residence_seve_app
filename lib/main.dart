import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:residence_seve_app/blocs/categories/categorrie_bloc.dart';
import 'package:residence_seve_app/blocs/images/image_bloc.dart';
import 'package:residence_seve_app/blocs/prix_par_categorie/prix_par_categorie_bloc.dart';
import 'package:residence_seve_app/blocs/reservation/reservation_bloc.dart';
import 'package:residence_seve_app/pages/admin_page.dart';
import 'package:residence_seve_app/pages/home_page.dart';
import 'package:residence_seve_app/pages/page_reservation.dart';

import 'blocs/appartement_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppartementBloc()),
        BlocProvider(create: (context) => ListeImagesBloc()),
        BlocProvider(create: (context) => ImageBloc()),
        BlocProvider(create: (context) => FindAllCategorieBloc()),
        BlocProvider(create: (context) => CategorieBloc()),
        BlocProvider(create: (context) => SavePrixParCategorieBloc()),
        BlocProvider(create: (context) => SaveReservationBloc()),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/admin': (context) => const AdminPage(),
          '/reservation': (context) => const PageReservion(),
          // '/detail':(context) => const PageDetail(appats: appats)
        },
        title: 'Severin App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
