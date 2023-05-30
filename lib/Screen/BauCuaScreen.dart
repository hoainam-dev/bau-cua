// import 'dart:math';
//
// import 'package:flutter/material.dart';
//
// class BauCuaScreen extends StatefulWidget {
//   @override
//   _BauCuaScreenState createState() => _BauCuaScreenState();
// }
//
// class _BauCuaScreenState extends State<BauCuaScreen> {
//   // List<String> _items = ['Bau', 'Cua', 'Tom', 'Ca', 'Ga', 'Nai'];
//   List<String> _items = ['bau.png', 'cua.png', 'tom.png', 'ca.png', 'ga.png', 'nai.png'];
//   String _selectedItem = 'Bau';
//   int _betAmount = 0;
//   int _totalCoins = 100;
//   Random _random = Random();
//
//   void _roll() {
//     setState(() {
//       _selectedItem = _items[_random.nextInt(_items.length)];
//       _totalCoins -= _betAmount;
//       if (_selectedItem == _items[0]) {
//         _totalCoins += _betAmount * 2;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Bầu Cua'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Đặt cược:',
//               style: TextStyle(fontSize: 20.0),
//             ),
//             DropdownButton<String>(
//               value: _selectedItem,
//               onChanged: (String? newValue) {
//                 setState(() {
//                   _selectedItem = newValue!;
//                 });
//               },
//               items: _items.map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//             ),
//
//             Text(
//               'Số tiền cược:',
//               style: TextStyle(fontSize: 20.0),
//             ),
//             Slider(
//               value: _betAmount.toDouble(),
//               min: 0,
//               max: _totalCoins.toDouble(),
//               divisions: _totalCoins,
//               onChanged: (double value) {
//                 setState(() {
//                   _betAmount = value.toInt();
//                 });
//               },
//             ),
//             Text(
//               'Số tiền hiện có: $_totalCoins',
//               style: TextStyle(fontSize: 20.0),
//             ),
//             ElevatedButton(
//               onPressed: _roll,
//               child: Text('Lắc'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'dart:math';

class DiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dice Roller'),
        ),
        body: DicePage(),
      ),
    );
  }
}

class DicePage extends StatefulWidget {
  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController1;
  late AnimationController _animationController2;
  late AnimationController _animationController3;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;
  List<int> diceNumbers = [1, 1, 1];

  @override
  void initState() {
    super.initState();
    _animationController1 = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _animationController2 = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _animationController3 = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _animation1 = Tween<double>(begin: 0, end: 2 * pi).animate(_animationController1)
      ..addListener(() {
        setState(() {});
      });
    _animation2 = Tween<double>(begin: 0, end: 2 * pi).animate(_animationController2)
      ..addListener(() {
        setState(() {});
      });
    _animation3 = Tween<double>(begin: 0, end: 2 * pi).animate(_animationController3)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _animationController1.dispose();
    _animationController2.dispose();
    _animationController3.dispose();
    super.dispose();
  }

  void rollDice() {
    setState(() {
      diceNumbers[0] = Random().nextInt(6) + 1;
      diceNumbers[1] = Random().nextInt(6) + 1;
      diceNumbers[2] = Random().nextInt(6) + 1;

      _animationController1.forward(from: 0);
      _animationController2.forward(from: 0);
      _animationController3.forward(from: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Transform.rotate(
                angle: _animation1.value,
                child: Image.asset(
                  'assets/dice${diceNumbers[0]}.png',
                  height: 100,
                  width: 100,
                ),
              ),
              SizedBox(width: 20),
              Transform.rotate(
                angle: _animation2.value,
                child: Image.asset(
                  'assets/dice${diceNumbers[1]}.png',
                  height: 100,
                  width: 100,
                ),
              ),
              SizedBox(width: 20),
              Transform.rotate(
                angle: _animation3.value,
                child: Image.asset(
                  'assets/dice${diceNumbers[2]}.png',
                  height: 100,
                  width: 100,
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          RaisedButton(
            onPressed: rollDice,
            child: Text(
              'Roll Dice',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}