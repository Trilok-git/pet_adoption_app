import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'blocs/home/counter_cubit.dart';
import 'blocs/home/pet_cubit.dart';
import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context, Widget? child) =>
      MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme,
          ),
          primaryColor: Color(0xff1b797a),
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blue,
          cardColor: Colors.white,
        ),
        darkTheme: ThemeData(
            textTheme:
            GoogleFonts.robotoTextTheme(
              Theme.of(context).textTheme,
            ),
            primaryColor: Color(0xff1b797a),
          scaffoldBackgroundColor: Colors.black,
          cardColor: Colors.white10
        ),
        themeMode: ThemeMode.system,
        // ThemeData(
        //   textTheme: GoogleFonts.robotoTextTheme(
        //     Theme.of(context).textTheme,
        //   ),
        // ),
        home: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => PetCubit()),
              BlocProvider(create: (_) => CounterCubit()),
            ],
            child: Home()
        )


        // const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}


