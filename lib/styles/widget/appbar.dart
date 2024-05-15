import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function() onMenuPressed;

  const CustomAppBar({Key? key, required this.onMenuPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Renascer Da Esperança'),
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: onMenuPressed,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SettingsMenu extends StatelessWidget {
  final Function() onSettingSelected;

  const SettingsMenu({Key? key, required this.onSettingSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: const Text('Configuração 1'),
            onTap: () {
              onSettingSelected();
            },
          ),
          ListTile(
            title: const Text('Configuração 2'),
            onTap: () {
              onSettingSelected();
            },
          ),
        ],
      ),
    );
  }
}
