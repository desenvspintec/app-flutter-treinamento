import 'dart:convert';

import 'package:aula_app/funcoes/FrmCadastroClienteEdit.dart';
import 'package:aula_app/modelo/Cliente.dart';
import 'package:aula_app/util/DatabaseHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aula_app/util/DatabaseHelper.dart';

class FrmCadastroCliente extends StatefulWidget {
  final String url;

  FrmCadastroCliente({this.url});

  @override
  _FrmCadastroClienteState createState() => new _FrmCadastroClienteState();
}

class _FrmCadastroClienteState extends State<FrmCadastroCliente> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Cliente> _listaClientes = new List();
  List<Cliente> _listaClientesFiltrada = new List();
  DatabaseHelper _databaseHelper = new DatabaseHelper();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      await _carregarClientes();
    });
  }

  Future<void> _carregarClientes() async {
    // String endereco = "http://200.237.160.253:8080/Aula/metodos/cadastro/cliente/obter";
    // var response = await http.get(endereco);
    //
    // if (response.statusCode == 200) {
    //   var resposta = json.decode(response.body);
    //
    //   _listaClientes.clear();
    //   _listaClientesFiltrada.clear();
    //
    //   resposta['dados'].forEach((dado) {
    //     setState(() {
    //       _listaClientes.add(Cliente.fromJson(json.decode(dado)['Cliente']));
    //       _listaClientesFiltrada.add(Cliente.fromJson(json.decode(dado)['Cliente']));
    //     });
    //   });
    // }

    List<Map<String, dynamic>> dados = await _databaseHelper.getSQLSelect("Select * from cliente order by nm_cliente");
    _listaClientes.clear();
    _listaClientesFiltrada.clear();

    dados.forEach((dado) {
      setState(() {
        _listaClientes.add(Cliente.fromMap(dado));
        _listaClientesFiltrada.add(Cliente.fromMap(dado));
      });
    });
  }

  void _filtrarClientes(String cliente) {
    if  (cliente == null || cliente.isEmpty) {
      setState(() {
        _listaClientesFiltrada = _listaClientes;
      });
    } else {
      setState(() {
        _listaClientesFiltrada = _listaClientes.where((element) => element.nmCliente.toUpperCase().contains(cliente.toUpperCase())).toList();
      });
    }
  }

  Future<void> _editar(Cliente cliente) async {
    await Navigator.push(context, MaterialPageRoute(
      builder: (context) => FrmCadastroClienteEdit(
        cliente: cliente,
      )
    ));

    await _carregarClientes();
  }

  Future<void> _deletar(int cdCliente) async {
      // String endereco = "http://200.237.160.253:8080/Aula/metodos/cadastro/cliente/excluir/$cdCliente";
      //
      // var response = await http.delete(endereco);
      //
      // if  (response.statusCode == 200) {
      // }

    await _databaseHelper.deleteSQL("delete from cliente where cd_cliente = $cdCliente");
  }

  Widget _visualizacao() {
    return Container(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Filtrar'
            ),
            onChanged: (valor) {
              _filtrarClientes(valor);
            },
          ),
        ),
        Expanded(
          child: ListView(
            children: _listaClientesFiltrada.map((cliente) {
              return Dismissible(
                key: ObjectKey(cliente.cdCliente),
                onDismissed: (direction) async {
                  await _deletar(cliente.cdCliente);
                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text('Cliente deletado com sucesso'),
                  ));
                },
                background: Container(
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                child: ListTile(
                  title: Text(cliente.nmCliente),
                  subtitle: Text('Código: ' + cliente.cdCliente.toString()),
                  leading: Icon(Icons.person),
                  onTap: () async => _editar(cliente),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    ));
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
      body: _visualizacao(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/cadastrarClienteEdit');
          await _carregarClientes();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
