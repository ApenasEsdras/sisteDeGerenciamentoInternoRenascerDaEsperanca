import 'package:flutter/material.dart';
import '../../../widgets/build_left_bar.dart';
import 'components/lista_esponsavel.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final BuildLeftBar buildLeftBar = BuildLeftBar();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1, // 20% do espaço para a barra lateral
            child: buildLeftBar.build(context),
          ),
           const Expanded(
            flex: 4, // 80% do espaço para o conteúdo principal
            child: ListarPessoas(),
          ),
        ],
      ),
    );
  }

 
}
