import 'package:flutter/material.dart';

class Matematica extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matemática e suas tecnologias'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Center(
        child: Container(
          width: 500,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blue.shade900,
          ),
          child: ElevatedButton(
            onPressed: () {
            },
            child: Text(
              'Matemática e suas tecnologias',
              style: TextStyle(fontSize: 24),
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
      ),
    );
  }
}
