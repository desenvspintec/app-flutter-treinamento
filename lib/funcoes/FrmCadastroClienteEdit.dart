import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FrmCadastroClienteEdit extends StatefulWidget {
    final String url;

    FrmCadastroClienteEdit({this.url});

    @override
    _FrmCadastroClienteEditState createState() => new _FrmCadastroClienteEditState();
}

class _FrmCadastroClienteEditState extends State<FrmCadastroClienteEdit> {
    var _scaffoldKey = new GlobalKey<ScaffoldState>();

    @override
    void initState() {
        super.initState();
    }

    Widget _visualizacao() {
        return Container(
            child: Column(
                children: [
                    Text('Teste')
                ],
            ),
        );
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
            ),
            body: _visualizacao());
    }
}
