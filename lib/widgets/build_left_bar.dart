import 'package:flutter/material.dart';
import 'package:sistemarenascerdaesperanca/styles/colors_app.dart';

class BuildLeftBar {
  Widget build(BuildContext context) {
    return Container(
      color: ColorsApp.instance.AzulClaro, // Cor da barra lateral

      child: Column(
        children: [
          const SizedBox(height: 100),
          SizedBox(
            height: 100, // Altura da área da imagem
            child: Image.asset(
              'assets/images/logo.jpg', // Caminho para a imagem
              fit: BoxFit.cover, // Modo de ajuste da imagem
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            color: ColorsApp.instance.AzulSombra,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.home, // Ícone de home do Material Icons
                  color: ColorsApp.instance.Branco,
                  size: 30,
                ),
                Text(
                  'Home',
                  style: TextStyle(
                    fontFamily: 'roboto',
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: ColorsApp.instance.Branco,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
