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

class info extends StatelessWidget {
  const info({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5),
        Row(
          children: [
            const Spacer(),
            Expanded(
                flex: 8,
                child: Image.asset(
                  "assets/info.png",
                  height: 206,
                )),
            const Spacer(),
          ],
        ),
        SizedBox(height: 5),
      ],
    );
  }
}

class childs extends StatelessWidget {
  const childs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 45),
        Row(
          children: [
            const Spacer(),
            Expanded(
                flex: 8,
                child: Image.asset(
                  "assets/bb.png",
                  height: 186,
                )),
            const Spacer(),
          ],
        ),
        SizedBox(height: 45),
      ],
    );
  }
}

class rules extends StatelessWidget {
  const rules({
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
                  "assets/rule.png",
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

class tles extends StatelessWidget {
  const tles({
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
                  "assets/empf.png",
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
