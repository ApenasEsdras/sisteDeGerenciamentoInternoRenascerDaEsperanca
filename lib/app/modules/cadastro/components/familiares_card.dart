// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistemarenascerdaesperanca/styles/widget/iput_decoration.dart';

class FamiliaresCardData {
  TextEditingController nomeController = TextEditingController();
  TextEditingController idadeController = TextEditingController();
  bool isEsposaOuEsposo = false;
  bool isFilhoOuFilha = false;
  static String? nomeInserido;
  static String? idadeInserida;
  static String? gralDeParentescoInserido;
}

class CardNotifier extends ChangeNotifier {
  final List<FamiliaresCardData> cardsData = [];

  void addCard() {
    cardsData.add(FamiliaresCardData());
    notifyListeners();
  }

  void removeCard(int index) {
    if (index >= 0 && index < cardsData.length) {
      cardsData.removeAt(index);
      notifyListeners();
    }
  }
}

class CadastraFamiliaresCard extends StatefulWidget {
  const CadastraFamiliaresCard({Key? key}) : super(key: key);

  @override
  _CadastraFamiliaresCardState createState() => _CadastraFamiliaresCardState();
}

class _CadastraFamiliaresCardState extends State<CadastraFamiliaresCard> {
  late CardNotifier _cardNotifier;
  @override
  void initState() {
    super.initState();
    _cardNotifier = CardNotifier();
    _cardNotifier.addCard();
  }

  Widget buildCard(int index, FamiliaresCardData cardData) {
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
            'Familiares',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
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
                  _cardNotifier.addCard();
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
                    _cardNotifier.removeCard(index);
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
      create: (context) => _cardNotifier,
      child: Scaffold(
        body: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Consumer<CardNotifier>(
                  builder: (context, cardNotifier, _) {
                    return Column(
                      children: List.generate(
                        cardNotifier.cardsData.length,
                        (index) =>
                            buildCard(index, cardNotifier.cardsData[index]),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
