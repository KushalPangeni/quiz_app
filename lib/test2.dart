import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ImageTest extends StatefulWidget {
  const ImageTest({super.key});

  @override
  State<ImageTest> createState() => _ImageTestState();
}

class _ImageTestState extends State<ImageTest> {
  final controller = ConfettiController(duration: const Duration(seconds: 5));

  bool anyImageIsBigger = false;
  bool sizeSmall = true;
  String biggerImage = '';

  @override
  void initState() {
    super.initState();
    controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.amber[100],
          appBar: AppBar(title: const Text("Quiz")),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Container(
                    color: Colors.amber,
                    height: 50,
                    width: 50,
                    child: ConfettiWidget(
                      numberOfParticles: 50,
                      confettiController: controller,
                      // shouldLoop: true,
                      blastDirection: -pi / 2,
                    ))),
            // child: Container(
            //   child: anyImageIsBigger
            //       ? biggerImageContainer()
            //       : GridView.count(
            //           childAspectRatio: 1.2,
            //           crossAxisSpacing: 5,
            //           mainAxisSpacing: 5,
            //           crossAxisCount: 2,
            //           children: [
            //             photo1(
            //                 'https://images.pexels.com/photos/14111067/pexels-photo-14111067.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
            //             photo1(
            //                 'https://images.pexels.com/photos/2922277/pexels-photo-2922277.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
            //             photo1(
            //                 'https://images.pexels.com/photos/976870/pexels-photo-976870.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
            //             photo1(
            //                 'https://images.pexels.com/photos/792223/pexels-photo-792223.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
            //           ],
            //         ),
            // ),
          ),
        ),
      ],
    );
  }

  Widget biggerImageContainer() {
    return InkWell(
      onTap: () {
        setState(() {
          biggerImage = '';
          anyImageIsBigger = false;
        });
      },
      child: anyImageIsBigger
          ? Container(
              height: MediaQuery.sizeOf(context).height / 2.5,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amber,
                  image: DecorationImage(image: NetworkImage(biggerImage), fit: BoxFit.cover),
                  border: Border.all(color: Colors.black, width: 4)),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.amber),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        biggerImage.split('?')[0],
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox(),
    );
  }

  Widget photo1(String imgPath) {
    return InkWell(
      onTap: () {
        setState(() {
          anyImageIsBigger = true;
          biggerImage = imgPath;
          // }
        });
      },
      child: Container(
        height: MediaQuery.sizeOf(context).height / 5,
        width: MediaQuery.sizeOf(context).width / 2.2,
        decoration: BoxDecoration(
            color: Colors.amber,
            border: Border.all(color: Colors.black, width: 5),
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(image: NetworkImage(imgPath), fit: BoxFit.cover)),
      ),
    );
  }
}
