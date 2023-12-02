import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../util/pessoas.dart';

class ListaPessoas extends StatelessWidget {
  const ListaPessoas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pessoas'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('responsaveis').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao carregar os dados'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Transforma os documentos em instâncias da classe Pessoa
          List<Pessoa> pessoas = snapshot.data!.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return Pessoa(nome: data['nome'], endereco: data['endereco']);
          }).toList();

          return ListView.builder(
            itemCount: pessoas.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(pessoas[index].nome),
                subtitle: Text(pessoas[index].endereco),
              );
            },
          );
        },
      ),
    );
  }
}
