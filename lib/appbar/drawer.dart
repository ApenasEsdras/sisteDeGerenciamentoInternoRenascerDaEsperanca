import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../styles/colors_app.dart';
import '../helpers/custom_confirmation_dialog.dart';
import '../widgets/home_page.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({
    Key? key,
  }) : super(key: key);

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorsApp.instance.Branco,
      child: Column(
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountEmail: Text('InnovaroADM@gmail.com'),
            accountName: Text('innovaroADM'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/logoHome.png'),
              backgroundColor: Colors.transparent,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: const <Widget>[
                // ListTile(
                //   leading: const Icon(Icons.person),
                //   title: const Text('Minha conta'),
                //   onTap: () {
                //     Navigator.pop(context);
                //     //Navegar para outra página
                //   },
                // ),
                // ListTile(
                //   leading: const Icon(Icons.person),
                //   title: const Text('Clientes'),
                //   onTap: () {
                //     Navigator.pop(context);
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => const Clientes(),
                //       ),
                //     );
                //     //Navegar para outra página
                //   },
                // ),
                // ListTile(
                //   leading: const Icon(Icons.shopping_basket),
                //   title: const Text('produtos'),
                //   onTap: () {
                //     Navigator.pop(context);
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => const ProductsPage(),
                //       ),
                //     );
                //   },
                // ),
                             ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
              bottom: 15,
            ), // Espaçamento de 15 pixels
            child: SizedBox(
              width: 150,
              height: 40,
              child: ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomConfirmationDialog(
                        titulo: 'Sair do perfil de usuário?',
                        mensagem: 'Sua sessão será encerrada.',
                        sePrimeiraOpcaoClica: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        primeiraOpcao: 'Não',
                        iconePrimeiraOpcao: Icons.close,
                        seSegundaOpcaoClica: () {
                          Navigator.of(context, rootNavigator: true).pop();
                          signUserOut();
                        },
                        iconeSegundaOpcao: Icons.check,
                        segundaOpcao: 'Sim',
                      );
                    },
                  );
                },
                icon: const Icon(Icons.exit_to_app),
                label: const Text('Sair'),
                style: const ButtonStyle(
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
