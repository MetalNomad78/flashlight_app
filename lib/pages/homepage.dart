import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:torch_controller/torch_controller.dart';
import 'package:torch_light/torch_light.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isTorchOn = false;
  bool positive = false;
  var controller=TorchController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: ClipPath(
          clipper: _CustomClipper(),
          child: Container(
            color: Colors.grey[900],
            child: const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'TORCH APP',
                      style: TextStyle(
                    color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          color: Colors.grey[200],
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Positioned(
                top: 10,
                child: Visibility(
                  visible: !isTorchOn,
                  child: Image.asset('lib/off.png'),
                  replacement: Lottie.asset('lib/on.json'),
                ),
              ),
              const SizedBox(height: 30),
              Positioned(

                bottom: 10,
                child: AnimatedToggleSwitch<bool>.dual(
                  current: positive,
                  first: false,
                  second: true,
                  spacing: 50.0,
                  style: const ToggleStyle(
                    borderColor: Colors.transparent,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 1.5),
                      ),
                    ],
                  ),
                  borderWidth: 5.0,
                  height: 55,
                  onChanged: (b) {
                    controller.toggle();
                    isTorchOn=!isTorchOn;
                    positive=b;
                    setState(() {

                    });
                  },
                  styleBuilder: (b) =>
                      ToggleStyle(indicatorColor: b ? const Color(0xffff9500) : Colors.red),
                  iconBuilder: (value) => value
                      ? const Icon(Icons.flashlight_on)
                      : const Icon(Icons.flashlight_off),
                  textBuilder: (value) => value
                      ? const Center(child: Text('Torch On'))
                      : const Center(child: Text('Torch Off')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
class _CustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;

    var path = Path();

    path.lineTo(0, height - 50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
