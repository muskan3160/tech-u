import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final Color color;
  final double size;

  const Logo({
    @required this.color,
    @required this.size,
  })  : assert(color != null),
        assert(size != null);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / 4,
      child: ImageIcon(
        AssetImage("assets/images/logo.jpg"),
        color: color,
        size: size,
      ),
    );
  }
}
