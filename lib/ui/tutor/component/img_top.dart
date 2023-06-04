import 'package:flutter/material.dart';

class myfam extends StatelessWidget {
  const myfam({
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
                  "assets/ff.png",
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
