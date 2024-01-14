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

class CadastroClientePage extends StatefulWidget {
  const CadastroClientePage({super.key});

  @override
  _CadastroClientePageState createState() => _CadastroClientePageState();
}

class _CadastroClientePageState extends State<CadastroClientePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // TextEditingController codigoController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  // TextEditingController classeController = TextEditingController();

  TextEditingController cgccpfController = TextEditingController();
  TextEditingController paisController = TextEditingController();
  TextEditingController ufController = TextEditingController();
  TextEditingController tipologradouroController = TextEditingController();
  TextEditingController logradouroController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController complementoController = TextEditingController();
  TextEditingController foneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  Future<void> _cadastrarCliente() async {
    if (_formKey.currentState!.validate()) {
      final bool clienteNaoCadastrado = await _verificarCadastroCliente();
      if (clienteNaoCadastrado) {
        final cliente = {
          'codigo': cgccpfController.text,
          'endereco':
              '${tipologradouroController.text} ${numeroController.text}',
          'nome': nomeController.text,
          'classe': 'Clientes',
          'cgccpf': cgccpfController.text,
          'pais': paisController.text,
          'uf': ufController.text,
          'localidade': cidadeController.text,
          'sublocalidade': bairroController.text,
          'tipologradouro': tipologradouroController.text,
          'logradouro': logradouroController.text,
          'bairro': bairroController.text,
          'cidade': cidadeController.text,
          'cep': cepController.text,
          'numero': numeroController.text,
          'complemento': complementoController.text,
          'fone': foneController.text,
          'email': emailController.text,
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
            // converrte e exibe os dados do pedidio em Json
            jsonEncode(cliente),
          );
          setState(() {
            Navigator.pop(context);
            CustomAlertDialog.cadastroClienteSucesso(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          });
        } catch (e) {
          setState(() {
            CustomAlertDialog.cadastroClienteErro(context, '$e');
          });
        }
      }
    }
  }

  Future<bool> _verificarCadastroCliente() async {
    // final codigo = codigoController.text;
    final cgccpf = cgccpfController.text;

    // Realize a consulta no Firestore para verificar se o cliente já está cadastrado
    final query = await FirebaseFirestore.instance
        .collection('clientes')
        // .where('codigo', isEqualTo: codigo)
        .where('cgccpf', isEqualTo: cgccpf)
        .get();

    if (query.docs.isNotEmpty) {
      setState(() {
        CustomAlertDialog.cadastroClienteRepetido(context);
      });
      return false; // Cliente já está cadastrado
    } else {
      return true; // Cliente não está cadastrado
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
          tipologradouroController.text = data['logradouro'];
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
      body: Container(
        color: ColorsApp.instance.Branco,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: nomeController,
                  decoration: InputDecoration(
                    labelText: 'Nome*',
                    labelStyle: TextStyle(
                      fontFamily: 'roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorsApp.instance.CinzaEscuro,
                    ),
                    floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                      (Set<MaterialState> states) {
                        final Color color =
                            states.contains(MaterialState.focused)
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
                  ),
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
                  controller: cgccpfController,
                  decoration: InputDecoration(
                    labelText: 'CPF/CNPJ*',
                    labelStyle: TextStyle(
                      fontFamily: 'roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorsApp.instance.CinzaEscuro,
                    ),
                    floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                      (Set<MaterialState> states) {
                        final Color color =
                            states.contains(MaterialState.focused)
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
                  ),
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
                  decoration: InputDecoration(
                    labelText: 'Fone',
                    labelStyle: TextStyle(
                      fontFamily: 'roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorsApp.instance.CinzaEscuro,
                    ),
                    floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                      (Set<MaterialState> states) {
                        final Color color =
                            states.contains(MaterialState.focused)
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
                  ),
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
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    labelStyle: TextStyle(
                      fontFamily: 'roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorsApp.instance.CinzaEscuro,
                    ),
                    floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                      (Set<MaterialState> states) {
                        final Color color =
                            states.contains(MaterialState.focused)
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
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(
                        fontFamily: 'roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ColorsApp.instance.CinzaEscuro,
                      ),
                      floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                        (Set<MaterialState> states) {
                          final Color color =
                              states.contains(MaterialState.focused)
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
                    ),
                  ),
                  child: ListTileTheme(
                    contentPadding: const EdgeInsets.all(4),
                    horizontalTitleGap: 4.0,
                    minLeadingWidth: 0,
                    child: ExpansionTile(
                      title: const Text('Endereço*'),
                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 5,
                              child: TextFormField(
                                controller: cepController,
                                decoration:
                                    const InputDecoration(labelText: 'CEP'),
                                onChanged: (value) {
                                  if (value.length == 8) {
                                    _preencherEnderecoPorCEP(value);
                                  }
                                },
                                validator: (value) {
                                  if (value!.length != 8 && value.isNotEmpty) {
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
                                decoration:
                                    const InputDecoration(labelText: 'UF*'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Campo obrigatório';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: paisController,
                          decoration: const InputDecoration(labelText: 'País'),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: cidadeController,
                          decoration:
                              const InputDecoration(labelText: 'Cidade'),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: bairroController,
                          decoration:
                              const InputDecoration(labelText: 'Bairro'),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: tipologradouroController,
                          decoration: const InputDecoration(
                              labelText: 'Tipo de Logradouro'),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: logradouroController,
                          decoration:
                              const InputDecoration(labelText: 'Logradouro'),
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
                                decoration:
                                    const InputDecoration(labelText: 'Número'),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Flexible(
                              flex: 5,
                              child: TextFormField(
                                controller: complementoController,
                                decoration: const InputDecoration(
                                  labelText: 'Complemento',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _cadastrarCliente,
                  child: const Text('Cadastrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
