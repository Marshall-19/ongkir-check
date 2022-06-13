import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ongkir/app/data/models/ongkir_model.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  TextEditingController beratC = TextEditingController();

  //kirim data ongkir yang diambil dari model dibawah
  List<Ongkir> ongkosKirim = [];

  RxString berat = "0".obs;
  RxString cityAsalId = "0".obs;
  RxString provAsalId = "0".obs;
  RxString cityTujuanId = "0".obs;
  RxString provTujuanId = "0".obs;

  RxString codeKurir = "".obs;

  void cekOngkir() async {
    if (provAsalId != "0" &&
        provTujuanId != "0" &&
        cityAsalId != "0" &&
        cityTujuanId != "0" &&
        codeKurir != "") {
      try {
        var response = await http.post(
          Uri.parse("https://api.rajaongkir.com/starter/cost"),
          headers: {
            "key": "72958365f382e4c289ad93bf017a9d69",
            "content-type": "application/x-www-form-urlencoded"
          },
          body: {
            "origin": cityAsalId.value,
            "destination": cityTujuanId.value,
            "weight": beratC.text,
            "courier": codeKurir.value,
          },
        );
        // convert data ongkir ke list
        List ongkir = json.decode(response.body)["rajaongkir"]["results"][0]
            ["costs"] as List;
        //ambil data dari model
        ongkosKirim = Ongkir.fromJsonList(ongkir);

        // tampilkan data ke modal/dialog
        Get.defaultDialog(
          title: "Raja Ongkir",
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: ongkosKirim
                .map(
                  (e) => ListTile(
                    title:
                        Text("${e.service!.toUpperCase()} | ${e.description!}"),
                    subtitle: Text("Rp ${e.cost![0].value}"),
                  ),
                )
                .toList(),
          ),
        );
      } catch (e) {
        // print(e);
        Get.defaultDialog(title: "Failed", middleText: "Do not check ongkir");
      }
    } else {
      Get.defaultDialog(title: "Failed", middleText: "Data Isn't completed");
    }
  }
}
