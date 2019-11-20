import 'package:hive/hive.dart';
import 'package:nabungin/core/models/tabungan.dart';

class TabunganViewModel {

  static final tabunganBox = Hive.box("tabungan");
  
  static Future openBox() {
    return Hive.openBox("tabungan");
  }

  static int sumTotal() {
    int total = 0;
    for(int i=0; i<tabunganBox.length; i++) {
      final tabungan = tabunganBox.getAt(i) as Tabungan;
      total += tabungan.nominal;
    }

    return total;
  }

  static void add(Tabungan tabungan) {
    tabunganBox.add(tabungan);
  }

  static Box<dynamic> getall() {
    return tabunganBox;
  }

  static Tabungan getAt(int index) {
    return tabunganBox.getAt(index) as Tabungan;
  }

  static void remove(int index) {
    tabunganBox.deleteAt(index);
  }

  static void update(Tabungan tabungan, int index) {
    tabunganBox.putAt(index, tabungan);
  }
}