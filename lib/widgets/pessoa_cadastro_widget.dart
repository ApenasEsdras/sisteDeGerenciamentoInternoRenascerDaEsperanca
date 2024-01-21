// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:sistemarenascerdaesperanca/styles/colors_app.dart';

class PessoaCadastroWidget extends StatefulWidget {
  const PessoaCadastroWidget({Key? key}) : super(key: key);

  @override
  _PessoaCadastroWidgetState createState() => _PessoaCadastroWidgetState();
}

class _PessoaCadastroWidgetState extends State<PessoaCadastroWidget> {
  final List<Widget> cards = [];

  InputDecoration getCustomInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        fontFamily: 'roboto',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: ColorsApp.instance.CinzaEscuro,
      ),
      floatingLabelStyle: MaterialStateTextStyle.resolveWith(
        (Set<MaterialState> states) {
          final Color color = states.contains(MaterialState.focused)
              ? ColorsApp.instance.Laranja
              : ColorsApp.instance.CinzaMedio2;
          return TextStyle(color: color);
        },
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorsApp.instance.Laranja,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 0.8,
          color: ColorsApp.instance.CinzaMedio,
        ),
      ),
    );
  }

  Widget buildCard() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cadastro de Pessoas',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            decoration: getCustomInputDecoration('Nome'),
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            decoration: getCustomInputDecoration('Idade'),
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            decoration: getCustomInputDecoration('Grau de Parentesco'),
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () {
              // Implemente a lógica para cadastrar a pessoa
            },
            child: const Text('Cadastrar Pessoa'),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      cards.add(buildCard());
                    });
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  _excluirCard(cards.length - 1);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _excluirCard(int index) {
    setState(() {
      cards.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...cards,
                buildCard(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
