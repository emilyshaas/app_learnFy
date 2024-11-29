import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'navegacao.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final usuario = TextEditingController(text: 'emilys');
  final senha = TextEditingController(text: 'emilyspass');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF5AD1D1),
              Color(0xFF0057B2),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Learnfy",
                  style: TextStyle(
                    color: Colors.blue.shade900,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 100.0),
                Container(
                  width: 300,
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade900,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: usuario,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: "Usuário",
                                  hintText: "Insira seu usuário",
                                  labelStyle: TextStyle(color: Colors.white),
                                  hintStyle: TextStyle(color: Colors.white70),
                                  prefixIcon: Icon(Icons.person, color: Colors.white),
                                  filled: true,
                                  fillColor: Colors.blue.shade800,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                validator: (valor) {
                                  if (valor == null || valor.isEmpty) {
                                    return 'Insira seu usuário, por favor.';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: senha,
                                obscureText: true,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: "Senha",
                                  hintText: "Insira sua senha",
                                  labelStyle: TextStyle(color: Colors.white),
                                  hintStyle: TextStyle(color: Colors.white70),
                                  prefixIcon: Icon(Icons.password, color: Colors.white),
                                  filled: true,
                                  fillColor: Colors.blue.shade800,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                validator: (valor) {
                                  if (valor == null || valor.isEmpty) {
                                    return 'Insira a senha, por favor.';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      final url = Uri.parse('https://dummyjson.com/auth/login');
                      final response = await http.post(
                        url,
                        body: {
                          'username': usuario.text,
                          'password': senha.text,
                        },
                      );

                      if (response.statusCode == 200) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Navegacao()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Usuário ou senha incorretos'),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                      }
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: Colors.blue.shade900),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14.0),
                  ),
                  child: Text(
                    isLoading ? "Carregando..." : "Salvar",
                    style: TextStyle(color: Colors.blue.shade900),
                  ),
                ),
                SizedBox(height: 20.0),
                if (isLoading) CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
