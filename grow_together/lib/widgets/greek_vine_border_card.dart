import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GreekVineBorderCard extends StatelessWidget {
  final Widget body;

  const GreekVineBorderCard({Key? key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IntrinsicHeight(
          child: IntrinsicWidth(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(60.0, 20.0, 60.0, 20.0),
                  child: body,
                ),
                Positioned.fill(
                  child: SvgPicture.asset(
                    'card/vine_border.svg',
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
