import 'package:flutter/material.dart';
import 'package:sistemarenascerdaesperanca/src/styles/colors_app.dart';

class BuildLeftBar {
  Widget build(BuildContext context) {
    return Container(
      color: ColorsApp.instance.AzulClaro,

      child: Column(
        children: [
          const SizedBox(height: 100),
          SizedBox(
            height: 100, 
            child: Image.asset(
              'assets/images/logo.jpg',
              fit: BoxFit.cover, 
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
                  Icons.home, 
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
