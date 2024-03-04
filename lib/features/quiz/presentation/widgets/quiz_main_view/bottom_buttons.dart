import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// TODO: clean this code
class BottomButtons extends StatelessWidget {
  final void Function() onNextButtonPressed;

  const BottomButtons({
    Key? key,
    required this.onNextButtonPressed,
  }) : super(key: key);

  // style this icons
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // whitespace
        const SizedBox(width: 16),

        // close button
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              // Functionality to execute when the button is tapped
            },

            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Icon(
                  CupertinoIcons.xmark,
                  color: Theme.of(context).highlightColor,
                ),
              ),
            ),
          ),
        ),

        // whitespace
        const SizedBox(width: 24),

        // next button
        Expanded(
          flex: 2,
          child: InkWell(
            onTap: onNextButtonPressed,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Icon(
                  CupertinoIcons.check_mark,
                  color: Theme.of(context).highlightColor,
                ),
              ),
            ),
          ),
        ),

        // whitespace
        const SizedBox(width: 16),
      ],
    );
  }
}
