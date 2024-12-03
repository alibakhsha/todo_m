import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_m/gen/assets.gen.dart';
import 'package:todo_m/view/home_screen.dart';

class FirstScreen extends StatelessWidget {
  void getStartedButtonHandler() {
    Get.offAll(HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            Assets.images.firstPageImage.path,
          ),
          Text(
            """To-Do List
Task Managment""",
            style: textTheme.labelLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 100,
          ),
          Container(
            width: size.width / 1.17,
            height: 54,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 95, 51, 225),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                )),
            child: InkWell(
              onTap: getStartedButtonHandler,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(" "),
                    Text("Let’s Start", style: textTheme.labelMedium),
                    ImageIcon(
                      AssetImage(Assets.images.arrowLeft.path),
                      size: 24,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
