import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GreekVineBorderCard extends StatelessWidget {
  final Widget body;

  const GreekVineBorderCard({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate padding based on the size of the body or parent constraints
        final double horizontalPadding =
            constraints.maxWidth * 0.03; // 10% of width
        final double verticalPadding =
            constraints.maxHeight * 0.03; // 5% of height

        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: body,
            ),
            Positioned.fill(
              child: IgnorePointer(
                child: SvgPicture.asset(
                  'card/vine_border.svg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
