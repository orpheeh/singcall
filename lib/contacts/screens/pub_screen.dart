import 'package:flutter/material.dart';

class PubScreen extends StatefulWidget {
  @override
  _PubScreenState createState() => _PubScreenState();
}

class _PubScreenState extends State<PubScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.check,
              color: Colors.green,
            ),
            Text("Migration effectué avec succès"),
            Card(
              child: Column(
                children: <Widget>[Text("Présentation de la SING")],
              ),
            ),
            Card(
              child: Column(
                children: <Widget>[Text("Cohorte")],
              ),
            ),
            Card(
              child: Column(
                children: <Widget>[Text("Tech clinic")],
              ),
            ),
          ],
        )
      ],
    );
  }
}
