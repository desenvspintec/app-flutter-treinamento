import 'dart:convert';

import 'package:aula_app/modelo/Cliente.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FrmCadastroCliente extends StatefulWidget {
    final String url;

    FrmCadastroCliente({this.url});

    @override
    _FrmCadastroClienteState createState() => new _FrmCadastroClienteState();
}

class _FrmCadastroClienteState extends State<FrmCadastroCliente> {
    var _scaffoldKey = new GlobalKey<ScaffoldState>();

    List<Cliente> _listaClientes = new List();

    @override
    void initState() {
        super.initState();

        Future.delayed(Duration.zero, () async {
            await _carregarClientes();
        });
    }

    Future<void> _carregarClientes() async {
        String endereco = "http://200.237.160.253:8080/Aula/metodos/cadastro/cliente/obter";
        var response = await http.get(endereco);

        if  (response.statusCode == 200) {
            var resposta = json.decode(response.body);

            resposta['dados'].forEach((dado) {
                setState(() {
                    _listaClientes.add(Cliente.fromJson(json.decode(dado)['Cliente']));
                });
            });
        }
    }

    Widget _visualizacao() {
        return Container(
            child: ListView(
                children: _listaClientes.map((cliente) {
                    return ListTile(
                        title: Text(cliente.nmCliente),
                        subtitle: Text('Código: ' + cliente.cdCliente.toString()),
                        leading: Icon(Icons.person),
                    );
                }).toList(),
            )
        );
    }

    @override
    Widget build(BuildContext context) {
        return new Scaffold(
            key: _scaffoldKey,
            appBar: new AppBar(
                title: new Text(
                    'Cadastrar cliente',
                    style: TextStyle(color: Colors.white),
                ),
            ),
            body: _visualizacao());
    }
}
