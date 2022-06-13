import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';
import 'package:ongkir/app/data/models/city_model.dart';
import 'package:ongkir/app/data/models/province_model.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('API RAJA ONGKIR'),
      //   centerTitle: true,
      // ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: ListView(
          padding: EdgeInsets.all(15),
          children: [
            Text(
              "Welcome to\nRaja Ongkir API",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 20,
            ),
            //membuat dropdownsearch
            DropdownSearch<Province>(
              //showSearchBox menampilkan inputan search
              showSearchBox: true,
              //popupItemBuilder menampilkan list province
              popupItemBuilder: (context, item, isSelected) =>
                  ListTile(title: Text("${item.province}")),
              dropdownSearchDecoration: InputDecoration(
                labelText: "Provinsi Asal",
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                border: OutlineInputBorder(),
              ),
              // onFind request data dari provider dengan package Dio()
              onFind: (text) async {
                var response = await Dio().get(
                    "https://api.rajaongkir.com/starter/province",
                    queryParameters: {
                      "key": "72958365f382e4c289ad93bf017a9d69",
                    });
                return Province.fromJsonList(
                    response.data["rajaongkir"]["results"]);
              },
              //mengambil data provinsi
              onChanged: (value) =>
                  controller.provAsalId.value = value?.provinceId ?? "0",
            ),
            SizedBox(
              height: 20,
            ),
            DropdownSearch<City>(
              //showSearchBox menampilkan inputan search
              showSearchBox: true,
              //popupItemBuilder menampilkan list province
              popupItemBuilder: (context, item, isSelected) =>
                  ListTile(title: Text("${item.type} ${item.cityName}")),
              dropdownSearchDecoration: InputDecoration(
                labelText: "Kota/Kabupaten Asal",
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                border: OutlineInputBorder(),
              ),
              // onFind request data dari provider dengan package Dio()
              onFind: (text) async {
                var response = await Dio().get(
                    "https://api.rajaongkir.com/starter/city?province=${controller.provAsalId}",
                    queryParameters: {
                      "key": "72958365f382e4c289ad93bf017a9d69",
                    });
                return City.fromJsonList(
                    response.data["rajaongkir"]["results"]);
              },
              //mengambil data kab/city
              onChanged: (value) =>
                  controller.cityAsalId.value = value?.cityId ?? "0",
            ),
            SizedBox(
              height: 20,
            ),
            DropdownSearch<Province>(
              //showSearchBox menampilkan inputan search
              showSearchBox: true,
              //popupItemBuilder menampilkan list province
              popupItemBuilder: (context, item, isSelected) =>
                  ListTile(title: Text("${item.province}")),
              dropdownSearchDecoration: InputDecoration(
                labelText: "Provinsi Tujuan",
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                border: OutlineInputBorder(),
              ),
              // onFind request data dari provider dengan package Dio()
              onFind: (text) async {
                var response = await Dio().get(
                    "https://api.rajaongkir.com/starter/province",
                    queryParameters: {
                      "key": "72958365f382e4c289ad93bf017a9d69",
                    });
                return Province.fromJsonList(
                    response.data["rajaongkir"]["results"]);
              },
              //mengambil data provinsi
              onChanged: (value) =>
                  controller.provTujuanId.value = value?.provinceId ?? "0",
            ),
            SizedBox(
              height: 20,
            ),
            DropdownSearch<City>(
              //showSearchBox menampilkan inputan search
              showSearchBox: true,
              //popupItemBuilder menampilkan list province
              popupItemBuilder: (context, item, isSelected) =>
                  ListTile(title: Text("${item.type} ${item.cityName}")),
              dropdownSearchDecoration: InputDecoration(
                labelText: "Kota/Kabupaten Tujuan",
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                border: OutlineInputBorder(),
              ),
              // onFind request data dari provider dengan package Dio()
              onFind: (text) async {
                var response = await Dio().get(
                    "https://api.rajaongkir.com/starter/city?province=${controller.provTujuanId}",
                    queryParameters: {
                      "key": "72958365f382e4c289ad93bf017a9d69",
                    });
                return City.fromJsonList(
                    response.data["rajaongkir"]["results"]);
              },
              //mengambil data kab/city
              onChanged: (value) =>
                  controller.cityTujuanId.value = value?.cityId ?? "0",
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: controller.beratC,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: "Berat(g)",
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            DropdownSearch<Map<String, dynamic>>(
              items: [
                {"code": "jne", "name": "JNE"},
                {"code": "pos", "name": "Pos Indonesia"},
                {"code": "tiki", "name": "TIKI"},
              ],
              showSearchBox: true,
              popupItemBuilder: (context, item, isSelected) =>
                  ListTile(title: Text("${item['name']}")),
              dropdownSearchDecoration: InputDecoration(
                labelText: "Kurir",
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                border: OutlineInputBorder(),
              ),
              dropdownBuilder: (context, selectedItem) =>
                  Text("${selectedItem?['name'] ?? "Pilih Kurir"}"),
              onChanged: (value) =>
                  controller.codeKurir.value = value?['code'] ?? "",
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              
                onPressed: () => controller.cekOngkir(),
                child: Text('CHECK ONGKIR'))
          ],
        ),
      ),
    );
  }
}
