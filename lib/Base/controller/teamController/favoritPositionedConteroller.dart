import 'dart:convert';
import 'package:get/get.dart';
import '../../../utils/SharedPreferencesUtil.dart';
import '../../model/positioned.dart';

class FavoritePositionedController extends GetxController {
  List<Position?> favPositioned = [];
  List<Position?> fav = [];
  Position? selectedFavPosition;
  List<Position?> resPositioned = [];
  List<Position?> res = [];
  Position? selectedResPosition;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    if (favPositioned.isEmpty) await loadFavPositioned();
    if (resPositioned.isEmpty) await loadResPositioned();
    update();
  }

  static Future<List<Position?>> readPositionList(String key) async {
    final jsonString = SharedPreferencesUtil.sharedPreferences.getString(key);
    if (jsonString == null) return [];

    final decoded = jsonDecode(jsonString);
    final List<dynamic> data = decoded['data'];

    return data
        .map<Position?>((e) => e == null ? null : Position.fromJson(e))
        .toList();
  }

  Future<void> loadFavPositioned() async {
    final list = await readPositionList('fav');
    favPositioned.clear();
    favPositioned = list
        .whereType<Position>()
        .map((e) => e.copyWith()) // optional deep copy
        .toList();
  }

  Future<void> loadResPositioned() async {
    final list = await readPositionList('res');
    resPositioned.clear();
    resPositioned = list
        .whereType<Position>()
        .map((e) => e.copyWith())
        .toList();
  }



  void removePositioned(Position? value){




  }


  void addPositioned(Position? value){
    final a=value;
    fav.add(a);


  }

}




