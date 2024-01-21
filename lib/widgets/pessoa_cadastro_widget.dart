import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistemarenascerdaesperanca/styles/colors_app.dart';

class PessoaCadastroWidget extends StatefulWidget {
  const PessoaCadastroWidget({Key? key}) : super(key: key);

  @override
  _PessoaCadastroWidgetState createState() => _PessoaCadastroWidgetState();
}

class CardData {
  TextEditingController nomeController = TextEditingController();
  TextEditingController idadeController = TextEditingController();
  TextEditingController parentescoController = TextEditingController();
}

class CardNotifier extends ChangeNotifier {
  final List<CardData> cardsData = [];

  void addCard() {
    cardsData.add(CardData());
    notifyListeners();
  }

  void removeCard(int index) {
    if (index >= 0 && index < cardsData.length) {
      cardsData.removeAt(index);
      notifyListeners();
    }
  }
}

class _PessoaCadastroWidgetState extends State<PessoaCadastroWidget> {
  late CardNotifier _cardNotifier;

  @override
  void initState() {
    super.initState();
    _cardNotifier = CardNotifier();

    // Adiciona um card vazio inicial que não pode ser excluído
    _cardNotifier.addCard();
  }

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

  Widget buildCard(int index) {
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
            controller: _cardNotifier.cardsData[index].nomeController,
            decoration: getCustomInputDecoration('Nome'),
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: _cardNotifier.cardsData[index].idadeController,
            decoration: getCustomInputDecoration('Idade'),
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: _cardNotifier.cardsData[index].parentescoController,
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
                    _cardNotifier.addCard();
                  },
                ),
              ),
              if (index > 0) // Adiciona um botão para remover apenas se não for o primeiro card
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _cardNotifier.removeCard(index);
                  },
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
                        (index) => buildCard(index),
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
