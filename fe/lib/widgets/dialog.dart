import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:nice_buttons/nice_buttons.dart';
import '../style.dart' as style;

Future<dynamic> failDialog1(failTitle, failDescription) {
  return AwesomeDialog(
    context: Get.context!,
    width: 400,
    animType: AnimType.scale,
    dialogType: DialogType.noHeader,
    autoHide: const Duration(seconds: 3),
    title: failTitle,
    dismissOnTouchOutside: false,
    titleTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    desc: failDescription,
    btnOkText: "확인",
    btnOkColor: Colors.red[400],
    btnOkOnPress: () => Get.back(),
  ).show();
}

Future<dynamic> failDialog2(failDescription) {
  return AwesomeDialog(
    context: Get.context!,
    width: 400,
    animType: AnimType.scale,
    dialogType: DialogType.noHeader,
    autoHide: const Duration(seconds: 3),
    dismissOnTouchOutside: false,
    descTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    desc: failDescription,
    title: "",
    btnOkText: "확인",
    btnOkColor: style.PRIMARY_BLUE,
    btnOkOnPress: () => {},
  ).show();
}


Dialog customDialog = Dialog(
  child: Center(
        child: GlassmorphicContainer(
          width: 300,
          height: 150,
          borderRadius: 20,
          blur: 30,
          alignment: Alignment.bottomCenter,
          border: 2,
          linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFFffffff).withOpacity(0.1),
                const Color(0xFFFFFFFF).withOpacity(0.05),
              ],
              stops: const [
                0.1,
                1,
              ]),
          borderGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFffffff).withOpacity(0.5),
              const Color((0xFFFFFFFF)).withOpacity(0.5),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 400,
                height: 80,
                child: Center(
                  child: Text(
                    "독클 결과가 없어요 :(",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              NiceButtons(
                width: 100,
                height: 40,
                startColor: const Color(0xff4b53fe),
                endColor: const Color(0xff3d49fd), 
                borderColor: const Color(0xff3d49fd),
                stretch: false,
                onTap: (context) {
                  // Navigator.pop(context);
                },
                child: const Text(
                  '확인',
                  style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
);


