import 'package:windesign/profentity/manufacturer.dart';
import 'package:windesign/profentity/profile.dart';
import 'package:windesign/profentity/serie.dart';

class ProfileTest {
  late Manufacturer manufacturer;

  void createData() {
    List<Profile> profiles = [];
    profiles.add(Profile(
        code: "P1",
        name: "Frame Profile",
        type: "frame",
        height: 70,
        topwidth: 50,
        width: 60));
    profiles.add(Profile(
        code: "P2",
        name: "Mullion Profile",
        type: "mullion",
        height: 70,
        topwidth: 50,
        width: 60));
    profiles.add(Profile(
        code: "P3",
        name: "Sash Profile",
        type: "sash",
        height: 70,
        topwidth: 50,
        width: 60));

    List<Serie> series = [];
    series.add(Serie(
        name: "Carizma",
        isSliding: false,
        sashMargin: 5,
        profiles: profiles));

    manufacturer = Manufacturer(name: "Test Manufacturer", series: series);
  }
}
