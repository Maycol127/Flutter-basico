import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/src/screens/content/pedidos_detail_screen.dart'; // La pantalla de detalles

class PedidosScreen extends StatefulWidget {
  final String idpedido;
  const PedidosScreen({super.key, required this.idpedido});

  @override
  _PedidosScreenState createState() => _PedidosScreenState();
}

class _PedidosScreenState extends State<PedidosScreen> {
  List<dynamic> _pedidos = [];

  @override
  void initState() {
    super.initState();
    _fetchPedidos();
  }

  Future<void> _fetchPedidos() async {
    final response = await http.get(Uri.parse(
        'https://servicios.campus.pe/pedidos.php'));  // Ruta para obtener la lista de pedidos
    final List<dynamic> data = json.decode(response.body);
    setState(() {
      _pedidos = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _pedidos.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _pedidos.length,
              itemBuilder: (context, index) {
                final pedido = _pedidos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ID Pedido: ${pedido['idpedido']}'),
                        Text('Fecha: ${pedido['fechapedido']}'),
                        Text('Usuario: ${pedido['usuario']}'),
                        Text('Nombres: ${pedido['nombres']}'),
                        Text('Total: S/ ${pedido['total']}'),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PedidosDetailScreen(
                            idpedido: pedido['idpedido'], // Pasar el id del pedido seleccionado
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
