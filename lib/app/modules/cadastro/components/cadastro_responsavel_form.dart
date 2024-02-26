import 'package:flutter/material.dart';
import 'package:sistemarenascerdaesperanca/app/modules/cadastro/cadastro_responsavel_controller.dart';

import '../../../../styles/widget/iput_decoration.dart';
import 'familiares_card.dart';

class CadastroResponsavelForm extends StatefulWidget {
  final CadastroResponsavelController controller;

  const CadastroResponsavelForm({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<CadastroResponsavelForm> createState() =>
      _CadastroResponsavelFormState();
}

class _CadastroResponsavelFormState extends State<CadastroResponsavelForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.controller.formKey,
      child: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: widget.controller.nomeController,
            decoration: InputDecorationUtils.getCustomInputDecoration('Nome*'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Campo obrigatório';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: widget.controller.cpfController,
            decoration:
                InputDecorationUtils.getCustomInputDecoration('CPF/CNPJ*'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Campo obrigatório';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: widget.controller.foneController,
            decoration: InputDecorationUtils.getCustomInputDecoration('Fone'),
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: widget.controller.emailController,
            decoration: InputDecorationUtils.getCustomInputDecoration('E-mail'),
          ),
          const SizedBox(
            height: 16,
          ),
          const SizedBox(
              height: 20,
              child: Text(
                'Endereço',
                style: TextStyle(
                  fontFamily: 'roboto',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              )),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Flexible(
                flex: 5,
                child: TextFormField(
                  controller: widget.controller.cepController,
                  decoration:
                      InputDecorationUtils.getCustomInputDecoration('CEP*'),
                  onChanged: (value) {
                    if (value.length == 8) {
                      widget.controller.preencherEnderecoPorCEP(value);
                    }
                  },
                  validator: (value) {
                    if (value!.length != 8 && value.isEmpty) {
                      return 'CEP inválido';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Flexible(
                flex: 5,
                child: TextFormField(
                  controller: widget.controller.ufController,
                  decoration:
                      InputDecorationUtils.getCustomInputDecoration('UF'),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Flexible(
                flex: 5,
                child: TextFormField(
                  controller: widget.controller.paisController,
                  decoration:
                      InputDecorationUtils.getCustomInputDecoration('PAIS'),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Flexible(
                flex: 5,
                child: TextFormField(
                  controller: widget.controller.cidadeController,
                  decoration:
                      InputDecorationUtils.getCustomInputDecoration('Cidade'),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Flexible(
                flex: 5,
                child: TextFormField(
                  controller: widget.controller.bairroController,
                  decoration:
                      InputDecorationUtils.getCustomInputDecoration('Bairro'),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Flexible(
                flex: 5,
                child: TextFormField(
                  controller: widget.controller.logradouroController,
                  decoration:
                      InputDecorationUtils.getCustomInputDecoration('Rua'),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Flexible(
                flex: 3,
                child: TextFormField(
                  controller: widget.controller.numeroController,
                  decoration:
                      InputDecorationUtils.getCustomInputDecoration('Número'),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Flexible(
                flex: 5,
                child: TextFormField(
                  controller: widget.controller.complementoController,
                  decoration: InputDecorationUtils.getCustomInputDecoration(
                      'Complemento'),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () {
              widget.controller.cadastrarResponsavel();
            },
            child: const Text('Cadastrar'),
          ),
          // Widget de cadastro de familiares
          const CadastraFamiliaresCard(),
        ],
      ),
    );
  }
}
