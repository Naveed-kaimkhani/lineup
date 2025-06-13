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





// import 'dart:convert';
//
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
//
// import '../../../utils/SharedPreferencesUtil.dart';
// import '../../model/positioned.dart';
//
// class FavoritePositionedController extends GetxController {
//   List<Position?> favPositioned = [];
//   Position? selectedFavPosition;
//   List<Position?> resPositioned = [];
//   Position? selectedResPosition;
//
//   @override
//   void onInit() {
//     super.onInit();
//     getData(); // Load data on init
//   }
//
//   static Future<List<Position?>> readPositionList(String key) async {
//     final jsonString = SharedPreferencesUtil.sharedPreferences.getString(key);
//     if (jsonString == null) return [];
//
//     final Map<String, dynamic> decoded = jsonDecode(jsonString);
//     final List<dynamic> data = decoded['data'];
//
//     return data
//         .map<Position?>((e) => e == null ? null : Position.fromJson(e))
//         .toList();
//   }
//
//   void getData() {
//     favPositioned.isEmpty ?
//     loadFavPositioned():"";
//     resPositioned.isEmpty?  loadResPositioned():"";
//   }
//
//   Future<void> loadFavPositioned() async {
//     final list = await readPositionList('key');
//     favPositioned =list
//         .whereType<Position>() // remove nulls
//         .map((e) => Position.fromJson(e.toJson()))
//         .toList();
//     update();
//   }
//
//   Future<void> loadResPositioned() async {
//     final list = await readPositionList('key');
//     resPositioned.clear();
//     resPositioned = list
//         .whereType<Position>() // remove nulls
//         .map((e) => e.copyWith()) // copies the Position object
//         .toList();
//     // resPositioned.addAll(list);
//     update();
//   }
// }
