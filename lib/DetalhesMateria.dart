import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ciencia.dart';
import 'package:app_2tri/humana.dart';
import 'linguagem.dart';
import 'matematica.dart';
import 'redacao.dart';

class DetalhesMateria extends StatefulWidget {
  final String materia;

  DetalhesMateria({required this.materia});

  @override
  _DetalhesMateriaState createState() => _DetalhesMateriaState();
}

class _DetalhesMateriaState extends State<DetalhesMateria> {
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

  Future<void> _addRemoveFavorito(String materia) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (favoritos.contains(materia)) {
        favoritos.remove(materia);
      } else {
        favoritos.add(materia);
      }
      prefs.setStringList('favoritos', favoritos.toList());
    });
  }

  void _navigateToMateria(String materia) {
    Widget page;

    switch (materia) {
      case 'Biologia':
      case 'Química':
      case 'Física':
        page = Ciencia();
        break;
      case 'História':
      case 'Geografia':
      case 'Filosofia':
      case 'Sociologia':
        page = Humana();
        break;
      case 'Português':
      case 'Literatura':
      case 'Língua Estrangeira':
      case 'Artes':
      case 'Educação Física':
      case 'Tecnologias da Informação e Comunicação':
        page = Linguagem();
        break;
      case 'Matemática':
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
    bool isFavorito = favoritos.contains(widget.materia);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.materia),
        actions: [
          IconButton(
            icon: Icon(
              isFavorito ? Icons.favorite : Icons.favorite_border,
              color: isFavorito ? Colors.red : null,
            ),
            onPressed: () {
              _addRemoveFavorito(widget.materia);
            },
          ),
        ],
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            _navigateToMateria(widget.materia);
          },
          child: Text(
            widget.materia,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
