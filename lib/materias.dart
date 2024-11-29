import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ciencia.dart';
import 'humana.dart';
import 'linguagem.dart';
import 'matematica.dart';
import 'redacao.dart';

class Materias extends StatefulWidget {
  @override
  _MateriasState createState() => _MateriasState();
}

class _MateriasState extends State<Materias> {
  Set<String> favoritos = {};

  @override
  void initState() {
    super.initState();
    _loadFavoritos();
  }

  Future<void> _loadFavoritos() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? favoritosSalvos = prefs.getStringList('favoritos');
    setState(() {
      favoritos = favoritosSalvos?.toSet() ?? {};
    });
  }

  Future<void> _toggleFavorito(String materia) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (favoritos.contains(materia)) {
        favoritos.remove(materia);
      } else {
        favoritos.add(materia);
      }
    });
    await prefs.setStringList('favoritos', favoritos.toList());
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
        title: Text('Matérias'),
        backgroundColor: Colors.blue.shade900,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildButton('Ciências da Natureza'),
            buildButton('Ciências Humanas'),
            buildButton('Linguagens e Tecnologias'),
            buildButton('Matemática e Tecnologias'),
            buildButton('Redação'),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String materia) {
    bool isFavorited = favoritos.contains(materia);

    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 125,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blue.shade900,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                _navigateToMateria(materia);
              },
              child: Text(
                materia,
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              isFavorited ? Icons.favorite : Icons.favorite_border,
              color: isFavorited ? Colors.red : Colors.white,
            ),
            onPressed: () {
              _toggleFavorito(materia);
            },
          ),
        ],
      ),
    );
  }
}
