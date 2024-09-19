import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'paises_insert_screen.dart';  // Importamos la pantalla de inserción

class PaisesScreen extends StatefulWidget {
  const PaisesScreen({super.key});

  @override
  _PaisesScreenState createState() => _PaisesScreenState();
}

class _PaisesScreenState extends State<PaisesScreen> {
  List<dynamic> _paises = [];

  @override
  void initState() {
    super.initState();
    _fetchPaises();
  }

  Future<void> _fetchPaises() async {
    final response = await http.get(Uri.parse('https://servicios.campus.pe/paises.php'));
    final List<dynamic> data = json.decode(response.body);
    setState(() {
      _paises = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Países'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),  // Botón para abrir la pantalla de inserción
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PaisesInsertScreen(),  // Ir a la pantalla de inserción
                ),
              );
            },
          ),
        ],
      ),
      body: _paises.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _paises.length,
              itemBuilder: (context, index) {
                final pais = _paises[index];
                return ListTile(
                  title: Text(pais['pais']),
                  subtitle: Text('Capital: ${pais['capital']} - Población: ${pais['poblacion']}'),
                );
              },
            ),
      // Botón flotante para agregar un nuevo país
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PaisesInsertScreen(),  // Ir a la pantalla de inserción
            ),
          );
        },
        child: const Icon(Icons.add),  // Icono de "Agregar"
        tooltip: 'Insertar nuevo país',
      ),
    );
  }
}