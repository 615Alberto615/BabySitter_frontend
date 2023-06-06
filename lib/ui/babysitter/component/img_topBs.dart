import 'package:flutter/material.dart';

class veri extends StatelessWidget {
  const veri({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15),
        Row(
          children: [
            const Spacer(),
            Expanded(
                flex: 8,
                child: Image.asset(
                  "assets/veri.png",
                  height: 256,
                )),
            const Spacer(),
          ],
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
