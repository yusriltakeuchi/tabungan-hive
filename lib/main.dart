import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nabungin/core/models/tabungan.dart';
import 'package:nabungin/ui/screen/home_screen.dart';
import 'package:path_provider/path_provider.dart';

/*

  @auhtor: Yusril Rapsanjani
  @version: 1.0

*/


void main() async{
  //First initializing path for database
  final appDocument = await getApplicationSupportDirectory();
  Hive.init(appDocument.path);

  //Registering adapter
  Hive.registerAdapter(TabunganAdapter(), 0);


  runApp(MaterialApp(
    title: "Nabungin",
    home: HomeScreen(),
    debugShowCheckedModeBanner: false,
  ));
}