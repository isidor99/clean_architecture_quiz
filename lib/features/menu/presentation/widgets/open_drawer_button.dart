import 'package:flutter/material.dart';
import 'package:quiz_app/core/utils/durations.dart' as d;
import 'package:rive/rive.dart';

import 'open_drawer_button/menu_button.dart';

class OpenDrawerButton extends StatefulWidget {
  final AnimationController animationController;
  final bool isSideBarOpen;
  final void Function() toggleSideBar;

  const OpenDrawerButton({
    Key? key,
    required this.animationController,
    required this.isSideBarOpen,
    required this.toggleSideBar,
  }) : super(key: key);

  @override
  State<OpenDrawerButton> createState() => _OpenDrawerButtonState();
}

class _OpenDrawerButtonState extends State<OpenDrawerButton> {
  late SMIBool isMenuOpenInput;

  // on button press callback
  void _onButtonPress() {
    // toggle menu state
    isMenuOpenInput.value = !isMenuOpenInput.value;

    if (widget.animationController.value == 0) {
      // if current animation controller's value is 0
      // then go forward
      widget.animationController.forward();
    } else {
      // else go backward
      widget.animationController.reverse();
    }

    // toggle navigation drawer state
    widget.toggleSideBar();
  }

  // on rive init callback
  void _onRiveInit(Artboard artBoard) {
    final controller = StateMachineController.fromArtboard(
      artBoard,
      'State Machine', // state machine name, define in rive editor
    );

    // add controller to art board
    artBoard.addController(controller!);

    // find input using controller
    isMenuOpenInput = controller.findInput<bool>('isOpen') as SMIBool;

    // set value
    isMenuOpenInput.value = true;
  }

  @override
  Widget build(BuildContext context) {
    // drawer width
    double width = MediaQuery.of(context).size.width / 2;

    // TODO: calculate left position
    return AnimatedPositioned(
      duration: d.Durations.menuAnimationsDurations,
      top: 16,
      left: widget.isSideBarOpen ? width : 16,
      curve: Curves.fastOutSlowIn,
      child: MenuButton(
        press: _onButtonPress,
        onRiveInit: _onRiveInit,
      ),
    );
  }
}
