import 'dart:math';

import 'package:baucua/Screen/Profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final User? user = FirebaseAuth.instance.currentUser;

  //map item
  Map<String, double> _mapItems = {
    'nai': 0,
    'bau': 0,
    'ga': 0,
    'ca': 0,
    'cua': 0,
    'tom': 0
  };


  List<String> _randomItems = [
    'nai',
    'nai',
    'nai',
  ];

  Map<String, double> _mapBet = {'': 0};

  String _randomItem1 = 'nai';
  String _randomItem2 = 'nai';
  String _randomItem3 = 'nai';

  TextEditingController _betController = new TextEditingController();
  double _betAmounttotal = 0;
  double _totalCoins = 100;

  int _randomNum = 0;

  Random _random = Random();

  void _randomRecursion(int randomNum){
    if (randomNum%6<6) // điều kiện dừng
        {
      _randomRecursion(randomNum);
    }
    randomNum = randomNum%6;
  }

  void _roll() {
    setState(() {
      //random khong theo quy luat
      _randomItem1 = _mapItems.keys.toList()[_random.nextInt(_mapItems.length)];
      _randomItem2 = _mapItems.keys.toList()[_random.nextInt(_mapItems.length)];

      //random theo quy luat


      _randomItem3 = _mapItems.keys.toList()[_random.nextInt(_mapItems.length)];

      _randomItems.clear();
      _randomItems.add(_randomItem1);
      _randomItems.add(_randomItem2);
      _randomItems.add(_randomItem3);

      for (var randomItem in _randomItems) {
        _mapBet.forEach((i, value) {
          if (randomItem == i) {
            _totalCoins += value * 2;
          }
        });
      }
      //set map to default
      _mapBet.clear();
      _betAmounttotal = 0;
      _mapItems = {
        'nai': 0,
        'bau': 0,
        'ga': 0,
        'ca': 0,
        'cua': 0,
        'tom': 0
      };
    });
  }

  bet(String item) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _betController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Số tiền cược'),
                ),
                ElevatedButton(
                  child: const Text('Cược'),
                  onPressed: () async {
                    final String _bet = _betController.text;
                    if (_bet != null && double.parse(_bet) <= _totalCoins) {
                      _mapBet[item] = double.parse(_bet);
                      setState(() {
                        _mapItems[item] = double.parse(_bet);
                      });
                      _totalCoins -= double.parse(_bet);
                      _betAmounttotal += double.parse(_bet);
                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'Số dư tài khoản không đủ. Vui lòng nạp thêm tiền.',
                              style: TextStyle(color: Colors.red))));
                      // Navigator.of(context).pop();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => super.widget));
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
              const Text("Bau Cua"),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileWidget()));
                  },
                  icon: const Icon(Icons.account_circle))
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(" Wellcome ${user!.email}", style: const TextStyle(fontSize: 16));
                  } else
                    return Text("");
                }),
            const SizedBox(height: 20),
            Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(_mapItems.length, (index) {
                      return Center(
                          child: Container(
                              child: ConstrainedBox(
                                  constraints: const BoxConstraints.expand(),
                                  child: FlatButton(
                                    onPressed: () {
                                      bet(_mapItems.keys.toList()[index]);
                                    },
                                    child: Column(
                                      children: [
                                        Image.asset(
                                            'assets/img/${_mapItems.keys.toList()[index]}.png',
                                            height: 110,
                                            width: 110),
                                        Text(
                                            "${_mapItems.values.toList()[index]}")
                                      ],
                                    ),
                                  ))));
                    }))),
            Text("Tổng tiền cược: ${_betAmounttotal}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            const Text("Kết quả lắc", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(_randomItems.length, (index) {
                      return Image.asset('assets/img/${_randomItems[index]}.png',
                          height: 90, width: 90);
                    }))),
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: _roll,
                      child: const Text('Lắc'),
                    ),
                  ],
                )),
          ],
        )));
  }
}
