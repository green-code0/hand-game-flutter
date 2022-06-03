

import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

    
    int rndred = 0;
    int rndblue = 0;
    int rsred = 0;
    int rsblue = 0;
    int scred = 0;
    int scblue = 0;
    bool _istapped = false;

  Stream<int> _streamred() async* {

      for (var i = 0; i < 10; i++) {
            await Future<void>.delayed(const Duration(milliseconds: (70 - 5)));
            rndred = (Random().nextInt(3)+1);
            yield rndred;
      }
        rsred = rndred;
  }

  Stream<int> _streamblue() async* {

      for (var i = 0; i < 10; i++) {
            await Future<void>.delayed(const Duration(milliseconds: (70 - 5)));
            rndblue = (Random().nextInt(3)+1);
            yield rndblue;
      }
         rsblue = rndblue;
  }


  void score() {
    if (rsred == 1 && rsblue == 3 || rsred == 2 && rsblue == 1 || rsred == 3 && rsblue == 2) {
      scred++;
    } else if(rsred == rsblue){} else { scblue++; }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [

             StreamBuilder(
              initialData: 0,
              stream: _istapped == true ? _streamred() : null,
              builder: (context, AsyncSnapshot<int> snapshot) {
                   return (snapshot.data == 0 || snapshot.data == 1 || snapshot.data ==  2) ? Icon( snapshot.data == 0 ? Icons.question_mark_rounded : snapshot.data == 1 ? Icons.back_hand_rounded : snapshot.data == 2 ? Icons.cut_rounded : null , size: 80,color: Colors.red.shade400) : Image.asset("assets/fist.png" , width: 85, height: 81,color: Colors.red.shade400);
              },),

             
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                Center(child: Text("$scred", style: TextStyle(fontSize: 30, color: Colors.red.shade400),)),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: EdgeInsets.all(35), primary: Colors.white),
                    child: Text("Tap", style: TextStyle(fontSize: 30, color: Colors.black87)),
                    onPressed: () {
                      setState(() {
                      _istapped = true;
                      score();
                      });
                    },),


                  Center(child: Text("$scblue", style: TextStyle(fontSize: 30, color: Colors.blue.shade400),)),
                ],
              ),
             

             StreamBuilder(
              initialData: 0,
              stream: _istapped == true ? _streamblue() : null,
              builder: (context, AsyncSnapshot<int> snapshot) {
                  return (snapshot.data == 0 || snapshot.data == 1 || snapshot.data ==  2) ? Icon( snapshot.data == 0 ? Icons.question_mark_rounded : snapshot.data == 1 ? Icons.back_hand_rounded : snapshot.data == 2 ? Icons.cut_rounded : null , size: 80,color: Colors.blue.shade400) : Image.asset("assets/fist.png" , width: 85, height: 81,color: Colors.blue.shade400);  
              },),


           ],
         ),

      ),
    );
  }
}
