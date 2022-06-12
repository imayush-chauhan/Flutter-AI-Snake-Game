import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int sp = 24;

  int? x;

  bool start = false;

  @override
  void initState() {
    super.initState();
    generateRandom();
  }

  move(){

    if(x! > sp){


      if((x!~/10).toInt() > (sp~/10).toInt()){

        sp = sp + 10;

        setState(() {});

        print("Down");

        if(x != sp){
          Future.delayed(Duration(milliseconds: 300),(){
            move();
          });
        }else{
          setState(() {});
          print("AI wins");
          generateRandom();
        }

      } else {


        if(x! >= sp){

          sp++;

          setState(() {});
          print("Right");

          if(x != sp){
            Future.delayed(Duration(milliseconds: 300),(){
              move();
            });
          }else{
            print("AI wins");
            generateRandom();
          }


        }else{

          sp--;

          setState(() {});

          print("Left");

          if(x != sp){
            Future.delayed(Duration(milliseconds: 300),(){
              move();
            });
          }else{
            print("AI wins");
            generateRandom();
          }


        }

      }

    }else{

      if((sp~/10).toInt() > (x!~/10).toInt()){
        sp = sp - 10;
        setState(() {});
        print("Up");
        if(x != sp){
          Future.delayed(Duration(milliseconds: 300),(){
            setState(() {});
            move();
          });
        }else{
          print("AI wins");
          generateRandom();
        }
      }else{
        sp = sp - 1;
        setState(() {});
        print("Left");
        if(x != sp){
          Future.delayed(Duration(milliseconds: 300),(){
            setState(() {});
            move();
          });
        }else{
          print("AI wins");
          generateRandom();
        }
      }
    }

  }

  var rng = Random();

  generateRandom(){
    x = rng.nextInt(100);
    if(x == sp){
      generateRandom();
    }
    if(start == true){
      move();
    }
    start = true;
    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    double mediaQH = MediaQuery.of(context).size.height;
    double mediaQW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("AI Snake Game"),
        centerTitle: true,
      ),
      body: Container(
        height: mediaQH,
        width: mediaQW,
        color: Colors.white70,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: mediaQW*0.6,
              width: mediaQW*0.6,

              child: GridView.builder(
                itemCount: 100,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 10,
                ),
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(1),
                    child: Container(
                      decoration: BoxDecoration(
                        color: index == x ? Colors.green :
                        index == sp ? Colors.red : Colors.white,
                        border: Border.all(color: Colors.black),
                      ),
                    ),
                  );
                },
              ),
            ),

            GestureDetector(
              onTap: (){
                if(start == true){
                  move();
                }
              },
              child: Container(
                height: mediaQH*0.05,
                width: mediaQW*0.125,
                decoration: BoxDecoration(
                  color: start == true ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
                alignment: Alignment.center,
                child: Text("Start",style: TextStyle(
                  color: Colors.white,
                ),),
              ),
            )

          ],
        ),
      ),
    );
  }
}
