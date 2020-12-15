import 'package:aula_app/funcoes/FrmCadastroCliente.dart';
import 'package:aula_app/funcoes/FrmCadastroClienteEdit.dart';
import 'package:aula_app/funcoes/FrmPrincipal.dart';
import 'package:aula_app/util/AulaAppColorUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(AulaApp());

class AulaApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aula App',
      theme: new ThemeData(
        primarySwatch: AulaAppColorUtil.AulaAmarelo,
        primaryIconTheme: new IconThemeData(color: Colors.white),
        primaryColorBrightness: Brightness.dark,),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt')],
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => FrmPrincipal(),
        '/cadastrarCliente': (BuildContext context) => FrmCadastroCliente(),
        '/cadastrarClienteEdit': (BuildContext context) => FrmCadastroClienteEdit(),
      },
    );
  }
}