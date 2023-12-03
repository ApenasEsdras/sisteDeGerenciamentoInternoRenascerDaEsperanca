import 'package:flutter/material.dart';
import 'package:sistemarenascerdaesperanca/styles/colors_app.dart';

class BuildLeftBar {
  Widget build(BuildContext context) {
    return Container(
      color: ColorsApp.instance.AzulClaro, // Cor da barra lateral

      child: Column(
        children: [
          const SizedBox(height: 280),
          SizedBox(
            child: Image.asset(
              'assets/images/logoHome.png',
              color: ColorsApp.instance.Laranja,
              height: 60,
            ),
          ),
          Container(
            color: ColorsApp.instance.AzulSombra,
            height: 80,
            child: SizedBox(
              height: 25,
              child: Center(
                child: Text(
                  'Home',
                  style: TextStyle(
                    fontFamily: 'NovaRound-Regular',
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: ColorsApp.instance.CinzaEscuro,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          // Adicione mais widgets conforme necessário
        ],
      ),
    );
  }
}
