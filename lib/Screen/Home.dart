import 'dart:math';

import 'package:baucua/Screen/Auth/login_google.dart';
import 'package:baucua/Screen/Profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//map item {keys: name, value: coins}
Map<String, double> mapItems = {
  'nai': 0,
  'bau': 0,
  'ga': 0,
  'ca': 0,
  'cua': 0,
  'tom': 0
};

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final User? user = FirebaseAuth.instance.currentUser;

  late List<String> randomList = [];

  Map<String, double> _mapBet = {'': 0};

  final Random _random = Random();

  //declare randomIndex
  late int _randomIndex1;
  late int _randomIndex2;
  late int _randomIndex3;

  //declare randomItem
  late String _randomItem1;
  late String _randomItem2;
  late String _randomItem3;

  //Init
  @override
  void initState() {
    //set state init index for dice 1,2,3
    _randomIndex1 = _random.nextInt(6);
    _randomIndex2 = _random.nextInt(6);
    _randomIndex3 = _random.nextInt(6);

    //set state init item for dice 1,2,3
    _randomItem1 = mapItems.keys.toList()[_randomIndex1];
    _randomItem2 = mapItems.keys.toList()[_randomIndex2];
    _randomItem3 = mapItems.keys.toList()[_randomIndex3];
    // TODO: implement initState
    super.initState();
  }

  TextEditingController _betController =
      new TextEditingController(); //coins bet ipnut
  double _betAmountTotal = 0; //coins bet total
  double _totalCoins = 100; //coins total

  //recursive function to random according to the rule
  int _randomRecursion(int randomNum) {
    if (randomNum > 5) //recursive exit condition
    {
      randomNum = randomNum - 6;
      return _randomRecursion(randomNum);
    }
    return randomNum;
  }

  void _roll() {
    setState(() {
      //set index for dice3 by rule
      _randomIndex3 = _randomIndex1 + _randomIndex2 + _randomIndex3 + 1;
      _randomRecursion(_randomIndex3);
      _randomItem3 = mapItems.keys.toList()[_randomRecursion(_randomIndex3)];

      //random index for dice1 and dice2
      _randomIndex1 = _random.nextInt(mapItems.length);
      _randomIndex2 = _random.nextInt(mapItems.length);

      //random index for dice1 and dice2
      _randomItem1 = mapItems.keys.toList()[_randomIndex1];
      _randomItem2 = mapItems.keys.toList()[_randomIndex2];

      //clear old list and add new item into list before random
      randomList.clear();
      randomList.add(_randomItem1);
      randomList.add(_randomItem2);
      randomList.add(_randomItem3);

      //check bet
      for (var randomItem in randomList) {
        _mapBet.forEach((i, value) {
          if (randomItem == i) {
            _totalCoins += value * 2;
          }
        });
      }

      //set map to default
      _mapBet.clear();
      _betAmountTotal = 0;
      mapItems = {'nai': 0, 'bau': 0, 'ga': 0, 'ca': 0, 'cua': 0, 'tom': 0};
    });
  }

  //Function show widget to input bet
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
                      double coinsBet = 0;
                      if (_mapBet[item] != null) {
                        coinsBet = _mapBet[item]!;
                      }
                      _mapBet[item] = double.parse(_bet) + coinsBet;
                      setState(() {
                        mapItems[item] = double.parse(_bet) + coinsBet;
                      });
                      _totalCoins -= double.parse(_bet);
                      _betAmountTotal += double.parse(_bet);
                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'Số dư tài khoản không đủ. Vui lòng nạp thêm tiền.',
                              style: TextStyle(color: Colors.red))));
                      Navigator.of(context).pop();
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
                //check haven been login
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(" Wellcome ${user!.email}",
                        style: const TextStyle(fontSize: 16));
                  } else
                    return Text("");
                }),
            const SizedBox(height: 10),
            Text("Số dư: ${_totalCoins}"),
            const SizedBox(height: 20),
            Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(mapItems.length, (index) {
                      return Center(
                          child: Container(
                              child: ConstrainedBox(
                                  constraints: const BoxConstraints.expand(),
                                  child: TextButton(
                                    onPressed: () {
                                      bet(mapItems.keys.toList()[index]);
                                    },
                                    child: Column(
                                      children: [
                                        Image.asset(
                                            'assets/img/${mapItems.keys.toList()[index]}.png',
                                            height: 90,
                                            width: 110),
                                        Text(
                                            "${mapItems.values.toList()[index]}")
                                      ],
                                    ),
                                  ))));
                    }))),
            Text("Tổng tiền cược: ${_betAmountTotal}",
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            const Text("Kết quả lắc", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            randomList.length > 0
                ? Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    child: GridView.count(
                        crossAxisCount: 3,
                        children: List.generate(randomList.length, (index) {
                          return Image.asset(
                              'assets/img/${randomList[index]}.png',
                              height: 90,
                              width: 90);
                        })))
                : Container(),
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
