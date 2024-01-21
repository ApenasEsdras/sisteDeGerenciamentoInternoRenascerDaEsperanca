// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sistemarenascerdaesperanca/helpers/alert_dialog.dart.dart';
import 'package:sistemarenascerdaesperanca/screens/home_page.dart';
import 'package:sistemarenascerdaesperanca/styles/colors_app.dart';
import 'package:sistemarenascerdaesperanca/widgets/appbar_custom.dart';
import 'package:sistemarenascerdaesperanca/widgets/pessoa_cadastro_widget.dart';

class CadastroResponsavelPage extends StatefulWidget {
  const CadastroResponsavelPage({super.key});

  @override
  _CadastroResponsavelPageState createState() =>
      _CadastroResponsavelPageState();
}

class _CadastroResponsavelPageState extends State<CadastroResponsavelPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nomeController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController paisController = TextEditingController();
  TextEditingController ufController = TextEditingController();
  TextEditingController logradouroController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController complementoController = TextEditingController();
  TextEditingController foneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  Future<void> _cadastrarResponsavel() async {
    if (_formKey.currentState!.validate()) {
      final bool clienteNaoCadastrado = await _verificarCadastroResponsavel();
      if (clienteNaoCadastrado) {
        final cliente = {
          'nome': nomeController.text,
          'cpf': cpfController.text,
          'pais': paisController.text,
          'complemento': complementoController.text,
          'fone': foneController.text,
          'email': emailController.text,
          'endereco': '${logradouroController.text}, '
              ' ${numeroController.text}, '
              ' ${bairroController.text}, '
              ' ${cidadeController.text}, '
              ' ${ufController.text}, '
              'cep: ${cepController.text}',
        };

        if (kDebugMode) {
          print(cliente);
        }

        try {
          await FirebaseFirestore.instance
              .collection('responsaveis')
              .doc(nomeController.text)
              .set(cliente);
          debugPrint(
            jsonEncode(cliente),
          );
          setState(() {
            Navigator.pop(context);
            CustomAlertDialog.cadastroResponsavelSucesso(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          });
        } catch (e) {
          setState(() {
            CustomAlertDialog.cadastroResponsavelErro(context, '$e');
          });
        }
      }
    }
  }

  Future<bool> _verificarCadastroResponsavel() async {
    // final codigo = codigoController.text;
    final cpf = cpfController.text;
    // Realize a consulta no Firestore para verificar
    //se o cliente já está cadastrado
    final query = await FirebaseFirestore.instance
        .collection('clientes')
        .where('cpf', isEqualTo: cpf)
        .get();

    if (query.docs.isNotEmpty) {
      setState(() {
        CustomAlertDialog.cadastroResponsavelRepetido(context);
      });
      return false; // Responsavel já está cadastrado
    } else {
      return true; // Responsavel não está cadastrado
    }
  }

  Future<void> _preencherEnderecoPorCEP(String cepController) async {
    final url = Uri.parse(
      'https://viacep.com.br/ws/$cepController/json/',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          paisController.text =
              'Brasil'; // País fixo para o Brasil, pois a API retorna apenas dados nacionais
          ufController.text = data['uf'];
          cidadeController.text = data['localidade'];
          bairroController.text = data['bairro'];

          logradouroController.text = data['logradouro'];
        });
      } else {
        setState(() {
          CustomAlertDialog.erroCep(context, '');
        });
      }
    } catch (e) {
      setState(() {
        CustomAlertDialog.erroCep(context, ': $e');
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showFilterIcon: false,
        leftContent: Text(
          'Cadastrar Responsavel',
          style: TextStyle(
            color: ColorsApp.instance.CinzaMedio2,
            fontSize: 24,
            fontFamily: 'roboto',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Flexible(
              flex: 6,
              child: Container(
                color: ColorsApp.instance.Branco,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                  ),
                  margin: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        const SizedBox(
                            height: 20,
                            child: Text(
                              'Cadastro de Pessoas',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: nomeController,
                          decoration: getCustomInputDecoration('Nome*'),
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
                          controller: cpfController,
                          decoration: getCustomInputDecoration('CPF/CNPJ*'),
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
                          controller: foneController,
                          decoration: getCustomInputDecoration('Fone'),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: getCustomInputDecoration('E-mail'),
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
                                controller: cepController,
                                decoration: getCustomInputDecoration('CEP*'),
                                onChanged: (value) {
                                  if (value.length == 8) {
                                    _preencherEnderecoPorCEP(value);
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
                              flex: 3,
                              child: TextFormField(
                                controller: ufController,
                                decoration: getCustomInputDecoration('UF'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: paisController,
                          decoration: getCustomInputDecoration('País'),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: cidadeController,
                          decoration: getCustomInputDecoration('Cidade'),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: bairroController,
                          decoration: getCustomInputDecoration('Bairro'),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: logradouroController,
                          decoration: getCustomInputDecoration('Rua'),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 3,
                              child: TextFormField(
                                controller: numeroController,
                                decoration: getCustomInputDecoration('Número'),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Flexible(
                              flex: 5,
                              child: TextFormField(
                                controller: complementoController,
                                decoration:
                                    getCustomInputDecoration('Complemento'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _cadastrarResponsavel,
                          child: const Text('Cadastrar'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Flexible(
              flex: 4,
              child: PessoaCadastroWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
