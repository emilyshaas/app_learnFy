import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ciencia.dart';
import 'humana.dart';
import 'linguagem.dart';
import 'matematica.dart';
import 'redacao.dart';

class FavoritosScreen extends StatefulWidget {
  @override
  _FavoritosScreenState createState() => _FavoritosScreenState();
}

class _FavoritosScreenState extends State<FavoritosScreen> {
  Set<String> favoritos = {};

  @override
  void initState() {
    super.initState();
    _loadFavoritos();
  }

  Future<void> _loadFavoritos() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? favoritosSalvos = prefs.getStringList('favoritos');
    if (favoritosSalvos != null) {
      setState(() {
        favoritos = favoritosSalvos.toSet();
      });
    }
  }

  void _navigateToMateria(String materia) {
    Widget page;

    switch (materia) {
      case 'Ciências da Natureza':
        page = Ciencia();
        break;
      case 'Ciências Humanas':
        page = Humana();
        break;
      case 'Linguagens e Tecnologias':
        page = Linguagem();
        break;
      case 'Matemática e Tecnologias':
        page = Matematica();
        break;
      case 'Redação':
        page = Redacao();
        break;
      default:
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meus Favoritos',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Container(
        color: Colors.white,
        child: favoritos.isEmpty
            ? Center(
          child: Text(
            'Você ainda não possui favoritos.',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        )
            : ListView(
          padding: EdgeInsets.all(16.0),
          children: favoritos.map((materia) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.blue.shade900,
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16.0),
                title: Text(
                  materia,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                leading: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                onTap: () {
                  _navigateToMateria(materia);
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
