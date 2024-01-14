import 'package:flutter/material.dart';
import 'package:sistemarenascerdaesperanca/screens/lista_pessoas.dart.dart';
import 'package:sistemarenascerdaesperanca/styles/app_styles.dart';
import 'package:sistemarenascerdaesperanca/styles/colors_app.dart';
import 'package:sistemarenascerdaesperanca/widgets/appbar_custom.dart';

class DetalhesClientePage extends StatelessWidget {
  final Cliente cliente;

  const DetalhesClientePage({super.key, required this.cliente});

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
                  decoration: decorationReadOnly(
                    'Nome',
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
                  readOnly: true,
                  initialValue: cliente.codigo,
                  decoration: decorationReadOnly('Código'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  readOnly: true,
                  initialValue: cliente.classe,
                  decoration: decorationReadOnly('Classe'),
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
                  readOnly: true,
                  initialValue: cliente.cgccpf,
                  decoration: decorationReadOnly('CGC/CPF'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ListTileTheme(
                    contentPadding: const EdgeInsets.all(0),
                    horizontalTitleGap: 0.0,
                    minLeadingWidth: 0,
                    child: ExpansionTile(
                      title: const Text('Endereço'),
                      children: <Widget>[
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 5,
                              child: TextFormField(
                                readOnly: true,
                                initialValue: cliente.cep,
                                decoration: decorationReadOnly('CEP'),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Flexible(
                              flex: 3,
                              child: TextFormField(
                                readOnly: true,
                                initialValue: cliente.uf,
                                decoration: decorationReadOnly('UF'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          readOnly: true,
                          initialValue: cliente.pais,
                          decoration: decorationReadOnly('País'),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          readOnly: true,
                          initialValue: cliente.localidade,
                          decoration: decorationReadOnly('Localidade'),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          readOnly: true,
                          initialValue: cliente.sublocalidade,
                          decoration: decorationReadOnly('Sublocalidade'),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          readOnly: true,
                          initialValue: cliente.logradouro,
                          decoration: decorationReadOnly(
                            'Tipo de Logradouro',
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          readOnly: true,
                          initialValue: cliente.logradouro,
                          decoration: decorationReadOnly('Logradouro'),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 3,
                              child: TextFormField(
                                readOnly: true,
                                initialValue: cliente.numero,
                                decoration: decorationReadOnly('Número'),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Flexible(
                              flex: 5,
                              child: TextFormField(
                                readOnly: true,
                                initialValue: cliente.complemento,
                                decoration: decorationReadOnly('Complemento'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ListTileTheme(
                    contentPadding: const EdgeInsets.all(0),
                    horizontalTitleGap: 0.0,
                    minLeadingWidth: 0,
                    child: ExpansionTile(
                      title: const Text('Contato'),
                      children: <Widget>[
                        const SizedBox(height: 20),
                        TextFormField(
                          readOnly: true,
                          initialValue: cliente.fone,
                          decoration: decorationReadOnly('Fone'),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          readOnly: true,
                          initialValue: cliente.email,
                          decoration: decorationReadOnly('E-mail'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
