import 'package:flutter/material.dart';
import 'package:sistemarenascerdaesperanca/src/models/dados_responsavel_models.dart';
import 'package:sistemarenascerdaesperanca/src/styles/colors_app.dart';
import 'package:sistemarenascerdaesperanca/src/widgets/appbar_custom.dart';

class DetalhesResponsavelPage extends StatelessWidget {
  final Responsavel cliente;

  const DetalhesResponsavelPage({super.key, required this.cliente});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showFilterIcon: false,
        leftContent: Text(
          'Detalhes do Responsável',
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
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                // Tela grande, exibir lado a lado
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Detalhes do Responsável
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // // Espaço para Imagem do Responsável
                          // Container(
                          //   height: 150,
                          //   width: double.infinity,
                          //   color: Colors.grey[300],
                          //   child: const Center(
                          //     child: Text('Imagem do Responsável'),
                          //   ),
                          // ),
                          const SizedBox(height: 20),
                          TextFormField(
                            readOnly: true,
                            initialValue: cliente.nome,
                            decoration: decorationReadOnly('Nome'),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            readOnly: true,
                            initialValue: cliente.cpf,
                            decoration: decorationReadOnly('CPF'),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            readOnly: true,
                            initialValue: cliente.fone,
                            decoration: decorationReadOnly('Telefone'),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            readOnly: true,
                            initialValue: cliente.email,
                            decoration: decorationReadOnly('Email'),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            readOnly: true,
                            initialValue: cliente.endereco,
                            decoration: decorationReadOnly('Endereço'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Detalhes dos Familiares
                    if (cliente.dadosDosFamiliaresCadastradols != null &&
                        cliente.dadosDosFamiliaresCadastradols!.isNotEmpty)
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // // Espaço para Imagem dos Familiares
                            // Container(
                            //   height: 150,
                            //   width: double.infinity,
                            //   color: Colors.grey[300],
                            //   child: const Center(
                            //     child: Text('Imagem dos Familiares'),
                            //   ),
                            // ),
                            const SizedBox(height: 20),
                            Text(
                              'Familiares:',
                              style: TextStyle(
                                color: ColorsApp.instance.CinzaMedio2,
                                fontSize: 18,
                                fontFamily: 'roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                              child: ListView(
                                children: cliente
                                    .dadosDosFamiliaresCadastradols!
                                    .map((familiar) {
                                  return Card(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('Nome: ${familiar['nome']}'),
                                          Text('Idade: ${familiar['idade']}'),
                                          if (familiar['isConjuge'] == true)
                                            const Text('Cônjuge'),
                                          if (familiar['isFilho'] == true)
                                            const Text('Filho(a)'),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              } else {
                // Tela pequena, exibir em coluna
                return ListView(
                  children: <Widget>[
                    // Detalhes do Responsável
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Espaço para Imagem do Responsável
                        Container(
                          height: 150,
                          width: double.infinity,
                          color: Colors.grey[300],
                          child: const Center(
                            child: Text('Imagem do Responsável'),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          readOnly: true,
                          initialValue: cliente.nome,
                          decoration: decorationReadOnly('Nome'),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          readOnly: true,
                          initialValue: cliente.cpf,
                          decoration: decorationReadOnly('CPF'),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          readOnly: true,
                          initialValue: cliente.fone,
                          decoration: decorationReadOnly('Telefone'),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          readOnly: true,
                          initialValue: cliente.email,
                          decoration: decorationReadOnly('Email'),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          readOnly: true,
                          initialValue: cliente.endereco,
                          decoration: decorationReadOnly('Endereço'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Detalhes dos Familiares
                    if (cliente.dadosDosFamiliaresCadastradols != null &&
                        cliente.dadosDosFamiliaresCadastradols!.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Espaço para Imagem dos Familiares
                          Container(
                            height: 150,
                            width: double.infinity,
                            color: Colors.grey[300],
                            child: const Center(
                              child: Text('Imagem dos Familiares'),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Familiares:',
                            style: TextStyle(
                              color: ColorsApp.instance.CinzaMedio2,
                              fontSize: 18,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ...cliente.dadosDosFamiliaresCadastradols!
                              .map((familiar) {
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Nome: ${familiar['nome']}'),
                                    Text('Idade: ${familiar['idade']}'),
                                    if (familiar['isConjuge'] == true)
                                      const Text('Cônjuge'),
                                    if (familiar['isFilho'] == true)
                                      const Text('Filho(a)'),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  InputDecoration decorationReadOnly(String label) {
    return InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
      fillColor: Colors.grey.shade200,
      filled: true,
    );
  }
}
