// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../styles/colors_app.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool showFilterIcon;
  final Widget? leftContent;

  const CustomAppBar({Key? key, required this.showFilterIcon, this.leftContent})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(size: 35, color: ColorsApp.instance.CinzaMedio2),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  child: widget.leftContent ??
                      Container(), // Substituir a imagem pelo widget passado ou Container vazio
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: ColorsApp.instance.Branco,
    );
  }
}
