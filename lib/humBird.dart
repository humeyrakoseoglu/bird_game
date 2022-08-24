import 'package:flutter/cupertino.dart';

class HumBird extends StatelessWidget {
  const HumBird({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child: Image.asset('images/bird2.png'),
    );
  }
}
