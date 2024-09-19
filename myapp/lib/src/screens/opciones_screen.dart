import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/src/components/heading_image.dart';
import 'package:myapp/src/theme/app_theme.dart';
import 'package:myapp/src/utils/app_colors.dart';
import 'package:myapp/src/utils/dimensions.dart';
import 'package:myapp/src/screens/content/paises_screen.dart';
import 'package:myapp/src/screens/content/pedidos_screen.dart';

class OpcionesScreen extends StatelessWidget {
  const OpcionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Opciones'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColors.primaryVariant,
                ),
                child: Text('Menu'),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Inicio'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.list),
                title: const Text('Pedidos'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PedidosScreen(idpedido: '10248'),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.flag),
                title: const Text('Países'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaisesScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.mediumPadding),
            child: Column(
              children: [
                Text(
                  'Opciones',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(
                  height: Dimensions.mediumPadding,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const HeadingImage(
                          imagePath: 'assets/images/foto_opciones.jpg',
                          title: '',
                        ),
                        const Padding(
                          padding: EdgeInsets.all(Dimensions.largePadding),
                          child: Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut molestie nisl nec elit vestibulum efficitur. Mauris a tincidunt turpis, vitae sagittis neque.',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PedidosScreen(idpedido: '10248'),
                                  ),
                                );
                              },
                              child: const Text("Pedidos"),
                            ),
                            const SizedBox(
                              width: Dimensions.smallPadding,
                            ),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const PaisesScreen(),
                                  ),
                                );
                              },
                              child: const Text("Países"),
                            ),
                            const SizedBox(
                              width: Dimensions.smallPadding,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context); //Cierra la ventana
                              },
                              child: const Text('Volver'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Pedidos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: 'Países',
          ),
        ]),
      ),
    );
  }
}
