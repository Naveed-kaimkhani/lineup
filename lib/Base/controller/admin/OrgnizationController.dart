import 'package:get/get.dart';
import '../../../service/api/team.dart';

import '../../model/teamModel/teamModel.dart';
import '../getTeamData.dart';
import '../teamController/teamController.dart';

class OrganizationController extends GetxController {

  var isLoading = false;

  var organization = <Organizations?>[]; // flat list of Organizations
  Organizations? selectedOrganization;
  RxList<TeamData?> teamData = <TeamData?>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrganization();
  }

  Future<void> fetchOrganization() async {
    try {
      // Call the API to get the list of teams
      final response = await TeamsApi.getOrganization();

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
  void setSelectedOrganization(Organizations? org) {
    selectedOrganization = org;
    fetchOrganizationTeam(selectedOrganization!.id!);
    update(); // update UI
  }
}



// import 'package:get/get.dart';
// import '../../../service/api/adminApi.dart';
// import '../../model/adminModel/adminOrgnization.dart';
// import '../../model/response/base_response.dart';
//
//
// class OrganizationController extends GetxController {
//   var isLoading = false.obs;
//   var organizationList = <OrganizationResponse>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchOrganizations(); // Auto fetch when controller is initialized
//   }
//
//   Future<void> fetchOrganizations() async {
//     isLoading.value = true;
//
//     try {
//       final BaseResponse<List<OrganizationResponse?>> response =
//       await AdminApi.getOrganization();
//
//       if (response.data != null) {
//         organizationList.value =
//             response.data!.whereType<OrganizationResponse>().toList();
//       } else {
//         organizationList.clear();
//         Get.snackbar('Notice', 'No organizations found.');
//       }
//     } catch (e) {
//       Get.snackbar('Error', e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
