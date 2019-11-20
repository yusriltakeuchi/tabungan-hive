import 'package:flutter/material.dart';
import 'package:nabungin/core/models/tabungan.dart';
import 'package:nabungin/core/viewmodels/tabungan.dart';
import 'package:nabungin/ui/widgets/custom_textfield.dart';

class UpdateTabunganScreen extends StatelessWidget {
  Tabungan tabungan;
  int index;
  UpdateTabunganScreen({this.tabungan, this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Tabungan"),
        backgroundColor: Colors.blue,
      ),
      body: UpdateTabunganBody(
        tabungan: tabungan,
        index: index,
      ),
    );
  }
}

class UpdateTabunganBody extends StatefulWidget {
  Tabungan tabungan;
  int index;
  UpdateTabunganBody({this.tabungan, this.index});
  
  @override
  _UpdateTabunganBodyState createState() => _UpdateTabunganBodyState();
}

class _UpdateTabunganBodyState extends State<UpdateTabunganBody> {
  var descriptionController = TextEditingController();
  var nominalController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    descriptionController.text = widget.tabungan.description;
    nominalController.text = widget.tabungan.nominal.toString();
  }

  void updateTabungan() {
    final description = descriptionController.text;
    final nominal = nominalController.text;
    if (description.isNotEmpty && nominal.isNotEmpty) {
      
      final tabungan = Tabungan(description, int.parse(nominal));
      TabunganViewModel.update(tabungan, widget.index);
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
                updateTabungan();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              color: Colors.blue,
              child: Text(
                "Update Tabungan",
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