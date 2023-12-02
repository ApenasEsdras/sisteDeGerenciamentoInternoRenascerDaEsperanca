import 'package:flutter/material.dart';
import 'package:sistemarenascerdaesperanca/styles/colors_app.dart';

class CustomConfirmationDialog extends StatelessWidget {
  final String titulo;
  final String mensagem;
  final String primeiraOpcao;
  final IconData? iconePrimeiraOpcao;
  final VoidCallback sePrimeiraOpcaoClica;
  final String segundaOpcao;
  final IconData? iconeSegundaOpcao;
  final VoidCallback seSegundaOpcaoClica;

  const CustomConfirmationDialog({
    super.key,
    required this.titulo,
    required this.mensagem,
    required this.primeiraOpcao,
    this.iconePrimeiraOpcao,
    required this.sePrimeiraOpcaoClica,
    required this.segundaOpcao,
    this.iconeSegundaOpcao,
    required this.seSegundaOpcaoClica,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 360,
        child: ListView(
          shrinkWrap: true,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 18.0,
                  right: 18.0,
                  top: 24,
                  bottom: 24,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        titulo,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: ColorsApp.instance.CinzaEscuro,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        mensagem,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: ColorsApp.instance.CinzaEscuro,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: MaterialButton(
                    onPressed: sePrimeiraOpcaoClica,
                    color: ColorsApp.instance.CinzaMedio,
                    height: 60,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (iconePrimeiraOpcao != null)
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 8.0,
                              ),
                              child: Icon(
                                iconePrimeiraOpcao,
                                color: ColorsApp.instance.CinzaEscuro,
                              ),
                            ),
                          Text(
                            primeiraOpcao,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: ColorsApp.instance.CinzaEscuro,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    onPressed: seSegundaOpcaoClica,
                    color: ColorsApp.instance.Laranja,
                    height: 60,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10.0),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (iconeSegundaOpcao != null)
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 8.0,
                              ),
                              child: Icon(
                                iconeSegundaOpcao,
                                color: ColorsApp.instance.Branco,
                              ),
                            ),
                          Text(
                            segundaOpcao,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: ColorsApp.instance.Branco,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white,
      elevation: 8.0,
    );
  }
}
