// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistemarenascerdaesperanca/styles/widget/iput_decoration.dart';

class FamiliaresCardData {
  TextEditingController nomeController = TextEditingController();
  TextEditingController idadeController = TextEditingController();
  bool isEsposaOuEsposo = false;
  bool isFilhoOuFilha = false;
  static List<Map<String, dynamic>> dadosDosFamiliares = [] ;

  
}

class CardNotifierCard extends ChangeNotifier {
  final List<FamiliaresCardData> cardsData = [];

  void addCard() {
    FamiliaresCardData novoFamiliar = FamiliaresCardData();
    FamiliaresCardData.dadosDosFamiliares.add({
      'nome': novoFamiliar.nomeController.text,
      'idade': novoFamiliar.idadeController.text,
      'isEsposaOuEsposo': novoFamiliar.isEsposaOuEsposo,
      'isFilhoOuFilha': novoFamiliar.isFilhoOuFilha,
    });
    cardsData.add(novoFamiliar);
    print(cardsData);
    print('___________');
    print( FamiliaresCardData.dadosDosFamiliares);
    notifyListeners();
  }

  void removeCard(int index) {
    if (index >= 0 && index < cardsData.length) {
      FamiliaresCardData.dadosDosFamiliares.removeAt(index);
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
  late CardNotifierCard _CardNotifierCard;

  @override
  void initState() {
    super.initState();
    _CardNotifierCard = CardNotifierCard();
    _CardNotifierCard.addCard();
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
        body: SingleChildScrollView(
          child: Column(
            children: [
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
