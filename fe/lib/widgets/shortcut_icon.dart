import 'package:flutter/material.dart';
import 'package:flutter_application/widgets/imagebox_decoration.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

// 바로가기 아이콘
Widget shortcutIcon(title, url, imgPath) {
  return GestureDetector(
    onTap: (){
      launchUrl(Uri.parse(url));
    },
    child: ListTile(
      tileColor: Theme.of(Get.context!).colorScheme.surface,
      title: Text(title, style: const TextStyle(fontSize: 15)),
      leading: Container(
        margin: const EdgeInsets.all(5),
        width: 35,
        height: 35,
        decoration: imageBoxDecoration(imgPath, BoxFit.contain),
      ),
    ),
  );
}