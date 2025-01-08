import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function() onMenuPressed;

  const CustomAppBar({super.key, required this.onMenuPressed, required bool showFilterIcon, required Text leftContent});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Renascer Da Esperança'),
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: onMenuPressed,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SettingsMenu extends StatelessWidget {
  final Function() onSettingSelected;

  const SettingsMenu({super.key, required this.onSettingSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
