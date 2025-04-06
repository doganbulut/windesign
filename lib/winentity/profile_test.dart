import 'package:windesign/profentity/manufacturer.dart';
import 'package:windesign/profentity/profile.dart';
import 'package:windesign/profentity/serie.dart';

class ProfileTest {
  final Manufacturer manufacturer;

  ProfileTest() : manufacturer = _createData();

  static Manufacturer _createData() {
    final manufacturer = Manufacturer(name: "Pimapen");

    final serie = Serie(name: "Carizma", isSliding: false, sashMargin: 0);

    final frame = Profile(
      code: "STKFR00001",
      type: ProfileType.frame,
      name: "Kasa",
      height: 70,
      topwidth: 62,
      width: 41,
    );

    final sash = Profile(
      code: "STKSH00002",
      type: ProfileType.sash,
      name: "Kanat",
      height: 70,
      topwidth: 58,
      width: 59,
    );

    final mullion = Profile(
      code: "STKOK00003",
      type: ProfileType.mullion,
      name: "Orta Kayıt",
      height: 70,
      topwidth: 82,
      width: 41,
    );

    serie.profiles.addAll([frame, sash, mullion]);

    String jsonserie = serie.toJson();
    print(jsonserie);

    manufacturer.series.add(serie);
    String jsonman = manufacturer.toJson();
    print(jsonman);

    return manufacturer;
  }
}
