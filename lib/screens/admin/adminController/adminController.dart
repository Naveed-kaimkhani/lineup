import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../Base/controller/getTeamData.dart';
import '../../../Base/model/adminModel/makeOrginization.dart';
import '../../../Base/model/teamModel/teamModel.dart';
import '../../../service/api/orginizationApi.dart';
import '../../../service/api/team.dart';
import '../../../utils/snackbarUtils.dart';

class AdminController extends GetxController{
  var organization = <Organizations?>[]; // flat list of Organizations
  Organizations? selectedOrganization;
  RxList<TeamData?> teamData = <TeamData?>[].obs;
  final orginizationNameController = TextEditingController();
  final orginizationEmail = TextEditingController();


  Future<void> fetchOrganization() async {
    try {
      // Call the API to get the list of teams
      final response = await OrginizationsApi.getOrganization();

      // Check if the response contains data and update the teams list
      if (response.data != null && response.data!.isNotEmpty) {
        organization = response.data!;
        organization=organization;
        selectedOrganization=organization[0];
        selectedOrganization=selectedOrganization;
        update();
      } else {
        // Handle the case where no teams are returned

      }
    } catch (e) {
      // Handle any errors that occur
      print('Error fetching teams: $e');
    }
  }


  Future<void> adminCreateOrganization() async {
    print(orginizationNameController.text.trim());
    print(orginizationEmail.text.trim());
    try {
     final  orginizationCreate=OrginizationCreate(
         name:orginizationNameController.text.trim(),
       email: orginizationEmail.text.trim()
     );
      // Call the API to get the list of teams
      final response = await OrginizationsApi.createOrginization(orginizationCreate );

      // Check if the response contains data and update the teams list
      if (response.success!) {
        SnackbarUtils.showSuccess("Organization Add Successfully");
      } else {
        // Handle the case where no teams are returned
        SnackbarUtils.showErrorr("Organization Add Failed Try again");
      }
    } catch (e) {
      // Handle any errors that occur
      print('Error fetching teams: $e');
    }
  }



  Future<void> fetchOrganizationTeam(int orgnizationId) async {
    try {
      // Call the API to get the list of teams
      final response = await TeamsApi.getOrganizationTeam(orgnizationId);
      print("in function ");
      print("in function ");
      print(response.data);
      print(response.data);
      // Check if the response contains data and update the teams list
      if (response.data != null && response.data!.isNotEmpty) {
        print("in function ");
        print("in function ");
        print(response.data);
        print(response.data);
        teamData.value = response.data!;
        teamData.refresh();
        update();
      } else {
        // Handle the case where no teams are returned

      }
    } catch (e) {
      // Handle any errors that occur
      print('Error fetching teams: $e');
    }
  }

}