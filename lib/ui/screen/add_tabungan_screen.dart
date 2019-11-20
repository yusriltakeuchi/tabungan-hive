import 'package:flutter/material.dart';
import 'package:nabungin/core/models/tabungan.dart';
import 'package:nabungin/core/viewmodels/tabungan.dart';
import 'package:nabungin/ui/widgets/custom_textfield.dart';

class AddTabunganScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Tabungan"),
        backgroundColor: Colors.blue,
      ),
      body: AddTabunganBody(),
    );
  }
}

class AddTabunganBody extends StatefulWidget {
  @override
  _AddTabunganBodyState createState() => _AddTabunganBodyState();
}

class _AddTabunganBodyState extends State<AddTabunganBody> {
  var descriptionController = TextEditingController();
  var nominalController = TextEditingController();

  void addTabungan() {
    final description = descriptionController.text;
    final nominal = nominalController.text;
    if (description.isNotEmpty && nominal.isNotEmpty) {
      
      final tabungan = Tabungan(description, int.parse(nominal));
      TabunganViewModel.add(tabungan);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomTextfieldBorder(
            action: TextInputAction.next,
            type: TextInputType.text,
            title: "Description",
            controller: descriptionController,
          ),
          SizedBox(height: 10,),
          CustomTextfieldBorder(
            action: TextInputAction.go,
            type: TextInputType.number,
            title: "Nominal",
            controller: nominalController,
          ),
          SizedBox(height: 20,),

          Container(
            width: MediaQuery.of(context).size.width,
            height: 45,
            child: RaisedButton(
              onPressed: () {
                addTabungan();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              color: Colors.blue,
              child: Text(
                "Tambah Tabungan",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}