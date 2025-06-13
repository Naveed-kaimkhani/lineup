import 'package:get/get.dart';

import '../../../service/api/team.dart';
import '../../model/positioned.dart';

class PlayerEditController extends   GetxController{




  List<Position>? teamPositioned ;



  Future<void> fetchTeamsPositioned() async {
    try {
      // Call the API to get the list of teams
      final response = await TeamsApi.getTeamPosition();

      // Check if the response contains data and update the teams list
      if (response.data != null && response.data!.isNotEmpty) {
        teamPositioned= response!.data!.cast<Position>();

             update();
      } else {
        // Handle the case where no teams are returned
        // teams.value = [];
      }
    } catch (e) {
      // Handle any errors that occur
      print('Error fetching teams: $e');
    }
  }






}