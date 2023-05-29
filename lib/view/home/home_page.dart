import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> numbers = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    0,
  ];

  String inputText = "";
  List<bool> actives = [false, false, false, false];
  List<bool> clears = [false, false, false, false];
  List<int> values = [1, 2, 2, 1];
  int currentIndex = 0;
  final pinCode = "1234";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "PinCode Page",
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Center(
            child: Text(
              "PIN kod o'rnatish",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
              flex: 1,
              child: Center(
                child: Container(
                  height: 100,
                  child: Column(
                    children: [
                      const Text("Quyida PIN kodni kiriting va uni tasdiqlang"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < actives.length; i++)
                            PasswordBurning(
                              clear: clears[i],
                              active: actives[i],
                              value: values[i],
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(
              flex: 3,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.7 / 0.6, crossAxisCount: 3),
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.all(4.0),
                  width: 50,
                  height: 50,
                  child: index == 9
                      ? const SizedBox()
                      : Center(
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: index == 9
                                        ? Colors.black
                                        : const Color(0xffE4E4E4)),
                                borderRadius: BorderRadius.circular(25)),
                            child: MaterialButton(
                                onPressed: () {
                                  if (index == 11) {
                                    if (inputText.isNotEmpty) {
                                      inputText = inputText.substring(
                                          0, inputText.length - 1);
                                      clears =
                                          clears.map((e) => false).toList();
                                      currentIndex--;
                                    } else {
                                      inputText = "";
                                    }
                                    if (currentIndex >= 0) {
                                      setState(() {
                                        clears[currentIndex] = true;
                                        actives[currentIndex] = false;
                                      });
                                    } else {
                                      currentIndex = 0;
                                    }
                                    return;
                                  } else {
                                    inputText +=
                                        numbers[index == 10 ? index - 1 : index]
                                            .toString();
                                    if (inputText.length == 4) {
                                      setState(() {
                                        clears =
                                            clears.map((e) => true).toList();
                                        actives =
                                            actives.map((e) => false).toList();
                                      });
                                      if (inputText == pinCode) {
                                        print("seccess");
                                      } else {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return const Center(child: Text("Password is incorrect"));
                                          },
                                        );
                                       
                                      }
                                      inputText = "";
                                      currentIndex = 0;
                                      return;
                                    }
                                    clears = clears.map((e) => false).toList();
                                    setState(() {
                                      actives[currentIndex] = true;
                                      currentIndex++;
                                    });
                                  }
                                },
                                minWidth: 50,
                                height: 50,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: index == 11
                                    ? const Icon(
                                        Icons.backspace_outlined,
                                        color: Colors.black,
                                      )
                                    : Text(
                                        "${numbers[index == 10 ? index - 1 : index]}",
                                        style: const TextStyle(
                                            fontSize: 25,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700),
                                      )),
                          ),
                        ),
                ),
                itemCount: 12,
              )),
        ],
      ),
    );
  }
}

class PasswordBurning extends StatefulWidget {
  final bool clear;
  final value;
  final active;
  const PasswordBurning(
      {super.key, this.clear = false, this.active = false, this.value});

  @override
  State<PasswordBurning> createState() => _PasswordBurningState();
}

class _PasswordBurningState extends State<PasswordBurning>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.clear) {
      animationController!.forward(from: 0);
    }
    return AnimatedBuilder(
      animation: animationController!,
      builder: (context, child) {
        return Container(
            margin: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: widget.active
                            ? const Color(0xff212640)
                            : const Color(0xffE4E4E4)),
                    color:
                        widget.active ? const Color(0xff212640) : Colors.white,
                  ),
                ),
              ],
            ));
      },
    );
  }
}
