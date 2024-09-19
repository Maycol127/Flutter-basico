import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/src/screens/content/directores_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DirectoresUpdateScreen extends StatefulWidget {
  final String iddirector;
  final String nombres;
  final String peliculas;

  const DirectoresUpdateScreen({
    super.key,
    required this.iddirector,
    required this.nombres,
    required this.peliculas,
  });

  @override
  _DirectoresUpdateScreenState createState() => _DirectoresUpdateScreenState();
}

class _DirectoresUpdateScreenState extends State<DirectoresUpdateScreen> {
  late TextEditingController iddirectorController;
  late TextEditingController nombresController;
  late TextEditingController peliculasController;

  @override
  void initState() {
    super.initState();
    iddirectorController = TextEditingController(text: widget.iddirector);
    nombresController = TextEditingController(text: widget.nombres);
    peliculasController = TextEditingController(text: widget.peliculas);
  }

  Future<void> updateDirector(
      String iddirector, String nombres, String peliculas) async {
    await http.post(
      Uri.parse('https://servicios.campus.pe/directoresupdate.php'),
      body: {
        'iddirector': iddirector,
        'nombres': nombres,
        'peliculas': peliculas,
      },
    );
    Fluttertoast.showToast(
      msg: "Se ha actualizado los datos del director de código $iddirector",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const DirectoresScreen()));
  }

  Future<void> deleteDirector(String iddirector) async {
    // Servicio para eliminar al director
    final response = await http.post(
      Uri.parse('https://servicios.campus.pe/directoresdelete.php'),
      body: {
        'iddirector': iddirector,
      },
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Se ha eliminado el director de código $iddirector",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      // Redirigir a DirectoresScreen después de eliminar
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const DirectoresScreen()),
        (Route<dynamic> route) => false,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Error al eliminar el director",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  readOnly: true,
                  controller: iddirectorController,
                  decoration: const InputDecoration(
                      labelText: 'Código', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: nombresController,
                  decoration: const InputDecoration(
                      labelText: 'Nombres', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: peliculasController,
                  decoration: const InputDecoration(
                      labelText: 'Películas', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    String nombres = nombresController.text;
                    String peliculas = peliculasController.text;
                    String iddirector = iddirectorController.text;
                    updateDirector(iddirector, nombres, peliculas);
                  },
                  child: const Text("Actualizar"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.red,
                  ),
                  onPressed: () {
                    // Confirmación de eliminación
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Confirmar eliminación"),
                          content: const Text(
                              "¿Estás seguro de que deseas eliminar este director?"),
                          actions: <Widget>[
                            TextButton(
                              child: const Text("Cancelar"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text("Eliminar"),
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); // Cerrar el diálogo
                                deleteDirector(iddirectorController
                                    .text); // Eliminar el director
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text("Eliminar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
