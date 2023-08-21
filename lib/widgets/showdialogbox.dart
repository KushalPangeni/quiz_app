import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

Future<dynamic> showWinDialog(BuildContext context) {
  final controller = ConfettiController(duration: const Duration(seconds: 5));
  controller.play();
  return showDialog(
      context: context,
      builder: (context) {
        return Stack(
          children: [
            AlertDialog(
              backgroundColor: Colors.transparent,
              title: Container(
                decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(12)),
                height: 300,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Congratulations",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("You Won"),
                  ],
                ),
              ),
              elevation: 10,
            ),
            Positioned(
              top: 200,
              left: MediaQuery.sizeOf(context).width / 2,
              child: ConfettiWidget(
                numberOfParticles: 50,
                confettiController: controller,
                // shouldLoop: true,
                blastDirection: -pi / 2,
              ),
            )
          ],
        );
      });
}
