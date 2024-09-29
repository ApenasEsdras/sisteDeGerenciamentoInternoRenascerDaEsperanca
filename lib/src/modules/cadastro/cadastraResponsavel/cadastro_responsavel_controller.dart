// ignore_for_file: use_build_context_synchronously, unused_element, avoid_print

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sistemarenascerdaesperanca/src/modules/home/home_page.dart';
import 'package:sistemarenascerdaesperanca/src/helpers/alert_dialog.dart.dart';
import '../cadastraFamiliar/cadastra_familiar_model.dart';

class CadastroResponsavelController {
  final formKey = GlobalKey<FormState>();
  final BuildContext context;

  CadastroResponsavelController(this.context);

  final nomeController = TextEditingController();
  final cpfController = TextEditingController();
  final paisController = TextEditingController();
  final ufController = TextEditingController();
  final logradouroController = TextEditingController();
  final cidadeController = TextEditingController();
  final bairroController = TextEditingController();
  final cepController = TextEditingController();
  final numeroController = TextEditingController();
  final complementoController = TextEditingController();
  final foneController = TextEditingController();
  final emailController = TextEditingController();

  Future<void> cadastrarResponsavel() async {
    if (formKey.currentState!.validate()) {
      final bool responsavelNaoCadastrado =
          await _verificarCadastroResponsavel();
      if (responsavelNaoCadastrado) {
        final dadosDaFamilia = {
          'nome': nomeController.text,
          'cpf': cpfController.text,
          'pais': paisController.text,
          'complemento': complementoController.text,
          'fone': foneController.text,
          'email': emailController.text,
          'logradouro': logradouroController.text,
          'numero': numeroController.text,
          'bairro': bairroController.text,
          'cidade': cidadeController.text,
          'uf': ufController.text,
          'familiares': Familiares.dadosDosFamiliares,
          'endereco': '${logradouroController.text}, '
              '${numeroController.text}, '
              '${bairroController.text}, '
              '${cidadeController.text}, '
              '${ufController.text}',
        };
        try {
          await FirebaseFirestore.instance
              .collection('responsaveis')
              .doc()
              .set(dadosDaFamilia);
          debugPrint(jsonEncode(dadosDaFamilia));
          CustomAlertDialog.cadastroResponsavelSucesso(context);

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),  
          );
        } catch (e) {
          CustomAlertDialog.cadastroResponsavelErro(context, '$e');
          print(e);
        }
      }
    }
  }

  Future<bool> _verificarCadastroResponsavel() async {
    final cpf = cpfController.text;
    final query = await FirebaseFirestore.instance
        .collection('responsaveis')
        .where('cpf', isEqualTo: cpf)
        .get();

    if (query.docs.isNotEmpty) {
      CustomAlertDialog.cadastroResponsavelRepetido(context);
      return false; // Responsável já está cadastrado
    } else {
      return true; // Responsável não está cadastrado
    }
  }

  Future<void> preencherEnderecoPorCEP(String cep) async {
    final url = Uri.parse('https://viacep.com.br/ws/$cep/json/');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        paisController.text = 'Brasil';
        ufController.text = data['uf'];
        cidadeController.text = data['localidade'];
        bairroController.text = data['bairro'];
        logradouroController.text = data['logradouro'];
      } else {
        CustomAlertDialog.erroCep(context, '');
      }
    } catch (e) {
      CustomAlertDialog.erroCep(context, ': $e');
    }
  }
}
