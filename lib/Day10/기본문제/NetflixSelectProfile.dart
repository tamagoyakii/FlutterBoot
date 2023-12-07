import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NetflixSelectProfile',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(background: Colors.black),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const NetflixSelectProfile(),
    );
  }
}

class NetflixSelectProfile extends StatelessWidget {
  const NetflixSelectProfile({super.key});

  Widget _buildProfile({
    String name = 'Add profile',
    Color color1 = Colors.black,
    Color color2 = Colors.black,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: color1 == Colors.black
                ? Border.all(color: Colors.grey)
                : Border.all(style: BorderStyle.none),
            gradient: LinearGradient(
              colors: [color1, color2],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: color1 == Colors.black
              ? const Icon(Icons.add, size: 40)
              : const CustomPaint(
                  painter: FacePainter(),
                ),
        ),
        const SizedBox(height: 5),
        Text(name, style: TextStyle(color: Colors.grey.shade400)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'FlutterBoot',
          style: GoogleFonts.lobster(color: Colors.red, fontSize: 30),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Select a profile to start the Flutter Boot.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 250,
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                childAspectRatio: 6 / 7,
                children: [
                  _buildProfile(
                    name: 'Honlee',
                    color1: Colors.blue.shade600,
                    color2: Colors.blue.shade300,
                  ),
                  // const SizedBox(width: 25),
                  _buildProfile(
                    name: 'Kilee',
                    color1: Colors.yellow.shade600,
                    color2: Colors.yellow.shade300,
                  ),
                  _buildProfile(
                    name: 'Flutter Boot',
                    color1: Colors.redAccent.shade700,
                    color2: Colors.redAccent,
                  ),
                  _buildProfile(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FacePainter extends CustomPainter {
  const FacePainter();

  @override
  void paint(Canvas canvas, Size size) {
    double x = size.width;
    double y = size.height;

    final Paint eyePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(x / 5, y / 3), 6, eyePaint);
    canvas.drawCircle(Offset(x / 5 * 4, y / 3), 6, eyePaint);

    final Paint smilePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    Path smilePath = Path()
      ..moveTo(x / 5 * 2, y / 2 + 5)
      ..arcToPoint(
        Offset(x - 13, y / 2 + 5),
        radius: const Radius.circular(50),
        clockwise: false,
      );

    canvas.drawPath(smilePath, smilePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
