import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PedidosDetailScreen extends StatefulWidget {
  final String idpedido;
  const PedidosDetailScreen({super.key, required this.idpedido});

  @override
  _PedidosDetailScreenState createState() => _PedidosDetailScreenState();
}

class _PedidosDetailScreenState extends State<PedidosDetailScreen> {
  List<dynamic> _productos = [];

  @override
  void initState() {
    super.initState();
    _fetchProductos();
  }

  Future<void> _fetchProductos() async {
    final response = await http.get(Uri.parse(
        'https://servicios.campus.pe/pedidosdetalle.php?idpedido=${widget.idpedido}')); // Ruta de la API
    final List<dynamic> data = json.decode(response.body);
    setState(() {
      _productos = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos del Pedido'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _productos.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Scroll horizontal
              child: Row(
                children: _productos.map((producto) {
                  final String imageUrl =
                      'https://servicios.campus.pe/${producto['imagenchica']}';

                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: Container(
                      width: 200, // Ancho de cada tarjeta
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            imageUrl,
                            height: 120, // Altura de la imagen
                            width: 200, // Ancho de la imagen
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.network(
                                'https://servicios.campus.pe/imagenes/nofoto.jpg', // Imagen de respaldo
                                height: 120,
                                width: 200,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              producto['nombre'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text('Cantidad: ${producto['cantidad']}'),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text('Precio: S/ ${producto['precio']}'),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'Total: S/ ${(double.parse(producto['precio']) * int.parse(producto['cantidad'])).toStringAsFixed(4)}',
                              // Convertimos ambos valores y formateamos el total con 2 decimales
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
    );
  }
}
