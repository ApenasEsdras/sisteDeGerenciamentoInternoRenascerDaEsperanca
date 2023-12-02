// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';

import '../../styles/colors_app.dart';

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
  bool isConnected = true;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(size: 35, color: ColorsApp.instance.Laranja),
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
          Row(
            children: [
              Icon(
                size: 35,
                isConnected ? null : Icons.wifi_off,
                color: ColorsApp.instance.Laranja,
              ),
              if (widget.showFilterIcon)
                Container(
                  alignment: Alignment.center,
                  child: IconButton(
                    padding: const EdgeInsets.all(0),
                    constraints: const BoxConstraints(),
                    alignment: Alignment.center,
                    splashRadius: 40,
                    icon: Icon(
                      size: 35,
                      Icons.filter_alt_outlined,
                      color: ColorsApp.instance.Laranja,
                    ),
                    onPressed: () {},
                  ),
                ),
              if (!widget.showFilterIcon)
                const SizedBox(
                  width: 40,
                )
            ],
          ),
        ],
      ),
      backgroundColor: ColorsApp.instance.Branco,
    );
  }
}
