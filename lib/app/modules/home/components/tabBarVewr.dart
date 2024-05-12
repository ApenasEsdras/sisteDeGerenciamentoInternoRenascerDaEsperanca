// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../../cadastro/cadastraFamiliar/familiares_card.dart';
import '../../cadastro/cadastraResponsavel/cadastro_responsavel_page.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({Key? key}) : super(key: key);

  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Responsável'),
            Tab(text: 'Familiares'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          // Conteúdo da primeira aba (Responsável)
          SingleChildScrollView(
            child: Column(
              children: [
               CadastroResponsavelPage()
              ],
            ),
          ),
          // Conteúdo da segunda aba (Familiares)
          SingleChildScrollView(
            child: Column(
              children: [
                CadastroPessoaPage()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
