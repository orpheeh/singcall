import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class ContactFolderScreen extends StatefulWidget {
  final String label;
  final List<Contact> contacts;

  const ContactFolderScreen(
      {Key key, @required this.label, @required this.contacts})
      : super(key: key);

  @override
  _ContactFolderScreenState createState() => _ContactFolderScreenState();
}

class _ContactFolderScreenState extends State<ContactFolderScreen> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0, bottom: 16.0),
            child: Text(widget.label,
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 146, 13, 84))),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.contacts.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        widget.contacts[index].givenName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700]),
                      ),
                      subtitle: Text(
                          widget.contacts[index].phones.elementAt(0).value),
                      leading: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 146, 13, 84),
                        child: Text(widget.contacts[index].initials()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
                      child: Row(
                        children: List.generate(
                            widget.contacts[index].phones.length-1, (i) {
                           return  Padding(
                             padding: const EdgeInsets.only(right: 8.0),
                             child: Text(
                                    "${widget.contacts[index].phones.elementAt(i+1).value}", style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.grey
                                    ),),
                           );
                        }),
                      ),
                    ),
                    Divider()
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
