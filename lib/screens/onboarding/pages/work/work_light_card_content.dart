import 'package:flutter/material.dart';

import 'package:Technovatives/constants.dart';
import 'package:Technovatives/screens/onboarding/widgets/icon_container.dart';

class WorkLightCardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconContainer(
          icon: Icons.directions_run,
          padding: kPaddingS,
        ),
        IconContainer(
          icon: Icons.directions_transit,
          padding: kPaddingM,
        ),
        IconContainer(
          icon: Icons.store_mall_directory,
          padding: kPaddingS,
        ),
      ],
    );
  }
}
