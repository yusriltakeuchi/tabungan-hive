
import 'package:hive/hive.dart';
part 'tabungan.g.dart';

@HiveType()
class Tabungan {
  @HiveField(0)
  String description;
  @HiveField(1)
  int nominal;

  Tabungan(this.description, this.nominal);


}