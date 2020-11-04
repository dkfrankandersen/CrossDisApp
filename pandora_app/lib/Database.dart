import 'package:pandora_app/Models/jewellery.dart';
import 'package:pandora_app/Models/basedevice.dart';

class Database {
  final List<JewelleryPiece> jewelleryPieces = [];
  final List<BaseDevice> baseDevices = [];

  Database() {
    jewelleryPieces.add(new JewelleryPiece(1, 'Kuglebesat Pavé Båndring',
        'Purely Pandora', 'assets/images/jewellery001.png'));
    jewelleryPieces.add(new JewelleryPiece(
      2,
      'Sparkling & Polished Lines Ring',
      'Pandora Timeless',
      'assets/images/jewellery002.png',
    ));
    jewelleryPieces.add(new JewelleryPiece(3, 'Mat Glans Ring',
        'Pandora Timeless', 'assets/images/jewellery003.png'));

    baseDevices.add(new BaseDevice(1, 'Moments Ring', 'Capture the happiness',
        'assets/images/basering001.png', 98));
    baseDevices.add(new BaseDevice(
        2,
        'Contact Ring',
        'Feeling safe is all that matters',
        'assets/images/basering002.png',
        19));
    baseDevices.add(new BaseDevice(3, 'Puls Ring', 'Keeping the workout cool',
        'assets/images/basering003.png', 70));
    baseDevices.add(new BaseDevice(4, 'My First Ring', 'Making memorys',
        'assets/images/basering004.png', -1));
  }
}
