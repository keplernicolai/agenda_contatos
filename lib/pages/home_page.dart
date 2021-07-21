import 'dart:io';
import 'package:agenda_contatos/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();

  List<Contact> contactList = List();

  @override
  void initState() {
    super.initState();
    helper.getAllContact().then((list) {
      setState(() {
        contactList = list;
      });

      // for (var item in contactList) {
      //   setState(() {
      //     item.img = "";
      //     helper.updateContact(item);
      //   });
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contatos",
          style: TextStyle(color: Colors.yellowAccent),
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(
          Icons.add,
          color: Colors.yellowAccent,
        ),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: contactList.length,
        itemBuilder: (context, index) {
          return _contactCard(context, contactList[index]);
        },
      ),
    );
  }

  Widget _contactCard(BuildContext context, Contact contact) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            children: [
              Container(
                height: 80.0,
                width: 80.0,
                child: contact.img != null && contact.img.isNotEmpty
                    ? FileImage(File(contact.img))
                    : Icon(
                        Icons.person,
                        size: 80.0,
                      ),
                decoration: BoxDecoration(shape: BoxShape.circle),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact.name ?? "",
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      contact.email ?? "",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      contact.phone ?? "",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
