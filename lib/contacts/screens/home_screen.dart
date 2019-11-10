import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newnum/contacts/contact_bloc.dart';
import 'package:newnum/contacts/screens/contact_folder_screen.dart';

class HomeScreen extends StatefulWidget {
  final List<Contact> originals;
  final List<Contact> translates;

  const HomeScreen(
      {Key key, @required this.originals, @required this.translates})
      : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              top: 32.0, left: 16.0, right: 16.0, bottom: 32.0),
          child: Text(
            "Faites migrer tout les numéros de votre repertoire vers la nouvelle numérotation à 9 chiffres",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w900,
                color: Colors.white),
          ),
        ),
        Expanded(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width - 50,
                child: ContactFolderScreen(
                  label: "Votre repertoire actuel",
                  contacts: widget.originals,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 50,
                child: ContactFolderScreen(
                  label: "Votre repertoire après migration",
                  contacts: widget.translates,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: RaisedButton(
            child: Text(
              "Effectuer la migration".toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            color: Color.fromARGB(255, 3, 112, 138),
            textColor: Colors.white,
            onPressed: () {
              BlocProvider.of<ContactBloc>(context)
                  .add(new MigrateButtonPressed(contacts: widget.translates));
            },
          ),
        )
      ],
    );
  }
}
