import 'package:flutter/material.dart';
import 'materias.dart';
import 'MinhaConta.dart';

class Navegacao extends StatefulWidget {
  @override
  _NavegacaoState createState() => _NavegacaoState();
}

class _NavegacaoState extends State<Navegacao> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Materias(),
    MinhaConta(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Matérias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Minha Conta',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue.shade900,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
