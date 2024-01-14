// ignore_for_file: library_private_types_in_public_api, require_trailing_commas

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sistemarenascerdaesperanca/screens/cadastrar_pessoas.dart';
import 'package:sistemarenascerdaesperanca/screens/detales_das_pessoas_cadastradas.dart';
import 'package:sistemarenascerdaesperanca/styles/colors_app.dart';
import 'package:sistemarenascerdaesperanca/util/pessoas_construcror.dart';
import 'package:sistemarenascerdaesperanca/widgets/appbar_custom.dart';

class ListarPessoas extends StatefulWidget {
  const ListarPessoas({Key? key}) : super(key: key);

  @override
  _ListarPessoasState createState() => _ListarPessoasState();
}

class _ListarPessoasState extends State<ListarPessoas> {
  final int maxCaracteres = 30;
  List<Cliente> clientes = [];
  List<Cliente> clientesFiltrados = [];
  late TextEditingController _searchController;
  late StreamController<List<Cliente>> _streamController;
  late List<Cliente> clientesSnapshot = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _streamController = StreamController<List<Cliente>>.broadcast();
    _carregarClientes();
  }

  Future<void> _carregarClientes() async {
    final clientesList = await fetchClientes();
    clientesSnapshot = clientesList;
    _streamController.add(clientesList);
  }

  Future<List<Cliente>> fetchClientes() async {
    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('responsaveis').get();

      if (querySnapshot.docs.isNotEmpty) {
        final clienteList = <Cliente>[];

        for (final doc in querySnapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;

          final nome = data['nome'];
          final idade = data['idade'];
          final endereco = data['endereco'];
          final fone = data['fone'];

          final clienteData = Cliente(
            nome: nome,
            idade: idade,
            endereco: endereco,
            fone: fone,
          );
          clienteList.add(clienteData);
        }

        return clienteList;
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
    List<Cliente> filteredClientes;

    if (query.isEmpty) {
      filteredClientes = List.from(clientesSnapshot);
    } else {
      filteredClientes = clientesSnapshot
          .where((cliente) =>
              (cliente.nome?.toLowerCase().contains(query.toLowerCase()) ??
                  false) ||
              (cliente.fone?.toLowerCase().contains(query.toLowerCase()) ??
                  false))
          .toList();
    }

    _streamController.add(filteredClientes);
  }

  void navigateToDetalhesCliente(Cliente cliente) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetalhesClientePage(cliente: cliente),
      ),
    );
  }

  void onDelete(Cliente cliente) async {
    try {
      await FirebaseFirestore.instance
          .collection('responsaveis')
          .doc(cliente
              .nome) // Substitua "id" pelo campo que representa a identificação do documento
          .delete();
      // Atualize a lista após a exclusão
      _carregarClientes();
    } catch (e) {
      print('Erro ao excluir cliente: $e');
    }
  }

  Widget _buildClienteListItem(
    Cliente cliente,
    Function(Cliente) onTapCallback,
    Function(Cliente) onDelet,
  ) {
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
                  } else if (value == 'Excluir') {
                    // onClienteSelecionado(cliente);

                    onDelet(cliente);
                  }
                },
                itemBuilder: (BuildContext context) {
                  return {'Editar', 'Excluir'}.map((String choice) {
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
          //chama funcao e atribui o valor do cliente selecionado
          onTap: () {
            onTapCallback(cliente);
          },
          iconColor: ColorsApp.instance.CinzaEscuro,
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
              child: StreamBuilder<List<Cliente>>(
                stream: _streamController.stream,
                initialData: clientesSnapshot,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Cliente>> snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Erro: ${snapshot.error}'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final clientes = snapshot.data!;

                  if (clientes.isEmpty) {
                    return const Center(
                        child: Text('Nenhum cliente encontrado.'));
                  }

                  return ListView.builder(
                    itemCount: clientes.length,
                    itemBuilder: (context, index) {
                      final cliente = clientes[index];
                      return _buildClienteListItem(
                          cliente, navigateToDetalhesCliente, onDelete);
                    },
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
