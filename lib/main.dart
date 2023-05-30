import 'package:baucua/Screen/BauCuaScreen.dart';
import 'package:baucua/Screen/Home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NAM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Home(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'dart:math';
//
// void main() {
//   runApp(DiceApp());
// }
//
// class DiceApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Dice Roller'),
//         ),
//         body: DicePage(),
//       ),
//     );
//   }
// }
//
// class DicePage extends StatefulWidget {
//   @override
//   _DicePageState createState() => _DicePageState();
// }
//
// class _DicePageState extends State<DicePage> with TickerProviderStateMixin {
//   late AnimationController _animationController1;
//   late AnimationController _animationController2;
//   late AnimationController _animationController3;
//   late Animation<double> _animation1;
//   late Animation<double> _animation2;
//   late Animation<double> _animation3;
//   List<int> diceNumbers = [1, 1, 1];
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController1 = AnimationController(
//       duration: Duration(milliseconds: 500),
//       vsync: this,
//     );
//     _animationController2 = AnimationController(
//       duration: Duration(milliseconds: 500),
//       vsync: this,
//     );
//     _animationController3 = AnimationController(
//       duration: Duration(milliseconds: 500),
//       vsync: this,
//     );
//     _animation1 = Tween<double>(begin: 0, end: 2 * pi).animate(
//       CurvedAnimation(
//         parent: _animationController1,
//         curve: Interval(0, 0.33, curve: Curves.easeInOut),
//       ),
//     )..addListener(() {
//       setState(() {});
//     });
//     _animation2 = Tween<double>(begin: 0, end: 2 * pi).animate(
//       CurvedAnimation(
//         parent: _animationController2,
//         curve: Interval(0.33, 0.66, curve: Curves.easeInOut),
//       ),
//     )..addListener(() {
//       setState(() {});
//     });
//     _animation3 = Tween<double>(begin: 0, end: 2 * pi).animate(
//       CurvedAnimation(
//         parent: _animationController3,
//         curve: Interval(0.66, 1, curve: Curves.easeInOut),
//       ),
//     )..addListener(() {
//       setState(() {});
//     });
//   }
//
//   @override
//   void dispose() {
//     _animationController1.dispose();
//     _animationController2.dispose();
//     _animationController3.dispose();
//     super.dispose();
//   }
//
//   void rollDice() {
//     setState(() {
//       diceNumbers[0] = Random().nextInt(6) + 1;
//       diceNumbers[1] = Random().nextInt(6) + 1;
//       diceNumbers[2] = Random().nextInt(6) + 1;
//
//       _animationController1.forward(from: 0);
//       _animationController2.forward(from: 0);
//       _animationController3.forward(from: 0);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               AnimatedBuilder(
//                 animation: _animation1,
//                 builder: (BuildContext context, Widget? child) {
//                   return Transform.rotate(
//                     angle: _animation1.value,
//                     child: Image.asset(
//                       'assets/img/dice${diceNumbers[0]}.png',
//                       height: 100,
//                       width: 100,
//                     ),
//                   );
//                 },
//               ),
//               SizedBox(width: 20),
//               AnimatedBuilder(
//                 animation: _animation2,
//                 builder: (BuildContext context, Widget? child) {
//                   return Transform.rotate(
//                     angle: _animation2.value,
//                     child: Image.asset(
//                       'assets/img/dice${diceNumbers[1]}.png',
//                       height: 100,
//                       width: 100,
//                     ),
//                   );
//                 },
//               ),
//               SizedBox(width: 20),
//               AnimatedBuilder(
//                 animation: _animation3,
//                 builder: (BuildContext context, Widget? child) {
//                   return Transform.rotate(
//                     angle: _animation3.value,
//                     child: Image.asset(
//                       'assets/img/dice${diceNumbers[2]}.png',
//                       height: 100,
//                       width: 100,
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//           SizedBox(height: 30),
//           RaisedButton(
//             onPressed: rollDice,
//             child: Text(
//               'Roll Dice',
//               style: TextStyle(fontSize: 20),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }