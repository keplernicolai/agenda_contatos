import 'package:agenda_contatos/helpers/contact_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContactPage extends StatefulWidget {
  final Contact contact;

  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  Contact _editContact;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  final _nameFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    if (widget.contact == null) {
      _editContact = Contact();
    } else {
      _editContact = Contact.fromMap(widget.contact.toMap());

      _nameController.text = _editContact.name;
      _emailController.text = _editContact.email;
      _phoneController.text = _editContact.phone;
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
        onPressed: () {
          if (_editContact.name != null && _editContact.name.isNotEmpty) {
            Navigator.pop(context, _editContact);
          } else {
            FocusScope.of(context).requestFocus(_nameFocus);
          }
        },
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
            buildTextField("Nome", _nameController, TextInputType.name,
                changed: titleChanged, focus: _nameFocus),
            Divider(),
            buildTextField(
                "E-mail", _emailController, TextInputType.emailAddress),
            Divider(),
            buildTextField("Telefone", _phoneController, TextInputType.phone)
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController textController,
      TextInputType keyboard,
      {Function changed, FocusNode focus}) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
      ),
      onChanged: changed,
      controller: textController,
      keyboardType: keyboard,
      focusNode: focus,
    );
  }
}
