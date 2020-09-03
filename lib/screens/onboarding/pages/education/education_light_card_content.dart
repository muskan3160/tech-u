import 'package:flutter/material.dart';

import 'package:Technovatives/constants.dart';
import 'package:Technovatives/screens/onboarding/widgets/icon_container.dart';

class EducationLightCardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconContainer(
          icon: Icons.shopping_cart,
          padding: kPaddingS,
        ),
        IconContainer(
          icon: Icons.attach_money,
          padding: kPaddingM,
        ),
        IconContainer(
          icon: Icons.check_circle,
          padding: kPaddingS,
        ),
      ],
    );
  }
}
