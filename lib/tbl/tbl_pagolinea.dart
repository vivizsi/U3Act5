import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PagosEnLineaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Pagos en Línea',
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
            PagosEnLineaDatos(),
            PagosEnLineaFormulario(),
          ],
        ),
      ),
    );
  }
}

class PagosEnLineaFormulario extends StatefulWidget {
  const PagosEnLineaFormulario({Key? key}) : super(key: key);

  @override
  _PagosEnLineaFormularioState createState() => _PagosEnLineaFormularioState();
}

class _PagosEnLineaFormularioState extends State<PagosEnLineaFormulario> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idReciboController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _montoController = TextEditingController();
  final TextEditingController _codigoPostalController = TextEditingController();
  final TextEditingController _numeroCuentaController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      await FirebaseFirestore.instance.collection('pagos_en_linea').add({
        'id_recibo': _idReciboController.text,
        'apellido': _apellidoController.text,
        'fecha': _fechaController.text,
        'telefono': _telefonoController.text,
        'correo': _correoController.text,
        'monto_pagar': double.tryParse(_montoController.text) ?? 0.0,
        'codigo_postal': _codigoPostalController.text,
        'numero_cuenta': _numeroCuentaController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pago en línea registrado exitosamente')),
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
              controller: _idReciboController,
              decoration: InputDecoration(
                labelText: 'ID Recibo',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el ID del recibo';
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
              controller: _fechaController,
              decoration: InputDecoration(
                labelText: 'Fecha',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese la fecha';
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
            const SizedBox(height: 10),
            TextFormField(
              controller: _montoController,
              decoration: InputDecoration(
                labelText: 'Monto a Pagar',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el monto a pagar';
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Registrar Pago en Línea'),
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

class PagosEnLineaDatos extends StatelessWidget {
  const PagosEnLineaDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection('pagos_en_linea').snapshots(),
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
                'Recibo ID: ${doc['id_recibo']} - Apellido: ${doc['apellido']}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  'Fecha: ${doc['fecha']} - Teléfono: ${doc['telefono']} - Correo: ${doc['correo']}'),
              trailing: Text('Monto a Pagar: \$${doc['monto_pagar']}'),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            );
          },
        );
      },
    );
  }
}
