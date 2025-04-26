import 'package:flutter/material.dart';
import 'package:punto_resistencias/pages/resistencias_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _closeSplash();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage("assets/images/logo.png"),
          width: 150,
          height: 150,
        ),
      ),
    );

  }
  Future<void> _closeSplash() async{
    Future.delayed(const Duration(seconds:2), () async{
      Navigator.pushReplacement(

          context, MaterialPageRoute(builder: (context) => ResistenciasPage()));
    });
  }
}
