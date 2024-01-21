import 'package:flutter/material.dart';
import 'package:sistemarenascerdaesperanca/models/cliente_models.dart';
import 'package:sistemarenascerdaesperanca/styles/app_styles.dart';
import 'package:sistemarenascerdaesperanca/styles/colors_app.dart';
import 'package:sistemarenascerdaesperanca/widgets/appbar_custom.dart';

class DetalhesResponsavelPage extends StatelessWidget {
  final Responsavel cliente;

  const DetalhesResponsavelPage({super.key, required this.cliente});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showFilterIcon: false,
        leftContent: Text(
          'Detalhes do responsavel',
          style: TextStyle(
            color: ColorsApp.instance.CinzaMedio2,
            fontSize: 24,
            fontFamily: 'roboto',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
        color: ColorsApp.instance.Branco,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            child: ListView(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  readOnly: true,
                  initialValue: cliente.nome,
                  decoration: decorationReadOnly('Nome'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  readOnly: true,
                  initialValue: cliente.cpf,
                  decoration: decorationReadOnly('CPF'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  readOnly: true,
                  initialValue: cliente.fone,
                  decoration: decorationReadOnly('Telefone'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  readOnly: true,
                  initialValue: cliente.email,
                  decoration: decorationReadOnly('Email'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  readOnly: true,
                  initialValue: cliente.endereco,
                  decoration: decorationReadOnly('Endereço'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
