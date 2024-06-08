import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sistemarenascerdaesperanca/app/models/dados_responsavel_models.dart';

class ResponsavelRepository {
  Future<List<Responsavel>> fetchResponsavels() async {
    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('responsaveis').get();

      if (querySnapshot.docs.isNotEmpty) {
        final clienteList = <Responsavel>[];

        for (final doc in querySnapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;
          final clienteData = Responsavel.fromJson(data);
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

  Future<void> deleteResponsavel(Responsavel cliente) async {
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
