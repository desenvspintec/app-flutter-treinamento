import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FrmPrincipal extends StatefulWidget {
    final String url;

    FrmPrincipal({this.url});

    @override
    _FrmPrincipalState createState() => new _FrmPrincipalState();
}

class _FrmPrincipalState extends State<FrmPrincipal> {
    var _scaffoldKey = new GlobalKey<ScaffoldState>();

    @override
    void initState() {
        super.initState();
    }

    Widget _visualizacao() {
        return Container(
            child: Column(),
        );
    }

    @override
    Widget build(BuildContext context) {
        return new Scaffold(
            key: _scaffoldKey,
            appBar: new AppBar(
                title: new Text(
                    'Aula App',
                    style: TextStyle(color: Colors.white),
                ),
            ),
            drawer: Drawer(
                child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (BuildContext contexto, int index) {
                        switch (index) {
                            case 0:
                                return DrawerHeader(
                                    child: Text('Header'),
                                );
                            case 1:
                                return ListTile(
                                    title: Text('Cadastro de cliente'),
                                    leading: Icon(Icons.people),
                                    subtitle: Text('Detalhes'),
                                    onTap: () => Navigator.pushNamed(contexto, "/cadastrarCliente"),
                                );
                            default: return Container();
                        }
                    }
                ),
            ),
            body: _visualizacao());
    }
}