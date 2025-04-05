import 'package:windesign/profentity/manufacturer.dart';
import 'package:windesign/profentity/profile.dart';
import 'package:windesign/profentity/serie.dart';

class ProfileTest {
  late Manufacturer manufacturer;

  void createData() {
    manufacturer = Manufacturer(name: "Pimapen", series: []);

    Serie serie =
        Serie(name: "Carizma", isSliding: false, profiles: [], sashMargin: 0);

    Profile frame = Profile(
        code: "STKFR00001",
        type: "frame",
        name: "Kasa",
        height: 70,
        topwidth: 62,
        width: 41);

    Profile sash = Profile(
        code: "STKSH00002",
        type: "sash",
        name: "Kanat",
        height: 70,
        topwidth: 58,
        width: 59);

    Profile mullion = Profile(
        code: "STKOK00003",
        type: "mullion",
        name: "Orta Kayıt",
        height: 70,
        topwidth: 82,
        width: 41);

    serie.profiles.add(frame);
    serie.profiles.add(sash);
    serie.profiles.add(mullion);

    String jsonserie = serie.toJson();
    print(jsonserie);

    manufacturer.series.add(serie);
    String jsonman = manufacturer.toJson();
    print(jsonman);
  }
}
