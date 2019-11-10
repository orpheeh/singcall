import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newnum/contacts/contact_bloc.dart';
import 'package:newnum/contacts/screens/home_screen.dart';
import 'package:newnum/contacts/screens/save_contact_progress_screen.dart';
import 'package:newnum/contacts/screens/splash_screen_screen.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  String prepareNum(String num) {
    final List<String> split = num.split('+241');
    return split.length >= 2 ? split[1].trim() : split[0].trim();
  }

  bool isAirtelNumber(String num) {
    String n1 = prepareNum(num);
    if (n1.length < 2) return false;
    return n1[0] == '0' && (n1[1] == '4' || n1[1] == '7');
  }

  bool isLibertisNumber(String num) {
    String n1 = prepareNum(num);
    if (n1.length < 2) return false;
    return n1[0] == '0' &&
        (n1[1] == '2' || n1[1] == '6' || n1[1] == '5');
  }

  String numLibertisIndicator(num) {
    if (!isLibertisNumber(num)) {
      return null;
    }
    String n1 = prepareNum(num);
    return n1[0] == '0' && n1[1] == '2'
        ? '02'
        : n1[1] == '6' ? '06' : '05';
  }

  String numAirtelIndicator(num) {
    if (!isAirtelNumber(num)) {
      return null;
    }
    final List<String> split = num.split('+241');
    final String n1 = split.length >= 2 ? split[1].trim() : split[0].trim();

    return n1[0] == '0' && n1[1] == '4' ? '04' : '07';
  }

  String getNewAirtel(String num) {
    if (numAirtelIndicator(num) == '04') {
      return num.replaceFirst('04', '074');
    } else if (numAirtelIndicator(num) == '07') {
      return num.replaceFirst('07', '077');
    } else {
      return "null";
    }
  }

  bool isFixeNum(String num){
    String n1 = prepareNum(num);
    return n1[0] == '0' && n1[1] == '1';
  }

  String getNewFixe(String num){
    return num.replaceFirst('01', '011');
  }

  String getNewLibertis(String num) {
    String indicator = numLibertisIndicator(num);
    if (indicator == '02') {
      return num.replaceFirst('02', '062');
    } else if (indicator == '01') {
      return num.replaceFirst('01', '061');
    } else if (indicator == '05') {
      return num.replaceFirst('05', '065');
    } else if (indicator == '06') {
      return num.replaceFirst('06', '066');
    } else {
      return "null";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 211, 182, 1),
      body: BlocProvider<ContactBloc>(
        builder: (context) => ContactBloc()..add(AppStarted()),
        child:
            BlocBuilder<ContactBloc, ContactState>(builder: (context, state) {
          if (state is ContactSplashScreen) {
            return SplashScreen();
          }

          if (state is ContactInitial) {
            final List<Contact> translateList =
                List.generate(state.contacts.length, (index) {
              return new Contact(
                  givenName: state.contacts[index].givenName,
                  middleName: state.contacts[index].middleName,
                  familyName: state.contacts[index].familyName,
                  suffix: state.contacts[index].suffix,
                  prefix: state.contacts[index].prefix,
                  phones:
                      List.generate(state.contacts[index].phones.length, (i) {
                    String num =
                        state.contacts[index].phones.elementAt(i).value;
                    String label =
                        state.contacts[index].phones.elementAt(i).label;
                    if (isAirtelNumber(num)) {
                      return new Item(label: label, value: getNewAirtel(num));
                    } else if (isLibertisNumber(num)) {
                      return new Item(label: label, value: getNewLibertis(num));
                    } else if(isFixeNum(num)){
                      return new Item(label: label, value: getNewFixe(num));
                    } else {
                      return Item(label: "unknow", value: num);
                    }
                  }));
            });
            return HomeScreen(
              originals: state.contacts.toList(),
              translates: translateList.toList(),
            );
          }

          if (state is ContactLoading) {
            return SaveContactProgressScreen(
              givenName: state.contact.givenName,
              number: state.contact.phones.elementAt(state.numIndex).value,
              contactCount: state.contactCount,
              contactChange: state.contactChange,
            );
          }

          return Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));
        }),
      ),
    );
  }
}
