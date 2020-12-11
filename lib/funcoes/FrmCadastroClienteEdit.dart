import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class FrmCadastroClienteEdit extends StatefulWidget {
  final String url;

  FrmCadastroClienteEdit({this.url});

  @override
  _FrmCadastroClienteEditState createState() => new _FrmCadastroClienteEditState();
}

class _FrmCadastroClienteEditState extends State<FrmCadastroClienteEdit> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>();

  TextEditingController _edNome = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Widget _visualizacao() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Nome do cliente'),
              controller: _edNome,
              autofocus: true,
              keyboardType: TextInputType.text,
              maxLength: 70,
              validator: (valor) {
                return valor.isEmpty ? 'Campo obrigatório' : null;
              },
            )
          ],
        ),
      ),
    );
  }

  void _mostrarDlgEspera(BuildContext contexto) {
    showDialog(
        context: contexto,
        barrierDismissible: false,
        builder: (c) => AlertDialog(
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text('Salvando...', softWrap: true,),
                ),
              )
            ],
          ),
        ));
  }

  Future<void> _salvar() async {
    if (_formKey.currentState.validate()) {
      _mostrarDlgEspera(context);

      String endereco = "http://200.237.160.253:8080/Aula/metodos/cadastro/cliente/adicionar";

      Map cadastro = {
        'cdCliente': null,
        'nmCliente': _edNome.text.toUpperCase()
      };

      var response = await http.post(endereco, headers: {"Content-Type": "application/json"}, body: json.encode(cadastro));

      if  (response.statusCode == 200) {
          Navigator.pop(context);
          Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          title: new Text(
            'Editar cliente',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            FlatButton(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.save, color: Colors.white,),
                  ),
                  Text('Salvar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                ],
              ),
              onPressed: () async => await _salvar(),
            )
          ],
        ),
        body: _visualizacao());
  }
}
