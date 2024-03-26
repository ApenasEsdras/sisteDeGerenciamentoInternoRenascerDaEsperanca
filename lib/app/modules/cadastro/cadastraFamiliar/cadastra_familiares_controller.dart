// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';

class FamiliaresCardData {
  TextEditingController nomeController = TextEditingController();
  TextEditingController idadeController = TextEditingController();
  bool isEsposaOuEsposo = false;
  bool isFilhoOuFilha = false;
  static List<Map<String, dynamic>> dadosDosFamiliares = [];
  File? imageFile; // Adicionado para armazenar o arquivo de imagem
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
    print('___________');
    print(FamiliaresCardData.dadosDosFamiliares);
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
