// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:quiz/constant/const.dart';
import 'package:quiz/constant/const_list.dart';
import 'package:quiz/test_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Start Word Quiz"),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.pink, Colors.amber],
          ),
          image: DecorationImage(image: AssetImage('assets/3.jpg'), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      children: [
                        selectLevel(context, index + 1),
                        sizedbox40,
                      ],
                    );
                  }
                  return selectLevel(context, index + 1);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget selectLevel(
    BuildContext context,
    int index,
  ) {
    var level = lists[index];
    return Padding(
      padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TestPage(
                answer: level[2],
                title: level[3],
                answersList: level[0],
                options: level[1],
                pic1: level[4],
                pic2: level[5],
                pic3: level[6],
                pic4: level[7],
              ),
            ),
          );
        },
        child: Align(
          alignment: index % 2 == 0 ? Alignment.centerLeft : Alignment.centerRight,
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(offset: Offset(0.5, 2), color: Colors.black, blurRadius: 4)],
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Center(
              child: Text("$index"),
            ),
          ),
        ),
      ),
    );
  }
}
