import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: ShapeDecoration(
                    shadows: const [
                      BoxShadow(
                        offset: Offset(0, 2.77),
                        blurRadius: 2.21,
                        spreadRadius: 0,
                        color: Color.fromRGBO(251, 173, 64, 0.04),
                      ),
                      BoxShadow(
                        offset: Offset(0, 6.65),
                        blurRadius: 5.32,
                        spreadRadius: 0,
                        color: Color.fromRGBO(251, 173, 64, 0.04),
                      ),
                      BoxShadow(
                        offset: Offset(0, 12.52),
                        blurRadius: 10.02,
                        spreadRadius: 0,
                        color: Color.fromRGBO(251, 173, 64, 0.05),
                      ),
                      BoxShadow(
                        offset: Offset(0, 22.34),
                        blurRadius: 17.87,
                        spreadRadius: 0,
                        color: Color.fromRGBO(251, 173, 64, 0.05),
                      ),
                      BoxShadow(
                        offset: Offset(0, 41.78),
                        blurRadius: 33.42,
                        spreadRadius: 0,
                        color: Color.fromRGBO(251, 173, 64, 0.05),
                      ),
                      BoxShadow(
                        offset: Offset(0, 100),
                        blurRadius: 80,
                        spreadRadius: 0,
                        color: Color.fromRGBO(251, 173, 64, 0.07),
                      ),
                    ],
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(45),
                    ),
                    color: const Color.fromRGBO(251, 173, 64, 1),
                  ),
                  child: const Icon(
                    Icons.ads_click,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'همه',
                  style: TextStyle(
                    fontFamily: 'SB',
                    color: Colors.black,
                    fontSize: 12,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
