import 'package:flutter/material.dart';

class ThemedSnackbar extends StatelessWidget {
  const ThemedSnackbar({
    Key key,
    @required this.title,
  }) : assert(title != null), super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(
        title,
        style: Theme.of(context).textTheme.body1.copyWith(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.black,
            ),
      ),
    );
  }
}