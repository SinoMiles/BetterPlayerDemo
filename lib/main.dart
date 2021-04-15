import 'dart:convert';

import 'package:better_player/better_player.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
  Get.put(HomeController());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Home(),
    );
  }
}

class Home extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BetterPlayer(
      controller: controller.betterPlayerController,
    ));
  }
}

class HomeController extends GetxController {
  BetterPlayerController betterPlayerController;
  @override
  Future<void> onInit() async {
    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
      autoPlay: true,
    );
    betterPlayerController = BetterPlayerController(betterPlayerConfiguration);

    var dio = Dio();
    var response = await dio.get(
        'https://jx.dxzj88.com/789pan/?url=%E4%B8%A7%E5%B0%B8%E6%9C%AA%E9%80%9D%E7%AC%AC1%E9%9B%86');
    var data = parseUrlFromJson(response.data);
    betterPlayerController.setupDataSource(BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      data.url,
    ));
    super.onInit();
  }
}

ParseUrl parseUrlFromJson(String str) => ParseUrl.fromJson(json.decode(str));

String parseUrlToJson(ParseUrl data) => json.encode(data.toJson());

class ParseUrl {
  ParseUrl({
    this.code,
    this.success,
    this.parser,
    this.player,
    this.type,
    this.metareferer,
    this.url,
  });

  String code;
  String success;
  String parser;
  String player;
  String type;
  String metareferer;
  String url;

  factory ParseUrl.fromJson(Map<String, dynamic> json) => ParseUrl(
        code: json["code"].toString(),
        success: json["success"],
        parser: json["parser"],
        player: json["player"],
        type: json["type"],
        metareferer: json["metareferer"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "parser": parser,
        "player": player,
        "type": type,
        "metareferer": metareferer,
        "url": url,
      };
}
