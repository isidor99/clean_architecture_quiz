import 'package:flutter/material.dart';
import 'package:quiz_app/core/utils/durations.dart' as d;

import '../widgets/navigation_drawer_menu.dart';
import '../widgets/open_drawer_button.dart';
import '../widgets/page_container.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with TickerProviderStateMixin {
  // this variable holds information about drawer state
  final ValueNotifier<bool> _drawerOpenNotifier = ValueNotifier<bool>(false);

  // this controller is used for animations that are displayed
  // when opening the drawer
  AnimationController? _openDrawerAnimationController;

  // animate the scaling from 1.0 to 0.8
  Animation<double>? _scaleAnimation;

  // animate the transition from 0 to 1
  Animation<double>? _zeroToOneTransitionAnimation;

  // change state function
  // this type of state changing is used by animation controllers
  void _changeState() {
    setState(() {});
  }

  // toggle side bar callback
  void _toggleSideBar() {
    _drawerOpenNotifier.value = !_drawerOpenNotifier.value;
  }

  @override
  void initState() {
    super.initState();

    // initialize open drawer controller
    _openDrawerAnimationController = AnimationController(
      vsync: this,
      duration: d.Durations.menuAnimationsDurations,
    );

    // change the state after each activation of the controller
    _openDrawerAnimationController!.addListener(_changeState);

    // initialize animations which use _openDrawerAnimationController
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(
        parent: _openDrawerAnimationController!,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _zeroToOneTransitionAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _openDrawerAnimationController!,
        curve: Curves.fastOutSlowIn,
      ),
    );
  }

  @override
  void dispose() {
    // destroy animation controller
    _openDrawerAnimationController!.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // get size from MediaQuery
    Size size = MediaQuery.of(context).size;

    // drawer width
    double width = size.width * 3 / 4;

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColorLight,
      body: Stack(
        children: [
          // navigation drawer
          ValueListenableBuilder(
            valueListenable: _drawerOpenNotifier,
            builder: (_, value, __) => AnimatedPositioned(
              top: 0,
              left: value ? 0 : -width,
              width: width,
              height: size.height,
              duration: d.Durations.menuAnimationsDurations,
              curve: Curves.fastOutSlowIn,
              child: const NavigationDrawerMenu(),
            ),
          ),

          // page container
          PageContainer(
            zeroToOneTransitionAnimation: _zeroToOneTransitionAnimation!,
            scaleAnimation: _scaleAnimation!,
          ),

          // menu button
          ValueListenableBuilder(
            valueListenable: _drawerOpenNotifier,
            builder: (_, value, __) => OpenDrawerButton(
              animationController: _openDrawerAnimationController!,
              isSideBarOpen: value,
              toggleSideBar: _toggleSideBar,
            ),
          ),
        ],
      ),
    );
  }
}
