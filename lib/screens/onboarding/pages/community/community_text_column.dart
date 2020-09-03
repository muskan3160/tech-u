import 'package:flutter/material.dart';

import 'package:Technovatives/screens/onboarding/widgets/text_column.dart';

class CommunityTextColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextColumn(
      title: 'Scan',
      text:
          'Scan the QR code',
    );
  }
}
