// listar_pessoas.dart
// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sistemarenascerdaesperanca/models/cliente_models.dart';
import 'package:sistemarenascerdaesperanca/reposotory/cliente_repository.dart';
import 'package:sistemarenascerdaesperanca/screens/cadastrar_pessoas.dart';
import 'package:sistemarenascerdaesperanca/screens/detalhes_das_pessoas_cadastradas.dart';
import 'package:sistemarenascerdaesperanca/styles/colors_app.dart';
import 'package:sistemarenascerdaesperanca/widgets/appbar_custom.dart';
import 'package:sistemarenascerdaesperanca/widgets/cliente_list_item.dart';

class ListarPessoas extends StatefulWidget {
  const ListarPessoas({Key? key}) : super(key: key);

  @override
  _ListarPessoasState createState() => _ListarPessoasState();
}

class _ListarPessoasState extends State<ListarPessoas> {
  List<Cliente> clientes = [];
  List<Cliente> clientesFiltrados = [];
  late TextEditingController _searchController;
  late StreamController<List<Cliente>> _streamController;
  late List<Cliente> clientesSnapshot = [];
  final ClienteRepository clienteRepository = ClienteRepository();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _streamController = StreamController<List<Cliente>>.broadcast();
    _carregarClientes();
  }

  Future<void> _carregarClientes() async {
    final clientesList = await clienteRepository.fetchClientes();
    clientesSnapshot = clientesList;
    _streamController.add(clientesList);
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
    await clienteRepository.deleteCliente(cliente);
    _carregarClientes();
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

                  return LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      // Verificar a largura da tela
                      if (constraints.maxWidth > 600) {
                        // Se a largura da tela for maior que 600, use o GridView
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 12,
                            mainAxisExtent: 120
                          ),
                          itemCount: clientes.length,
                          itemBuilder: (context, index) {
                            final cliente = clientes[index];
                            return ClienteListItem(
                              cliente: cliente,
                              onTapCallback: navigateToDetalhesCliente,
                              onDelete: onDelete,
                            );
                          },
                        );
                      } else {
                        // Caso contrário, continue usando o ListView.builder
                        return ListView.builder(
                          itemCount: clientes.length,
                          itemBuilder: (context, index) {
                            final cliente = clientes[index];
                            return ClienteListItem(
                              cliente: cliente,
                              onTapCallback: navigateToDetalhesCliente,
                              onDelete: onDelete,
                            );
                          },
                        );
                      }
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
