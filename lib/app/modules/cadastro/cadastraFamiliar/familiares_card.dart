// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:sistemarenascerdaesperanca/styles/widget/iput_decoration.dart';

import '../../../../styles/colors_app.dart';
import 'cadastra_familiar_model.dart';

class CadastroPessoaPage extends StatefulWidget {
  const CadastroPessoaPage({Key? key}) : super(key: key);

  @override
  _CadastroPessoaPageState createState() => _CadastroPessoaPageState();
}

class _CadastroPessoaPageState extends State<CadastroPessoaPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  String _selectedGender = 'Masculino'; // Valor padrão
  final List<String> _genders = ['Masculino', 'Feminino', 'Outro']; // Opções

  bool _isConjuge = false;
  bool _isFilho = false;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _nomeController,
          decoration: InputDecorationUtils.getCustomInputDecoration('Nome'),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: _idadeController,
          decoration: InputDecorationUtils.getCustomInputDecoration('Idade'),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 20),
        DropdownButtonFormField<String>(
          value: _selectedGender,
          items: _genders.map((String gender) {
            return DropdownMenuItem<String>(
              value: gender,
              child: Text(gender),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              _selectedGender = value!;
            });
          },
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            labelText: 'Selecione o gênero',
            labelStyle: TextStyle(
              fontFamily: 'roboto',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ColorsApp.instance.CinzaEscuro,
            ),
            floatingLabelStyle: MaterialStateTextStyle.resolveWith(
              (Set<MaterialState> states) {
                final Color color = states.contains(MaterialState.focused)
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
        const SizedBox(height: 20),
        Row(
          children: [
            Checkbox(
              value: _isConjuge,
              onChanged: (bool? value) {
                setState(() {
                  _isConjuge = value!;
                });
              },
            ),
            const Text('É cônjuge'),
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: _isFilho,
              onChanged: (bool? value) {
                setState(() {
                  _isFilho = value!;
                });
              },
            ),
            const Text('É filho/filha'),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            // Adiciona um novo familiar à lista
            setState(() {
              Familiares.familiaresList.add(Familiares(
                nome: _nomeController.text,
                idade: int.parse(_idadeController.text),
                sexo: _selectedGender,
                isConjuge: _isConjuge,
                isFilho: _isFilho,
              ));
            });
          },
          child: const Text('Adicionar Familiar'),
        ),
        // Exibe os familiares adicionados
        ...Familiares.familiaresList.map((familiar) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nome: ${familiar.nome}'),
              Text('Idade: ${familiar.idade}'),
              Text('Sexo: ${familiar.sexo}'),
              Text('É cônjuge: ${familiar.isConjuge}'),
              Text('É filho/filha: ${familiar.isFilho}'),
              const Divider(),
            ],
          );
          
        }),
        
      ],
    );
  }
}
