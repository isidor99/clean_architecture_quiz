import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MenuButton extends StatelessWidget {
  final VoidCallback press;
  final ValueChanged<Artboard> onRiveInit;

  const MenuButton({super.key, required this.press, required this.onRiveInit});

  // TODO: style this button
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: press,
        child: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 3),
                blurRadius: 8,
              ),
            ],
          ),
          child: RiveAnimation.asset(
            'assets/rive_assets/menu/open_drawer_button.riv',
            onInit: onRiveInit,
          ),
        ),
      ),
    );
  }
}
