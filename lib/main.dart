import 'package:app_2tri/navegacao.dart';
import 'package:flutter/material.dart';
import 'tela_principal.dart';

void main() {
  runApp(MaterialApp(
    home: MeuApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MeuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TelaPrincipal(),
    );
  }
}
