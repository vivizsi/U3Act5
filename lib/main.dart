import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cardenas0326/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cardenas0326/pages/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MiAplicacion());
}

class MiAplicacion extends StatelessWidget {
  const MiAplicacion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Negocio de Carpintería',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PaginaSesion(),
    );
  }
}

// ignore: must_be_immutable
class PaginaSesion extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // ignore: prefer_final_fields
  CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('usuario');

  PaginaSesion({super.key});

  void _login(BuildContext context) async {
    String email = _emailController.text;
    String contrasena = _passwordController.text;

    QuerySnapshot querySnapshot = await _usersCollection
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: contrasena)
        .get();

    if (querySnapshot.size > 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PaginaInicio(email)),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error de inicio de sesión'),
            content:
                const Text('Credenciales incorrectas. Inténtalo de nuevo.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _registro(BuildContext context) async {
    String email = _emailController.text;
    String contrasena = _passwordController.text;

    QuerySnapshot querySnapshot =
        await _usersCollection.where('email', isEqualTo: email).get();

    if (querySnapshot.size > 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error de registro'),
            content: const Text('El usuario ya está registrado.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      await _usersCollection.add({
        'email': email,
        'password': contrasena,
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Registro exitoso'),
            content: const Text('El usuario ha sido registrado correctamente.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('JMAS', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xff2400f0),
        elevation: 8,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const Text(
              "Inicio de sesión",
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 2.5,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              child: const Text(
                'Iniciar sesión',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(340, 40),
                backgroundColor: const Color(0xff2400f0),
              ),
              onPressed: () => _login(context),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              child: const Text(
                'Registrarse',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(340, 40),
                backgroundColor: const Color(0xff2400f0),
              ),
              onPressed: () => _registro(context),
            ),
          ],
        ),
      ),
    );
  }
}
