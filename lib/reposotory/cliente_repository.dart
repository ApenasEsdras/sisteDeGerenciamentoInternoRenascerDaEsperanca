// cliente_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sistemarenascerdaesperanca/models/cliente_models.dart';

class ClienteRepository {
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

  Future<void> deleteCliente(Cliente cliente) async {
    try {
      await FirebaseFirestore.instance
          .collection('responsaveis')
          .doc(cliente.nome!) // Substitua pelo campo identificador correto
          .delete();
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao excluir cliente: $e');
      }
    }
  }
}
