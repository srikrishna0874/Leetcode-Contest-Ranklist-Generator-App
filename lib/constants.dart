import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

showLoadingIndicator(BuildContext context) {
  showDialog(
    useRootNavigator: true,
    context: context,
    barrierDismissible: false,
    builder: (context) => Center(
      child: LoadingAnimationWidget.twistingDots(
        leftDotColor: Theme.of(context).primaryColor,
        rightDotColor: const Color(0xFFEA3799),
        size: 40,
      ),
    ),
  );
}
