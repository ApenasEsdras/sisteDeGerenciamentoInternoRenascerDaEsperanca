// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../../../styles/colors_app.dart';
import '../../../styles/widget/appbar.dart';
import 'cadastro_responsavel_controller.dart';
import 'cadastro_responsavel_form.dart';


class CadastroResponsavelPage extends StatefulWidget {
  const CadastroResponsavelPage({Key? key}) : super(key: key);

  @override
  _CadastroResponsavelPageState createState() =>
      _CadastroResponsavelPageState();
}

class _CadastroResponsavelPageState extends State<CadastroResponsavelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          showFilterIcon: false,
          leftContent: Text(
            'Cadastrar Responsável',
            style: TextStyle(
              color: ColorsApp.instance.CinzaMedio2,
              fontSize: 24,
              fontFamily: 'roboto',
              fontWeight: FontWeight.w500,
            ),
          ), onMenuPressed: () {  },
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: CadastroResponsavelForm(
                controller: CadastroResponsavelController(context),
              ),
            ),
          ),
        ));
  }
}
