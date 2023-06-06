import 'package:flutter/material.dart';

class SignUpScreenTopImageChild extends StatelessWidget {
  const SignUpScreenTopImageChild({
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
                  "assets/bb.png",
                  height: 150,
                )),
            const Spacer(),
          ],
        ),
        SizedBox(height: 15),
      ],
    );
  }
}

class SignUpScreenTopImageMed extends StatelessWidget {
  const SignUpScreenTopImageMed({
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
                  "assets/med.png",
                  height: 200,
                )),
            const Spacer(),
          ],
        ),
        SizedBox(height: 15),
      ],
    );
  }
}

class SignUpScreenTopImageAct extends StatelessWidget {
  const SignUpScreenTopImageAct({
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
                  "assets/aa.png",
                  height: 200,
                )),
            const Spacer(),
          ],
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
