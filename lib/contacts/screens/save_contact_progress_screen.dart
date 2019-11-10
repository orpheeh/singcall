import 'package:flutter/material.dart';

class SaveContactProgressScreen extends StatefulWidget {
  final String givenName;
  final String number;
  final int contactCount;
  final int contactChange;

  const SaveContactProgressScreen(
      {Key key,
      @required this.givenName,
      @required this.number,
      @required this.contactCount,
      @required this.contactChange})
      : super(key: key);

  @override
  _SaveContactProgressScreenState createState() =>
      _SaveContactProgressScreenState();
}

class _SaveContactProgressScreenState extends State<SaveContactProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text("Migration".toUpperCase()),
          Text("${widget.givenName}"),
          Text("${widget.number}"),
          Text("${widget.contactChange} / ${widget.contactCount }")
        ],
      ),
    );
  }
}
