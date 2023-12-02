import 'package:flutter/material.dart';

class CustomAlertDialog {
  static void loginErro(BuildContext context) {
    const snackBar = SnackBar(
      content: Text(
        'Nome de usuário ou senha inválida.',
      ),
      dismissDirection: DismissDirection.horizontal,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(12),
      showCloseIcon: true,
      closeIconColor: Color.fromRGBO(253, 253, 253, 1),
      duration: Duration(seconds: 10),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void mostrarSucessoOnline(BuildContext context) {
    const snackBar = SnackBar(
      content: Text(
        'Pedido gravado online com sucesso! Aguarde retorno do sistema.',
      ),
      dismissDirection: DismissDirection.horizontal,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(12),
      showCloseIcon: true,
      closeIconColor: Color.fromRGBO(253, 253, 253, 1),
      duration: Duration(seconds: 10),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void salvarPedidoRascunho(BuildContext context) {
    const snackBar = SnackBar(
      content: Text(
        'Rascunho de pedido salvo.',
      ),
      dismissDirection: DismissDirection.horizontal,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(12),
      showCloseIcon: true,
      closeIconColor: Color.fromRGBO(253, 253, 253, 1),
      duration: Duration(seconds: 10),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showSuccessOfflineDialog(BuildContext context) {
    const snackBar = SnackBar(
      content: Text(
        'Pedido gravado offline com sucesso.',
      ),
      dismissDirection: DismissDirection.horizontal,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(12),
      showCloseIcon: true,
      closeIconColor: Color.fromRGBO(253, 253, 253, 1),
      duration: Duration(seconds: 10),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showErrorOnlinneDialog(BuildContext context) {
    const snackBar = SnackBar(
      content: Text(
        'Ocorreu um erro ao salvar o pedido online',
      ),
      dismissDirection: DismissDirection.horizontal,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(12),
      showCloseIcon: true,
      closeIconColor: Color.fromRGBO(253, 253, 253, 1),
      duration: Duration(seconds: 10),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showErrorOfflineDialog(BuildContext context, dynamic error) {
    const snackBar = SnackBar(
      content: Text(
        'Ocorreu um erro ao salvar o pedido offline',
      ),
      dismissDirection: DismissDirection.horizontal,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(12),
      showCloseIcon: true,
      closeIconColor: Color.fromRGBO(253, 253, 253, 1),
      duration: Duration(seconds: 10),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showErrorGravaItens(BuildContext context) {
    const snackBar = SnackBar(
      content: Text(
        'Necessário adicionar ao menos 01 (um) item para finalizar o pedido.',
      ),
      dismissDirection: DismissDirection.horizontal,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(12),
      showCloseIcon: true,
      closeIconColor: Color.fromRGBO(253, 253, 253, 1),
      duration: Duration(seconds: 10),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showErrorAdicionaItens(BuildContext context) {
    const snackBar = SnackBar(
      content: Text(
        'Não há itens para gravar.',
      ),
      dismissDirection: DismissDirection.horizontal,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(12),
      showCloseIcon: true,
      closeIconColor: Color.fromRGBO(253, 253, 253, 1),
      duration: Duration(seconds: 10),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void descontoPorcentagemErro(BuildContext context) {
    const snackBar = SnackBar(
      content: Text(
        'O desconto não pode ultrapassar 100% do valor.',
      ),
      dismissDirection: DismissDirection.horizontal,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(12),
      showCloseIcon: true,
      closeIconColor: Color.fromRGBO(253, 253, 253, 1),
      duration: Duration(seconds: 10),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void descontoValorErro(BuildContext context) {
    const snackBar = SnackBar(
      content: Text(
        'O valor do desconto não deve ultrapassar o valor total do item selecionado.',
      ),
      dismissDirection: DismissDirection.horizontal,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(12),
      showCloseIcon: true,
      closeIconColor: Color.fromRGBO(253, 253, 253, 1),
      duration: Duration(seconds: 10),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showErrorDadosFaltando(
    BuildContext context,
    bool isClienteEmpty,
    bool isPagamentosEmpty,
  ) {
    if (isClienteEmpty || isPagamentosEmpty) {
      final String message = isClienteEmpty
          ? 'Selecione um cliente antes de prosseguir.'
          : 'Selecione pelo menos um método de pagamento.';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          dismissDirection: DismissDirection.horizontal,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(12),
          showCloseIcon: true,
          closeIconColor: const Color.fromRGBO(253, 253, 253, 1),
          duration: const Duration(seconds: 10),
        ),
      );
      return;
    }
  }
}
