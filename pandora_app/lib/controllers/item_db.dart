import 'package:pandora_app/models/basedevice.dart';
import 'package:pandora_app/models/jewellery.dart';

class ItemDatabase {
  final List<BaseDevice> _baseDevices = [];
  final List<JewelleryPiece> _jewelleryPieces = [];

  ItemDatabase() {
    _loadBaseDevices();
    _loadJewellery();
  }

  void _loadBaseDevices() {
    this._baseDevices.add(new BaseDevice(1, 'Moments Ring',
        'Capture the happiness', 'assets/images/basering001.png', 98));
    this._baseDevices.add(new BaseDevice(
        2,
        'Contact Ring',
        'Feeling safe is all that matters',
        'assets/images/basering002.png',
        19));
    this._baseDevices.add(new BaseDevice(3, 'Puls Ring',
        'Keeping the workout cool', 'assets/images/basering003.png', 70));
    this._baseDevices.add(new BaseDevice(4, 'My First Ring', 'Making memorys',
        'assets/images/basering004.png', -1));
  }

  void _loadJewellery() {
    this._jewelleryPieces.add(new JewelleryPiece(1, 'Kuglebesat Pavé Båndring',
        'Purely Pandora', 'assets/images/jewellery001.png'));
    this._jewelleryPieces.add(new JewelleryPiece(
          2,
          'Sparkling & Polished Lines Ring',
          'Pandora Timeless',
          'assets/images/jewellery002.png',
        ));
    this._jewelleryPieces.add(new JewelleryPiece(3, 'Mat Glans Ring',
        'Pandora Timeless', 'assets/images/jewellery003.png'));
  }

  List<BaseDevice> getBaseDevices() {
    return _baseDevices;
  }

  List<JewelleryPiece> getJewelleryPieces() {
    return _jewelleryPieces;
  }
}
