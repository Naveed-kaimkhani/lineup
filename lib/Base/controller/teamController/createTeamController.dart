import 'dart:developer';

import 'package:gaming_web_app/Base/controller/teamController/teamController.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';

import '../../../checkout/stripe_checkout.dart';
import '../../../routes/routes_path.dart';
import '../../../screens/main_dashboard/add_player_dialog.dart';
import '../../../service/api/team.dart';
import '../../../utils/snabarError.dart';
import '../../../utils/snackbarUtils.dart';
import '../../model/game/addNewGame.dart';
import '../../model/player/addPaler.dart';
import '../../model/player/addPlayerResponse.dart';
import '../../model/positioned.dart';
import '../../model/teamModel/createModel.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../paymantContrller.dart'; // Import Dio for API call

class NewTeamController extends GetxController {
  final TeamController teamController = Get.find<TeamController>();
  // final TeamController teamController = Get.put(TeamController());
  //
  // Form Key
  final formKey = GlobalKey<FormState>();
  Rx<CreateTeamResponse?> createTeamResponse = CreateTeamResponse().obs;
  Rx<PlayerInputModel?> playerInputModel = PlayerInputModel().obs;
  Rx<AddPlayerResponse?> addPlayerResponse = AddPlayerResponse().obs;

  // Observable form fields
  // final name = ''.obs;
  final sportType = ''.obs; // 'baseball' or 'softball'
  final teamType = ''.obs; // 'travel', 'recreation', or 'school'

  final year = 0.obs; // optional
  final city = ''.obs; // optional
  final state = ''.obs; // optional
  // final organizationId = 0.obs;  // optional

  // TextEditingControllers (for text fields if needed)
  final TextEditingController teamNameController = TextEditingController();
  RxInt organizationId = 0.obs;
  final TextEditingController ageGroupController = TextEditingController();
  final TextEditingController seasonController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

  /// add player
  final TextEditingController playerCountryController = TextEditingController();
  final TextEditingController playerLastNameController =
      TextEditingController();
  final TextEditingController playerJerseyNumberController =
      TextEditingController();
  final TextEditingController playerEmailController = TextEditingController();
  final TextEditingController playerPhoneController = TextEditingController();
  // Dio instance for API call
  RxInt currentPage = 0.obs;
  RxInt totalPages = 11.obs; // total number of pages
  final PageController pageController = PageController();
  void _goToNext(BuildContext context) async {
    if (currentPage < totalPages.value - 1) {
      await pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      // newTeamController.pageControler(index)

      currentPage++;
      updateDimensions(context);
      print(currentPage);
      // _updateDimensions(context);
    }
  }
  void goToPrevious(BuildContext context) async {
    SnackbarUtils.showErrorr('Please Fill All Next Requirement'.toString());
    if (currentPage.value > 0) {
      await pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

        currentPage.value --;
        updateDimensions(context);
    }
  }
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> pageIndex(BuildContext context) async {
    print(currentPage);
    print(teamNameController.value);
    if (currentPage.value == 0) {
      if (sportType.value.isEmpty) {
        SnackbarUtils.showErrorr('Please set all required values'.toString());
      } else {
        _goToNext(context);
      }
    }

    if (currentPage.value == 1) {
      if (teamNameController.text.trim().isEmpty || organizationId.value == 0) {
        SnackbarUtils.showErrorr('Please set all required values'.toString());
      } else {
        _goToNext(context);
      }
    }

    if (currentPage.value == 2) {
      if (teamType.value.isEmpty) {
        SnackbarUtils.showErrorr('Please set values'.toString());
      } else {
        _goToNext(context);
      }
    }



    if(currentPage.value == 3){
          if(ageGroupController.text.trim().isEmpty ){
            SnackbarUtils.showErrorr('Please Enter value '.toString());
            // if(ageGroupController.text.length != 4)
            // {
            //   SnackbarUtils.showErrorr('Please set values'.toString());
            // }else{
            //   SnackbarUtils.showErrorr('Please Enter 4 digit '.toString());
            //
            // }
          }else{

            if(ageGroupController.text.length == 4)
            {
              _goToNext(context);
              // SnackbarUtils.showErrorr('Please set values'.toString());
            }else{
              SnackbarUtils.showErrorr('Please Enter 4 digit '.toString());

            }
            // _goToNext(context);
          }
    }



    if(currentPage.value == 4){
      if(seasonController.text.trim().isEmpty){
        SnackbarUtils.showErrorr('Please select  values'.toString());
      }else{
        _goToNext(context);
      }
    }



    if(currentPage.value == 5){
      if(cityController.text.trim().isEmpty ||cityController.text.trim().isEmpty || stateController.text.trim().isEmpty){
        SnackbarUtils.showErrorr('Please select  values'.toString());
      }else{
        // CreateNewTeam(context);
        _goToNext(context);
      }
    }

    if(currentPage.value == 6){

        CreateNewTeam(context);
        // _goToNext(context);

    }


    if(currentPage.value == 7){
      // Navigator.pop(context);



   // await   paymentController.paymentModel(createTeamResponse.value!.id!); // Pass teamId
      Get.offNamed(RoutesPath.mainDashboardScreen);
      // Navigator.pop(context);
      // teamController.getData();
      paymentController.paymentModel(context,createTeamResponse.value!.id!);
      // Get.offNamed(RoutesPath.mainDashboardScreen);
      // redirectToCheckout(context);
      // Navigator.pop(context);
      // CreateNewTeam(context);
      // _goToNext(context);

    }

  }
  final paymentController = Get.put(PaymentController());
  // @override
  // void onClose() {
  //   nameController.dispose();
  //   seasonController.dispose();
  //   yearController.dispose();
  //   cityController.dispose();
  //   stateController.dispose();
  //   super.onClose();
  // }

  RxDouble dialogHeight = 0.0.obs;
  RxDouble dialogWidth = 0.0.obs;
  void initDimensions(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // Set initial dimensions
    updateDimensions(context);
  }

  void updateDimensions(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    // Calculate height as percentage of screen height
    switch (currentPage.value) {
      case 0:
        dialogHeight.value = screenHeight * 0.33;
        break;
      case 1:
        dialogHeight.value = screenHeight * 0.43;
        break;
      case 6:
        dialogHeight.value =
            screenHeight * 0.65; // Reduced from 0.7 to prevent overflow
        break;
      case 7:
        dialogHeight.value =
            screenHeight * 0.65; // Reduced from 0.7 to prevent overflow
        break;

      case 7:
        dialogHeight.value =
            screenHeight * 0.65; // Reduced from 0.7 to prevent overflow
        break;
      case 8:
        dialogHeight.value =
            screenHeight * 0.65; // Reduced from 0.7 to prevent overflow
        break;
      default:
        dialogHeight.value = screenHeight * 0.33;
    }

    // Calculate width as percentage of screen width with maximum limits
    switch (currentPage.value) {
      case 0:
        dialogWidth.value = screenWidth * 0.5 > 500 ? 500 : screenWidth * 0.5;
        break;
      case 1:
        dialogWidth.value = screenWidth * 0.55 > 560 ? 560 : screenWidth * 0.55;
        break;
      case 2:
        dialogWidth.value = screenWidth * 0.6 > 600 ? 600 : screenWidth * 0.6;
        break;
      case 5:
        dialogWidth.value = screenWidth * 0.7 > 800 ? 800 : screenWidth * 0.7;
        break;
      case 6:
        dialogWidth.value = screenWidth * 0.75 > 900 ? 900 : screenWidth * 0.75;
        break;
      case 7:
        dialogWidth.value = screenWidth * 0.8 > 1000 ? 1000 : screenWidth * 0.8;
        break;
      default:
        dialogWidth.value = screenWidth * 0.5 > 500 ? 500 : screenWidth * 0.5;
    }
  }

  CreateTeam getCreateTeamModel() {
    return CreateTeam(
      name: teamNameController.text.trim(),
      sportType: sportType.value.toLowerCase(),
      teamType: teamType.value.toLowerCase(),
      ageGroup: ageGroupController.text,
      season: seasonController.text,
      year: int.parse(ageGroupController.text),
      // year.value,
      city: cityController.text,
      state: countryController.text,
      organizationId: organizationId.value,
    );
  }

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  Future<void> CreateNewTeam(BuildContext context) async {
    if (true) {
      try {
        // Show loading indicator (optional)
        // Get.dialog(Center(child: CircularProgressIndicator()));

        // Make API call here (using Dio or your preferred HTTP client)

        final response = await TeamsApi.createTeam(
          getCreateTeamModel(),
        ); // Replace with `loginUser()` if needed

        if (response.success!) {
          clearTeamFormFields();
          _goToNext(context);
          createTeamResponse.value = response!.data!;
          teamController.fetchGetPlayer(createTeamResponse!.value!.id!);
          // Get.toNamed(RoutesPath.mainDashboardScreen);
          SnackbarUtils.showSuccess('Create new Team  successfully');
          // Navigate to home or dashboard
          // Get.toNamed(RoutesPath.home);
        } else {
          Get.snackbar('Error', response.message ?? 'Something went wrong');
        }
      } catch (e) {
        Get.back(); // Close loading dialog
        Get.snackbar('Error', 'Something went wrong: $e');
      }
    } else {
      Get.snackbar('Error', 'Please fill all required fields');
    }
  }

  /// add new game
  // Observables
  var opponentName = ''.obs;
  var gameDate = Rxn<DateTime>();
  var innings = 0.obs;
  // var locationType = ''.obs;
  var isHomeSelected = false.obs;
  var isPreviousLineUpTemplate = false.obs;
  var type = "".obs;
  // Text controllers
  final TextEditingController opponentController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController insController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  // Validate and submit match
  Future<void> validateAndSubmitAddGame(
    BuildContext context,
    int? teamId,
  ) async {
    if (opponentController.text.trim().isEmpty ||
        dateController.text.trim().isEmpty ||
        insController.text.trim().isEmpty) {
      Get.snackbar(
        "Missing Fields",
        "Please fill all fields before submitting.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    final addGame = AddGame(
      opponentName: opponentController.text.trim(),
      gameDate: dateController.text.trim(),
      innings: int.parse(insController.text.trim()),
      locationType: type.value.trim(),
    );

    final response = await TeamsApi.CreateNewGame(addGame, teamId!);

    if (response.success!) {
      Navigator.pop(context);
      Get.snackbar(
        "Success",
        "Game info submitted successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      clearGameFormFields();
      // Get.back();
    } else {
      SnackbarUtils.showErrorr(response.message.toString());
      // Get.snackbar(
      //   "Error",
      //   "Failed to submit. Try again.",
      //   snackPosition: SnackPosition.BOTTOM,
      //   backgroundColor: Colors.redAccent,
      //   colorText: Colors.white,
      // );
      Get.back();
    }
  }

  // Future<void> CreateNewGame() async {
  //
  //   if (true) {
  //     try {
  //       // Show loading indicator (optional)
  //       // Get.dialog(Center(child: CircularProgressIndicator()));
  //
  //       // Make API call here (using Dio or your preferred HTTP client)
  //
  //
  //       final response = await TeamsApi.CreateNewTeam(getCreateTeamModel()); // Replace with `loginUser()` if needed
  //
  //       if (response.success!) {
  //         createTeamResponse.value =response!.data!;
  //         teamController.fetchGetPlayer( createTeamResponse!.value!.id!);
  //         // Get.toNamed(RoutesPath.mainDashboardScreen);
  //         Get.snackbar('Success', 'User signed in successfully');
  //         // Navigate to home or dashboard
  //         // Get.toNamed(RoutesPath.home);
  //       } else {
  //         Get.snackbar('Error', response.message ?? 'Login failed');
  //       }
  //     } catch (e) {
  //       Get.back(); // Close loading dialog
  //       Get.snackbar('Error', 'Something went wrong: $e');
  //     }
  //   } else {
  //     Get.snackbar('Error', 'Please fill all required fields');
  //   }
  // }

  ///  add paler
  Future<void> addPlayer(BuildContext context, {int? teamId}) async {
    final country = playerCountryController.text;
    final lastName = playerLastNameController.text;
    final jerseyNumber = playerJerseyNumberController.text;
    final email = playerEmailController.text;
    final phone = playerPhoneController.text;

    if (country.isEmpty) {
      showError(context, 'Please enter player country');
      return;
    }
    if (lastName.isEmpty) {
      showError(context, 'Please enter player last name');
      return;
    }
    if (jerseyNumber.isEmpty) {
      showError(context, 'Please enter jersey number');
      return;
    }
    // if (email.isEmpty || !email.contains('@')) {
    //   showError(context, 'Please enter a valid email');
    //   return;
    // }
    // if (phone.isEmpty || phone.length < 7) {
    //   showError(context, 'Please enter a valid phone number');
    //   return;
    // }

    final player = PlayerInputModel(
      playerCountry: country,
      playerLastName: lastName,
      playerJerseyNumber: jerseyNumber,
      playerEmail: email,
      playerPhone: phone,
      id: teamId ?? createTeamResponse.value?.id!,
    );

    final response = await TeamsApi.addPlayer(
      player,
    ); // Replace with `loginUser()` if needed

    if (response.success!) {
      addPlayerResponse.value = response!.data!;
      clearPlayerFormFields();
      teamController.fetchGetPlayer(player.id!);
      // Get.toNamed(RoutesPath.mainDashboardScreen);
      SnackbarUtils.showSuccess('User Add Player in successfully');
      // Get.snackbar('Success', 'User Add Player in successfully');
      // Navigate to home or dashboard
    }
  }



  Future<void> addPlayers(BuildContext context, {int? teamId}) async {
    final country = playerCountryController.text;
    final lastName = playerLastNameController.text;
    final jerseyNumber = playerJerseyNumberController.text;
    final email = playerEmailController.text;
    final phone = playerPhoneController.text;

    if (country.isEmpty) {
      showError(context, 'Please enter player country');
      return;
    }
    if (lastName.isEmpty) {
      showError(context, 'Please enter player last name');
      return;
    }
    if (jerseyNumber.isEmpty) {
      showError(context, 'Please enter jersey number');
      return;
    }
    // if (email.isEmpty || !email.contains('@')) {
    //   showError(context, 'Please enter a valid email');
    //   return;
    // }
    // if (phone.isEmpty || phone.length < 7) {
    //   showError(context, 'Please enter a valid phone number');
    //   return;
    // }

    final player = PlayerInputModel(
      playerCountry: country,
      playerLastName: lastName,
      playerJerseyNumber: jerseyNumber,
      playerEmail: email,
      playerPhone: phone,
      id:teamController.teamData.value!.id!,
    );

    final response = await TeamsApi.addPlayer(
      player,
    ); // Replace with `loginUser()` if needed

    if (response.success!) {
      addPlayerResponse.value = response!.data!;
      clearPlayerFormFields();
      teamController.fetchGetPlayer(player.id!);
      // Get.toNamed(RoutesPath.mainDashboardScreen);
      SnackbarUtils.showSuccess('User Add Player in successfully');
      // Get.snackbar('Success', 'User Add Player in successfully');
      // Navigate to home or dashboard
    }
  }
  void clearPlayerFormFields() {
    playerCountryController.clear();
    playerLastNameController.clear();
    playerJerseyNumberController.clear();
    playerEmailController.clear();
    playerPhoneController.clear();
  }
  void clearGameFormFields() {
    opponentController.clear();
    dateController.clear();
    insController.clear();
    type.value = ''; // Assuming `type` is an RxString or observable.
  }

  void clearTeamFormFields() {
    teamNameController.clear();
    sportType.value = '';
    teamType.value = '';
    ageGroupController.clear();
    seasonController.clear();
    cityController.clear();
    countryController.clear();
    organizationId.value = 0; // or 0, depending on its type
  }

}
