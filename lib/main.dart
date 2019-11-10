import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'contacts/contact_page.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Sing Call',
        theme: ThemeData(
          backgroundColor: Colors.blue,
          primarySwatch: Colors.yellow,
          fontFamily: 'NunitoSans'
        ),
        home: ContactPage());
  }
}
