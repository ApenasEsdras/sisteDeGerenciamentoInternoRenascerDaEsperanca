

import 'package:flutter/material.dart';
import 'package:renascer_sistema/src/styles/text_styles.dart';

import '../../../styles/colors_app.dart';
import '../../../styles/widget/iput_decoration.dart';
import '../cadastraFamiliar/familiares_card.dart';
import 'cadastro_responsavel_controller.dart';

class CadastroResponsavelForm extends StatefulWidget {
  final CadastroResponsavelController controller;

  const CadastroResponsavelForm({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<CadastroResponsavelForm> createState() =>
      _CadastroResponsavelFormState();
}

class _CadastroResponsavelFormState extends State<CadastroResponsavelForm> {
  // File? _image; // Para armazenar a imagem no Android/iOS
  // Uint8List? _webImage; // Para armazenar a imagem na web

  // Future<void> _pickImage() async {
  //   if (kIsWeb) {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       type: FileType.image,
  //     );

  //     if (result != null) {
  //       setState(() {
  //         _webImage = result.files.first.bytes;
  //       });
  //     }
  //   } else {
  //     final ImagePicker picker = ImagePicker();
  //     final XFile? pickedFile =
  //         await picker.pickImage(source: ImageSource.gallery);

  //     if (pickedFile != null) {
  //       setState(() {
  //         _image = File(pickedFile.path);
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        Form(
          key: widget.controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Center(
              //   child: Container(
              //     width: 150,
              //     height: 150,
              //     decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //       image: _image != null && !kIsWeb
              //           ? DecorationImage(
              //               image: FileImage(
              //                   _image!), // Exibe a imagem selecionada no Android/iOS
              //               fit: BoxFit.cover,
              //             )
              //           : _webImage != null
              //               ? DecorationImage(
              //                   image: MemoryImage(
              //                       _webImage!), // Exibe a imagem selecionada na Web
              //                   fit: BoxFit.cover,
              //                 )
              //               : const DecorationImage(
              //                   image: AssetImage(
              //                       'assets/images/placeholder.png'), // Imagem de exemplo
              //                   fit: BoxFit.cover,
              //                 ),
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 20),
              // Center(
              //   child: ElevatedButton(
              //     onPressed: () {
              //       _pickImage(); // Seleciona imagem da galeria/web
              //     },
              //     child: const Text('Adicionar Imagem'),
              //   ),
              // ),
              const SizedBox(height: 20),
              TextFormField(
                controller: widget.controller.nomeController,
                decoration:
                    InputDecorationUtils.getCustomInputDecoration('Nome*'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: widget.controller.cpfController,
                decoration:
                    InputDecorationUtils.getCustomInputDecoration('CPF/CNPJ*'),
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
                controller: widget.controller.foneController,
                decoration:
                    InputDecorationUtils.getCustomInputDecoration('Fone'),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: widget.controller.emailController,
                decoration:
                    InputDecorationUtils.getCustomInputDecoration('E-mail'),
              ),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                  height: 20,
                  child: Text(
                    'Endereço',
                    style: TextStyle(
                      fontFamily: 'roboto',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 5,
                    child: TextFormField(
                      controller: widget.controller.cepController,
                      decoration:
                          InputDecorationUtils.getCustomInputDecoration('CEP*'),
                      onChanged: (value) {
                        if (value.length == 8) {
                          widget.controller.preencherEnderecoPorCEP(value);
                        }
                      },
                      validator: (value) {
                        if (value!.length != 8 && value.isEmpty) {
                          return 'CEP inválido';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    flex: 5,
                    child: TextFormField(
                      controller: widget.controller.ufController,
                      decoration:
                          InputDecorationUtils.getCustomInputDecoration('UF'),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 5,
                    child: TextFormField(
                      controller: widget.controller.paisController,
                      decoration:
                          InputDecorationUtils.getCustomInputDecoration('PAIS'),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    flex: 5,
                    child: TextFormField(
                      controller: widget.controller.cidadeController,
                      decoration: InputDecorationUtils.getCustomInputDecoration(
                          'Cidade'),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 5,
                    child: TextFormField(
                      controller: widget.controller.bairroController,
                      decoration: InputDecorationUtils.getCustomInputDecoration(
                          'Bairro'),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    flex: 5,
                    child: TextFormField(
                      controller: widget.controller.logradouroController,
                      decoration:
                          InputDecorationUtils.getCustomInputDecoration('Rua'),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: TextFormField(
                      controller: widget.controller.numeroController,
                      decoration: InputDecorationUtils.getCustomInputDecoration(
                          'Número'),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    flex: 5,
                    child: TextFormField(
                      controller: widget.controller.complementoController,
                      decoration: InputDecorationUtils.getCustomInputDecoration(
                          'Complemento'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Cadastro de Familiar',
                style: TextStyle(
                  fontFamily: 'roboto',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              const CadastroPessoaPage(),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // widget.controller
                        //     .cadastrarResponsavel(context, _image, _webImage);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsApp.instance.AzulClaro,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        'Cadastrar',
                        style: context.textStyles.textMedium20.copyWith(
                          fontSize: 20,
                          color: ColorsApp.instance.Branco,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
