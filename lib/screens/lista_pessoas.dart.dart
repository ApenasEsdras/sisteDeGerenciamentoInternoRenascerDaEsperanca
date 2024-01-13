// ignore_for_file: library_private_types_in_public_api, require_trailing_commas

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sistemarenascerdaesperanca/router/orders_page.dart';
import 'package:sistemarenascerdaesperanca/screens/cadastrar_pessoas.dart';
import 'package:sistemarenascerdaesperanca/screens/detales_das_pessoas_cadastradas.dart';
import 'package:sistemarenascerdaesperanca/styles/colors_app.dart';

class ListarPessoas extends StatefulWidget {
  const ListarPessoas({super.key});

  @override
  _ListarPessoasState createState() => _ListarPessoasState();
}

class _ListarPessoasState extends State<ListarPessoas> {
  List<Cliente> clientes = [];
  List<Cliente> clientesFiltrados = [];
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _carregarClientes();
  }

  Future<void> _carregarClientes() async {
    final clientesList = await fetchClientes();
    setState(() {
      clientes = clientesList;
      clientesFiltrados = clientesList;
    });
  }

  Future<List<Cliente>> fetchClientes() async {
    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('responsaveis').get();

      if (querySnapshot.docs.isNotEmpty) {
        final cliente = <Cliente>[];

        for (final doc in querySnapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;
          print(data['nome']);

          final nome = data['nome'];
          final idade = data['idade'];
          final endereco = data['endereco'];
            final fone = data['fone'];
          /*
          final email = data['email'];
          final codigo = data['codigo'];
          final cgccpf = data['cgccpf'];
          final chave = data['chave'];
          final classe = data['classe'];
          final pais = data['pais'];
          final uf = data['uf'];
          final localidade = data['localidade'];
          final sublocalidade = data['sublocalidade'];
          final logradouro = data['logradouro'];
          final tipologradouro = data['tipologradouro'];
          final cep = data['cep'];
          final numero = data['numero'];
          final complemento = data['complemento'];*/

          final clienteData = Cliente(
            nome: nome,
            idade: idade,
            endereco: endereco,
             fone: fone,
            /*
            email: email,
            codigo: codigo,
            cgccpf: cgccpf,
            chave: chave,
            classe: classe,
            pais: pais,
            uf: uf,
            localidade: localidade,
            sublocalidade: sublocalidade,
            logradouro: logradouro,
            cep: cep,
            numero: numero,
            complemento: complemento,
            tipologradouro: tipologradouro,
            */
          );
          cliente.add(clienteData);
          if (kDebugMode) {
            print('Lista de clientes: ${clienteData.nome}');
          }
        }

        return cliente;
      } else {
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao carregar clientes: $e');
      }
      return [];
    }
  }

  void filterClientes(String query) {
    if (kDebugMode) {
      print('Filtrando clientes com a consulta: $query');
    }

    setState(() {
      if (query.isEmpty) {
        clientesFiltrados = clientes;
      } else {
        clientesFiltrados = clientes
            .where((cliente) =>
                (cliente.nome
                        ?.toLowerCase()
                        .contains(query.toLowerCase()) ??
                    false) ||
                (cliente.fone?.toLowerCase().contains(query.toLowerCase()) ??
                    false) ||
                (cliente.cgccpf?.toLowerCase().contains(query.toLowerCase()) ??
                    false) ||
                (cliente.codigo?.toLowerCase().contains(query.toLowerCase()) ??
                    false))
            .toList();
      }
    });
  }

  void navigateToDetalhesCliente(Cliente cliente) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetalhesClientePage(cliente: cliente),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorsApp.instance.Branco,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 20.0,
                left: 20,
                right: 20,
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (query) {
                  filterClientes(query);
                },
                decoration: InputDecoration(
                  hintText: 'Pesquisar cliente',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: clientesFiltrados.length,
                itemBuilder: (context, index) {
                  final cliente = clientesFiltrados[index];
                  return GestureDetector(
                    onTap: () {
                      navigateToDetalhesCliente(cliente);
                    },
                    child: ClienteCard(
                      cliente,
                      onClienteSelecionado: (clienteSelecionado) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrdersPage(
                              clienteNome: cliente.nome.toString(),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 78,
        height: 78,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: ColorsApp.instance.Laranja,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CadastroClientePage(),
                ),
              );
            },
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: const Icon(
              Icons.person_add,
              size: 26,
            ),
          ),
        ),
      ),
    );
  }
}

class Cliente {
  String? nome;
  int? idade;
  String? endereco;
  String? fone;
  String? email;
  String? codigo;
  String? cgccpf;
  int? chave;
  String? classe;
  String? pais;
  String? uf;
  String? localidade;
  String? sublocalidade;
  String? logradouro;
  String? cep;
  String? numero;
  String? complemento;
  String? tipologradouro;

  Cliente({
    this.nome,
    this.fone,
    this.email,
    this.codigo,
    this.cgccpf,
    this.chave,
    this.classe,
    this.pais,
    this.uf,
    this.localidade,
    this.sublocalidade,
    this.logradouro,
    this.cep,
    this.numero,
    this.complemento,
    this.tipologradouro,
    this.idade,
    this.endereco,
  });
}

class ClienteCard extends StatelessWidget {
  final Cliente cliente;
  final int maxCaracteres = 30;

  const ClienteCard(
    this.cliente, {
    super.key,
    required this.onClienteSelecionado,
  });

  final Function(Cliente) onClienteSelecionado;

  @override
  Widget build(BuildContext context) {
    String nomeExibido = cliente.nome.toString();

    if (cliente.nome!.length > maxCaracteres) {
      nomeExibido = '${cliente.nome?.substring(0, maxCaracteres)}...';
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorsApp.instance.Branco,
        border: Border(
          bottom: BorderSide(
            color: ColorsApp.instance.CinzaMedio,
            width: 0.8,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 6.0,
          bottom: 6.0,
          left: 10.0,
          right: 0,
        ),
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                nomeExibido,
                overflow: TextOverflow.ellipsis,
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'editar') {
                    // Ação de editar
                  } else if (value == 'criar_pedido') {
                    onClienteSelecionado(cliente);
                  }
                },
                itemBuilder: (BuildContext context) {
                  return {'Editar', 'Criar Pedido'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Telefone: ${cliente.fone}'),
                const SizedBox(
                  height: 6,
                ),
                Text('endereço: ${cliente.endereco}'),
              ],
            ),
          ),
          iconColor: ColorsApp.instance.CinzaEscuro,
        ),
      ),
    );
  }
}
