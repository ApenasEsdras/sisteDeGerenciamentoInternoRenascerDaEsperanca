// cliente_list_item.dart
import 'package:flutter/material.dart';
import 'package:sistemarenascerdaesperanca/models/cliente_models.dart';
import 'package:sistemarenascerdaesperanca/styles/colors_app.dart';

class ClienteListItem extends StatelessWidget {
  final Cliente cliente;
  final Function(Cliente) onTapCallback;
  final Function(Cliente) onDelete;
  final int maxCaracteres = 30;

  const ClienteListItem({
    Key? key,
    required this.cliente,
    required this.onTapCallback,
    required this.onDelete,
  }) : super(key: key);

  String getNomeExibido(String? nome) {
    if (nome != null && nome.length > maxCaracteres) {
      return '${nome.substring(0, maxCaracteres)}...';
    } else {
      return nome ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    String nomeExibido = getNomeExibido(cliente.nome);

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
                    onDelete(cliente);
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
          onTap: () {
            onTapCallback(cliente);
          },
          iconColor: ColorsApp.instance.CinzaEscuro,
        ),
      ),
    );
  }
}
