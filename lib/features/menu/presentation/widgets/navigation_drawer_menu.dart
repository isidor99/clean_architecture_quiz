import 'package:flutter/material.dart';

// TODO: implement drawer content, follow animations_app
class NavigationDrawerMenu extends StatelessWidget {
  const NavigationDrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // drawer width
    double width = MediaQuery.of(context).size.width * 3 / 4;

    // used radius
    Radius borderRadius = const Radius.circular(30);

    //
    return SafeArea(
      child: Container(
        width: width,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.only(
            topRight: borderRadius,
            bottomRight: borderRadius,
          ),
        ),
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              // user info in side bar

              // browse group title
              //const GroupTitle(title: 'Browse'),


              Text('AAA'),
              Text('BBB'),
              Text('CCC'),
              Text('DDD'),
            ],
          ),
        ),
      ),
    );
  }
}
