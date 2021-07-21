import 'package:agenda_contatos/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  final Contact contact;

  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  Contact _editContact;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.contact == null) {
      _editContact = Contact();
    } else {
      _editContact = Contact.fromMap(widget.contact.toMap());
    }
  }

  void titleChanged(String text) {
    setState(() {
      _editContact.name = text;

      if (text.isEmpty) {
        _editContact.name = "Novo Contato";
      }
    });
  }

  _selecionarFoto() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editContact.name ?? "Novo Contato"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.save),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: _selecionarFoto,
              child: Container(
                alignment: Alignment.center,
                height: 140.0,
                width: 140.0,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: _editContact.img != null && _editContact.img.isNotEmpty
                    ? _editContact.img
                    : Icon(
                        Icons.person,
                        size: 140.0,
                      ),
              ),
            ),
            buildTextField("Nome", nameController, changed: titleChanged),
            Divider(),
            buildTextField("E-mail", emailController),
            Divider(),
            buildTextField("Telefone", phoneController)
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController textController,
      {Function changed}) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
      ),
      onChanged: changed,
      controller: textController,
    );
  }
}
