// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api, avoid_print

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistemarenascerdaesperanca/styles/widget/iput_decoration.dart';

import 'cadastra_familiares_controller.dart';

class CadastraFamiliaresCard extends StatefulWidget {
  const CadastraFamiliaresCard({Key? key}) : super(key: key);

  @override
  _CadastraFamiliaresCardState createState() => _CadastraFamiliaresCardState();
}

Future<void> selectImage(FamiliaresCardData cardData) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.image,
    allowMultiple: false,
  );

  if (result != null) {
    cardData.imageFile = File(result.files.single.path!);
  }
}

class _CadastraFamiliaresCardState extends State<CadastraFamiliaresCard> {
  late CardNotifierCard _CardNotifierCard;

  @override
  void initState() {
    super.initState();
    _CardNotifierCard = CardNotifierCard();
    _CardNotifierCard.addCard();
  }

  Widget buildCard(int index, FamiliaresCardData cardData,) {
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
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: cardData.nomeController,
            decoration: InputDecorationUtils.getCustomInputDecoration('Nome'),
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: cardData.idadeController,
            decoration: InputDecorationUtils.getCustomInputDecoration('Idade'),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  selectImage(cardData);
                },
                child: const Text('Selecionar Imagem'),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              const Text('Grau de Parentesco:'),
              const SizedBox(width: 8),
              Checkbox(
                value: cardData.isEsposaOuEsposo,
                onChanged: (value) {
                  setState(() {
                    cardData.isEsposaOuEsposo = value ?? false;
                  });
                },
              ),
              const Text('Esposa(o)'),
              const SizedBox(width: 8),
              Checkbox(
                value: cardData.isFilhoOuFilha,
                onChanged: (value) {
                  setState(() {
                    cardData.isFilhoOuFilha = value ?? false;
                  });
                },
              ),
              const Text('Filho(a)'),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  _CardNotifierCard.addCard();
                },
                child: const Row(
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 8),
                    Text('Adicionar'),
                  ],
                ),
              ),
              if (index > 0)
                TextButton(
                  onPressed: () {
                    _CardNotifierCard.removeCard(index);
                  },
                  child: const Row(
                    children: [
                      Text('Remover'),
                      SizedBox(width: 8),
                      Icon(Icons.close),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _CardNotifierCard,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(
            255, 177, 173, 208), // Cor desejada para o fundo
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(2.0),
                child: Text(
                  'Cadastrar familiares',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Consumer<CardNotifierCard>(
                builder: (context, CardNotifierCard CardNotifierCard, _) {
                  return Column(
                    children: List.generate(
                      CardNotifierCard.cardsData.length,
                      (index) =>
                          buildCard(index, CardNotifierCard.cardsData[index]),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
