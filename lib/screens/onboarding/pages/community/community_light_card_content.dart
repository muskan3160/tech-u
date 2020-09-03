import 'package:flutter/material.dart';

import 'package:Technovatives/constants.dart';
import 'package:Technovatives/screens/onboarding/widgets/icon_container.dart';

class CommunityLightCardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconContainer(
          icon: Icons.person,
          padding: kPaddingS,
        ),
        IconContainer(
          icon: Icons.mobile_screen_share,
          padding: kPaddingM,
        ),
        IconContainer(
          icon: Icons.add_shopping_cart,
          padding: kPaddingS,
        ),
      ],
    );
  }
}
