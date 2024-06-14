import 'package:flutter/material.dart';

void main() {
  runApp(MyApps());
}

class MyApps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductosPage(),
    );
  }
}

class ProductosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Empleados'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Nuestros Empleados',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                CarouselItem(
                  image:
                      'https://raw.githubusercontent.com/vivizsi/img-IOS_Flutterflow/main/act12/empleada7.jpg',
                  title: 'Empleado 1',
                  description: '',
                ),
                CarouselItem(
                  image:
                      'https://raw.githubusercontent.com/vivizsi/img-IOS_Flutterflow/main/act12/empleado15.jpg',
                  title: 'Empleado 2',
                  description: '',
                ),
                CarouselItem(
                  image:
                      'https://raw.githubusercontent.com/vivizsi/img-IOS_Flutterflow/main/act12/empleada2.jpg',
                  title: 'Empleado 3',
                  description: '',
                ),
                // Agrega más elementos CarouselItem según sea necesario
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CarouselItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const CarouselItem({
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(image), // Corregido a NetworkImage
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
