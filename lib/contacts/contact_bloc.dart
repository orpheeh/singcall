import 'package:bloc/bloc.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  @override
  ContactState get initialState => ContactLoading();

  @override
  Stream<ContactState> mapEventToState(ContactEvent event) async* {
    if (event is AppStarted) {
      yield ContactSplashScreen();
      // Get all contacts on device
      Iterable<Contact> contacts = await ContactsService.getContacts();
      yield ContactInitial(contacts: contacts.toList());
    }

    if (event is MigrateButtonPressed) {
      int count = 0;
      Iterable<Contact> contacts = await ContactsService.getContacts();
      while (count < event.contacts.length) {
        yield ContactLoading(
          contact: event.contacts[count],
          contactCount: event.contacts.length,
          contactChange: count,
          numIndex: 0,
        );
        Contact current = event.contacts[count];
        Contact contact = contacts.toList().firstWhere((c) =>
            c.givenName == current.givenName &&
            c.familyName == current.familyName &&
            c.middleName == current.middleName);
        contact.phones = current.phones;
        await ContactsService.updateContact(contact);
        count++;
      }
      yield ContactSplashScreen();
    }
  }
}

class ContactState {}

class ContactLoading extends ContactState {
  final Contact contact;
  final int numIndex;
  final int contactCount;
  final int contactChange;

  ContactLoading(
      {this.contactCount, this.contactChange, this.contact, this.numIndex});
}

class ContactSplashScreen extends ContactState {}

class ContactInitial extends ContactState {
  final List<Contact> contacts;

  ContactInitial({this.contacts});
}

class ContactEvent {}

class AppStarted extends ContactEvent {}

class MigrateButtonPressed extends ContactEvent {
  final List<Contact> contacts;

  MigrateButtonPressed({this.contacts});
}
