import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GenerarReferenciaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Generar Referencia',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xffffd700),
          bottom: const TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Tabla', icon: Icon(Icons.list, color: Colors.white)),
              Tab(
                  text: 'Datos',
                  icon: Icon(Icons.list_alt, color: Colors.white)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ReferenciaDatos(),
            ReferenciaFormulario(),
          ],
        ),
      ),
    );
  }
}

class ReferenciaFormulario extends StatefulWidget {
  const ReferenciaFormulario({Key? key}) : super(key: key);

  @override
  _ReferenciaFormularioState createState() => _ReferenciaFormularioState();
}

class _ReferenciaFormularioState extends State<ReferenciaFormulario> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idClienteController = TextEditingController();
  final TextEditingController _numeroCuentaController = TextEditingController();
  final TextEditingController _codigoPostalController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      await FirebaseFirestore.instance.collection('referencias').add({
        'id_cliente': _idClienteController.text,
        'numero_cuenta': _numeroCuentaController.text,
        'codigo_postal': _codigoPostalController.text,
        'nombre': _nombreController.text,
        'apellido': _apellidoController.text,
        'telefono': _telefonoController.text,
        'correo': _correoController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Referencia generada exitosamente')),
      );

      _formKey.currentState?.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _idClienteController,
              decoration: InputDecoration(
                labelText: 'ID Cliente',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el ID del cliente';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _numeroCuentaController,
              decoration: InputDecoration(
                labelText: 'Número de Cuenta',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el número de cuenta';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _codigoPostalController,
              decoration: InputDecoration(
                labelText: 'Código Postal',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el código postal';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _nombreController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el nombre';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _apellidoController,
              decoration: InputDecoration(
                labelText: 'Apellido',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el apellido';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _telefonoController,
              decoration: InputDecoration(
                labelText: 'Teléfono',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el teléfono';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _correoController,
              decoration: InputDecoration(
                labelText: 'Correo Electrónico',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el correo electrónico';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Generar Referencia'),
              style: ElevatedButton.styleFrom(
                primary: const Color(0xffffd700),
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReferenciaDatos extends StatelessWidget {
  const ReferenciaDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('referencias').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final data = snapshot.requireData;

        return ListView.builder(
          itemCount: data.size,
          itemBuilder: (context, index) {
            final doc = data.docs[index];
            return ListTile(
              title: Text(
                'Cliente: ${doc['nombre']} ${doc['apellido']} - Número de Cuenta: ${doc['numero_cuenta']}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  'ID: ${doc['id_cliente']} - Código Postal: ${doc['codigo_postal']}'),
              trailing: Text(
                  'Teléfono: ${doc['telefono']} - Correo: ${doc['correo']}'),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            );
          },
        );
      },
    );
  }
}
