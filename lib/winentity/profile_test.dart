import 'package:windesign/profentity/manufacturer.dart';
import 'package:windesign/profentity/profile.dart';
import 'package:windesign/profentity/serie.dart';

class ProfileTest {
  Manufacturer manufacturer;

  void createData() {
    manufacturer = new Manufacturer();
    manufacturer.name = "Pimapen";
    manufacturer.series = [];

    Serie serie = new Serie();
    serie.name = "Carizma";
    serie.isSliding = false;

    serie.profiles = [];

    Profile frame = new Profile();
    frame.code = "STKFR00001";
    frame.type = "frame";
    frame.name = "Kasa";
    frame.height = 70;
    frame.topwidth = 62;
    frame.width = 41;

    Profile sash = new Profile();
    sash.code = "STKSH00002";
    sash.type = "sash";
    sash.name = "Kanat";
    sash.height = 70;
    sash.topwidth = 58;
    sash.width = 59;

    Profile mullion = new Profile();
    mullion.code = "STKOK00003";
    mullion.type = "mullion";
    mullion.name = "Orta Kayıt";
    mullion.height = 70;
    mullion.topwidth = 82;
    mullion.width = 41;

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
