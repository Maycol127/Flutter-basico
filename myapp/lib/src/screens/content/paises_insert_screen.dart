import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaisesInsertScreen extends StatefulWidget {
  const PaisesInsertScreen({super.key});

  @override
  _PaisesInsertScreenState createState() => _PaisesInsertScreenState();
}

class _PaisesInsertScreenState extends State<PaisesInsertScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para los campos de texto
  final TextEditingController _codPaisController = TextEditingController();
  final TextEditingController _paisController = TextEditingController();
  final TextEditingController _capitalController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _poblacionController = TextEditingController();
  final TextEditingController _continenteController = TextEditingController();

  // Método para insertar el país mediante un POST
  Future<void> _insertPais() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final response = await http.post(
      Uri.parse('https://servicios.campus.pe/paisesinsert.php'),
      body: {
        'codpais': _codPaisController.text,
        'pais': _paisController.text,
        'capital': _capitalController.text,
        'area': _areaController.text,
        'poblacion': _poblacionController.text,
        'continente': _continenteController.text,
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('País insertado correctamente')),
      );
      Navigator.pop(context);  // Vuelve a la pantalla anterior después de insertar
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al insertar el país')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insertar País'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _codPaisController,
                decoration: const InputDecoration(labelText: 'Código de País'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el código de país';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _paisController,
                decoration: const InputDecoration(labelText: 'País'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre del país';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _capitalController,
                decoration: const InputDecoration(labelText: 'Capital'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la capital';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _areaController,
                decoration: const InputDecoration(labelText: 'Área'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el área';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _poblacionController,
                decoration: const InputDecoration(labelText: 'Población'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la población';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _continenteController,
                decoration: const InputDecoration(labelText: 'Continente'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el continente';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _insertPais,  // Llama a la función para insertar el país
                child: const Text('Insertar País'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
