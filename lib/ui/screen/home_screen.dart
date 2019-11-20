import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nabungin/core/models/tabungan.dart';
import 'package:nabungin/core/viewmodels/tabungan.dart';
import 'package:nabungin/ui/screen/add_tabungan_screen.dart';
import 'package:nabungin/ui/screen/update_tabungan_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nabungin"),
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => AddTabunganScreen()
          ));
        },
        child: Icon(Icons.add, color: Colors.white,),
      ),
      body: SingleChildScrollView(
        child: HomeBody()
      ),
    );
  }
}

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {

  @override
  void dispose() {
    //Closing hive when screen dissapire
    Hive.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: TabunganViewModel.openBox(),
      builder: (context, snapshot) {

        //Jika koneksi berhasil
        if (snapshot.connectionState == ConnectionState.done) {
          //Menampilkan daftar tabungan
          return TabunganItem();
        } else {
          //Kalau belum, dia nampilin loading
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
    
    
  }
}

class TabunganItem extends StatefulWidget {
  @override
  _TabunganItemState createState() => _TabunganItemState();
}

class _TabunganItemState extends State<TabunganItem> {
  @override
  Widget build(BuildContext context) {
    //Ini berfungsi untuk nambahin koma di angka
    final formatter = new NumberFormat("#,###");

    return Container(
      padding: EdgeInsets.only(top: 20),
      child: WatchBoxBuilder(
        box: TabunganViewModel.getall(),
        builder: (context, tabunganBox) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20.0, // has the effect of softening the shadow
                      spreadRadius: 5.0, // has the effect of extending the shadow
                      offset: Offset(
                        1.0, // horizontal, move right 10
                        1.0, // vertical, move down 10
                      ),
                    )
                  ],
                ),
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)

                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Total Simpanan",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black87
                        ),
                      ),
                      SizedBox(height: 5,),

                      Text(
                        "Rp ${formatter.format(TabunganViewModel.sumTotal()).toString()}",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),

              ListView.builder(
                itemCount: tabunganBox.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {

                  final tabungan = TabunganViewModel.getAt(index);
                  return Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 20.0, // has the effect of softening the shadow
                          spreadRadius: 5.0, // has the effect of extending the shadow
                          offset: Offset(
                            1.0, // horizontal, move right 10
                            1.0, // vertical, move down 10
                          ),
                        )
                      ],
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                tabungan.description,
                                style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                "Rp ${formatter.format(tabungan.nominal).toString()}",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.green
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () => TabunganViewModel.add(tabungan),
                                child: Icon(Icons.content_copy, color: Colors.green)
                              ),

                              SizedBox(width: 10,),

                              InkWell(
                                onTap: () => Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => UpdateTabunganScreen(
                                    index: index,
                                    tabungan: tabungan,
                                  )
                                )),
                                child: Icon(Icons.edit, color: Colors.blue)
                              ),

                              SizedBox(width: 10,),

                              InkWell(
                                onTap: () => TabunganViewModel.remove(index),
                                child: Icon(Icons.delete, color: Colors.red)
                              ),
                            ],
                          ),
                         
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      )
    );
  }
}