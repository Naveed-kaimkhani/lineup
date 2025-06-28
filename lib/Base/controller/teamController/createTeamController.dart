
import 'package:gaming_web_app/Base/controller/teamController/teamController.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/screens/main_dashboard/create_a_new_team_dialog.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../routes/routes_path.dart';
import '../../../screens/admin/adminController/orginatizationDialog.dart';
import '../../../service/api/adminApi.dart';
import '../../../service/api/team.dart';
import '../../../utils/SharedPreferencesUtil.dart';
import '../../../utils/snabarError.dart';
import '../../../utils/snackbarUtils.dart';
import '../../model/game/addNewGame.dart';
import '../../model/player/addPaler.dart';
import '../../model/player/addPlayerResponse.dart';
import '../../model/promoCodeReq.dart';
import '../../model/teamModel/createModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final isHavingCredit = false.obs; // RxBool

  final year = 0.obs; // optional
  final city = ''.obs; // optional
  final state = ''.obs; // optional
  // final organizationId = 0.obs;  // optional
  TextEditingController orgCode = TextEditingController();
  TextEditingController PromoCode = TextEditingController();

  TextEditingController orgCodeValidationController = TextEditingController();

  // TextEditingControllers (for text fields if needed)
  final TextEditingController teamNameController = TextEditingController();
  int? organizationId;
  final TextEditingController ageGroupController = TextEditingController(
    text: "2025",
  );
  final TextEditingController enterAgeGroupController = TextEditingController();
  final TextEditingController seasonController = TextEditingController();
  final TextEditingController countryController = TextEditingController(
    text: "xyz",
  );
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

      currentPage.value++;
      updateDimensions(context);
      updateDimensions(context);
    }
  }

  void goToPrevious(BuildContext context) async {
    SnackbarUtils.showErrorr('Please Fill All Next Requirement'.toString());
    if (currentPage.value > 0 && currentPage.value < 6) {
      await pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      currentPage.value--;
      updateDimensions(context);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> pageIndex(BuildContext context) async {
    if (currentPage.value == 0) {
      if (sportType.value.isEmpty) {
        SnackbarUtils.showErrorr('Please set all required values'.toString());
      } else {
        _goToNext(context);
      }
    }

    if (currentPage.value == 1) {
      if (teamNameController.text.trim().isEmpty) {
        SnackbarUtils.showErrorr('Please enter team name');
      }
      //  else if (!isHavingCredit.value && orgCode.text.trim().isEmpty) {
      //   SnackbarUtils.showErrorr('Please enter organization code');
      // }
      else {
        if (isHavingCredit.value) {
          _goToNext(context); // ✅ Credit available, skip promo code check
        } else {
          // final loader = Get.find<LoaderController>();
          // loader.isLoading.value = true; // 🔄 Show loader

          // final isValid = await TeamsApi.validatePromoCode(orgCode.text.trim());

          _goToNext(context);
          // loader.isLoading.value = false; // 🔄 Hide loader

          // if (isValid) {
          //   _goToNext(context);
          // } else {
          //   // SnackbarUtils.showErrorr('Invalid Organization Code');
          // }
        }
      }
    }

    if (currentPage.value == 2) {
      if (teamType.value.isEmpty) {
        SnackbarUtils.showErrorr('Please set values'.toString());
      } else {
        _goToNext(context);
      }
    }

    if (currentPage.value == 3) {
      if (enterAgeGroupController.text.isEmpty) {
        // _goToNext(context);
        SnackbarUtils.showErrorr('Please Enter value '.toString());
      } else {
        _goToNext(context);
      }
    }

    if (currentPage.value == 4) {
      if (ageGroupController.text.trim().isEmpty) {
        SnackbarUtils.showErrorr('Please Enter value '.toString());
      } else {
        if (ageGroupController.text.length == 4) {
          _goToNext(context);
        } else {
          SnackbarUtils.showErrorr('Please Enter 4 digit '.toString());
        }
      }
    }

    if (currentPage.value == 5) {
      if (seasonController.text.trim().isEmpty) {
        SnackbarUtils.showErrorr('Please select  values'.toString());
      } else {
        _goToNext(context);
      }
    }

    if (currentPage.value == 6) {
      if (cityController.text.isEmpty || stateController.text.isEmpty) {
        SnackbarUtils.showErrorr('Please select  values'.toString());
      } else {
        // CreateNewTeam(context);
        _goToNext(context);
      }
    }

    if (currentPage.value == 7) {
      // CreateNewTeam(context);
      showConfirmationDialog(
        title: "Confirm",
        message: "Are you sure you want to create the team?",
        onConfirm: () {
          CreateNewTeam(context);
        },
        onCancel: () {
          Get.back();

          clearAllFields();
        },
      );

      // dfdf
    }

    if (currentPage.value == 8) {
      _goToNext(context);
    }
    if (currentPage.value == 9) {
      // playerPreference

      addPsitionedInPlayers(context);
    }
  }

  Future<void> launchPayUrl(String link) async {
    final Uri url = Uri.parse(link);
    // final Uri url = Uri.parse('http://18.189.193.38/teams/${createTeamResponse.value?.id}/pay');
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication, // launches in browser
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  final paymentController = Get.put(PaymentController());

  RxDouble dialogHeight = 0.0.obs;
  RxDouble dialogWidth = 0.0.obs;
  void initDimensions(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // Set initial dimensions
    updateDimensions(context);
  }

  void clearAllFields() {
    orgCode.clear();
    PromoCode.clear();
    orgCodeValidationController.clear();

    teamNameController.clear();
    ageGroupController.clear();
    enterAgeGroupController.clear();
    seasonController.clear();
    countryController.clear();
    cityController.clear();
    stateController.clear();

    // organizationId = null;
  }

  static void showConfirmationDialog({
    required String title,
    required String message,
    required VoidCallback onConfirm,

    required VoidCallback onCancel,
    Color titleColor = Colors.black,
    // Color confirmButtonColor = AppColors.primaryColor,
    Color cancelButtonColor = Colors.grey,
  }) {
    Get.dialog(
      Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      color: titleColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onCancel,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: cancelButtonColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.back(); // Dismiss dialog first
                            onConfirm(); // Then call action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Yes",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  Future<void> getOrgCode(BuildContext context) async {
    try {
      // Call the API to get the list of teams
      final response = await AdminApi.orgCodeReq(orgCode.text.trim());

      // Check if the response contains data and update the teams list
      if (response.success!) {
        _goToNext(context);
        organizationId = response.data!.organizationId;
        SnackbarUtils.showSuccess(response.message.toString());
      } else {
        SnackbarUtils.showErrorr(response.message.toString());
        // Handle the case where no teams are returned
        // teams.value = [];
      }
    } catch (e) {
      // Handle any errors that occur
      print('Error fetching teams: $e');
    }
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
      case 2:
        dialogHeight.value =
            screenHeight * 0.43; // Reduced from 0.7 to prevent overflow
        break;
      case 3:
        dialogHeight.value =
            screenHeight * 0.43; // Reduced from 0.7 to prevent overflow
        break;

      case 4:
        dialogHeight.value =
            screenHeight * 0.43; // Reduced from 0.7 to prevent overflow
        break;
      case 5:
        dialogHeight.value =
            screenHeight * 0.43; // Reduced from 0.7 to prevent overflow
        break;
      case 6:
        dialogHeight.value =
            screenHeight * 0.43; // Reduced from 0.7 to prevent overflow
        break;
      default:
        dialogHeight.value = screenHeight * 0.70;
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
        dialogWidth.value = screenWidth * 0.5 > 500 ? 500 : screenWidth * 0.5;
        break;
      case 5:
        dialogWidth.value = screenWidth * 0.5 > 500 ? 500 : screenWidth * 0.5;
        break;
      case 6:
        dialogWidth.value = screenWidth * 0.5 > 500 ? 500 : screenWidth * 0.5;
        break;
      case 7:
        dialogWidth.value =
            screenWidth * 0.70 > 1000 ? 1000 : screenWidth * 0.70;
        break;
      default:
        dialogWidth.value = screenWidth * 1.2 > 900 ? 900 : screenWidth * 1.2;
    }
  }

  Future<void> promoCodeReq(BuildContext context) async {
    try {
      final request = PromoCodeRequest(code: PromoCode.text.trim());
      final response = await AdminApi.promocodeReq(request);
      if (response.success == true) {
        final NewTeamController newTeamController =
            Get.find<NewTeamController>();
        newTeamController.isHavingCredit.value = true;

        await Get.dialog(CreateTeamDialog(), barrierDismissible: true);
      } else {
        SnackbarUtils.showErrorr(response.message ?? "");
      }
    } catch (e) {
      // Handle any errors that occur
      print('Error fetching teams: $e');
    }
  }

  Future<void> valideOrgCode(BuildContext context, String orgCode) async {
    try {
      // final request = PromoCodeRequest(code: PromoCode.text.trim());
      final response = await TeamsApi.validatePromoCode(orgCode);
      if (response) {
        await Get.dialog(CreateTeamDialog(), barrierDismissible: true);
      } else {
        // SnackbarUtils.showErrorr(response.message ?? "");
      }
    } catch (e) {
      // Handle any errors that occur
      print('Error fetching teams: $e');
    }
  }

  Future<void> promoCodeRenewalRequest(BuildContext context) async {
    try {
      final request = PromoCodeRequest(code: PromoCode.text.trim());
      final response = await AdminApi.promocodeRenewalReq(request);
    } catch (e) {
      // Handle any errors that occur
      print('Error fetching teams: $e');
    }
  }

  void promoCodeDialog(BuildContext context) async {
    Get.dialog(
      PromoCodeDialog(
        nameController: PromoCode,

        onSubmit: () async {
          final name = PromoCode.text.trim();

          // Perform your validation or logic here
          if (name.isEmpty) {
            Get.snackbar("Error", "Please enter a Promo Code");
          } else {
            promoCodeReq(context);
            Get.back(); // Close dialog
            Get.back(); // Close dialog
          }
        },
      ),
    );
  }

  void orgCodeDialog(BuildContext context) async {
    Get.dialog(
      OrgCodeDialog(
        nameController: orgCodeValidationController,

        onSubmit: () async {
          final name = orgCodeValidationController.text.trim();

          // Perform your validation or logic here
          if (name.isEmpty) {
            Get.snackbar("Error", "Please enter a Organization Code");
          } else {
            valideOrgCode(context, name);
            Get.back(); // Close dialog
            // Get.back(); // Close dialog
          }
        },
      ),
    );
  }

  void promoCodeDialogForOrg(BuildContext context) async {
    Get.dialog(
      PromoCodeDialog(
        nameController: PromoCode,

        onSubmit: () async {
          final name = PromoCode.text.trim();

          // Perform your validation or logic here
          if (name.isEmpty) {
            Get.snackbar("Error", "Please enter a Promo Code");
          } else {
            promoCodeRenewalRequest(context);
            Get.back(); // Close dialog
            Get.back(); // Close dialog
          }
        },
      ),
    );
  }

  CreateTeam getCreateTeamModel() {
    return CreateTeam(
      name: teamNameController.text.trim(),
      sportType: sportType.value.toLowerCase(),
      teamType: teamType.value.toLowerCase(),
      ageGroup: enterAgeGroupController.text,
      season: seasonController.text,
      year: int.parse(ageGroupController.text),

      city: cityController.text,
      state: countryController.text,
      organizationId: orgCodeValidationController.text,
    );
  }

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  Future<void> CreateNewTeam(BuildContext context) async {
    if (true) {
      try {
        final response = await TeamsApi.createTeam(
          getCreateTeamModel(),
        ); // Replace with `loginUser()` if needed

        if (response.success!) {
          clearTeamFormFields();
          _goToNext(context);
          teamController.getPlayer.clear();
          createTeamResponse.value = response.data!;
          teamController.fetchGetPlayer(createTeamResponse.value!.id!);
          // Get.toNamed(RoutesPath.mainDashboardScreen);
          SnackbarUtils.showSuccess('Your Team Created Successfully');
          // Navigate to home or dashboard
          // Get.toNamed(RoutesPath.home);
        } else {
          SnackbarUtils.showErrorr(response.message ?? 'Something went wrong');
          // Get.snackbar('Error', response.message ?? 'Something went wrong');
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
  var type = "away".obs;
  // Text controllers
  final TextEditingController opponentController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  RxString datess = "".obs;
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
    final prefs = await SharedPreferences.getInstance();
    final id = await prefs.getInt('teamInfoId'); // returns null if not found
    final response = await TeamsApi.CreateNewGame(addGame, id!);

    if (response.success!) {
      Get.snackbar(
        "Success",
        response.message.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      clearGameFormFields();

      try {
        await SharedPreferencesUtil.save(
          'gameID',
          response.data!.id.toString(),
        );
        await SharedPreferencesUtil.saveCurrentRoute(
          RoutesPath.teamDashboardScreen,
        );
        Navigator.pushNamed(context, RoutesPath.addNewPlayerScreen);
      } catch (e) {
        Navigator.pop(context);
      }
      // Navigator.pop(context);

      // Get.back();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        SnackbarUtils.showErrorr(response.message.toString());
        // Get.back();
      });
    }
  }

  ///  add paler
  Future<void> addPlayer(BuildContext context, {int? teamId}) async {
    final country = playerCountryController.text;
    final lastName = playerLastNameController.text;
    final jerseyNumber = playerJerseyNumberController.text;
    final email = playerEmailController.text;
    final phone = playerPhoneController.text;

    if (country.isEmpty) {
      SnackbarUtils.showErrorr('Please enter player country');
      return;
    }
    if (lastName.isEmpty) {
      showError(context, 'Please enter player last name');
      return;
    }
    if (jerseyNumber.isEmpty) {
      SnackbarUtils.showErrorr('Please enter jersey number');
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
      addPlayerResponse.value = response.data!;
      clearPlayerFormFields();
      teamController.fetchGetPlayer(player.id!);
    } else {
      SnackbarUtils.showErrorr(response.message.toString());
    }
  }

  void getPlayer() {
    teamController.fetchGetPlayer(createTeamResponse.value!.id!);
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
      dateController.text = formattedDate;
      datess.value = dateController.text.toString();
      // You can now use this formattedDate as needed
    }
  }

  Future<void> addPlayers(BuildContext context, {int? teamId}) async {
    final country = playerCountryController.text;
    final lastName = playerLastNameController.text;
    final jerseyNumber = playerJerseyNumberController.text;
    final email = playerEmailController.text;
    final phone = playerPhoneController.text;

    if (country.isEmpty) {
      SnackbarUtils.showErrorr('Please enter player country');
      return;
    }
    if (lastName.isEmpty) {
      showError(context, 'Please enter player last name');
      return;
    }
    if (jerseyNumber.isEmpty) {
      SnackbarUtils.showErrorr('Please enter jersey number');
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
      id: teamController.teamData.value!.id!,
    );

    final response = await TeamsApi.addPlayer(
      player,
    ); // Replace with `loginUser()` if needed

    if (response.success!) {
      addPlayerResponse.value = response!.data!;
      clearPlayerFormFields();
      teamController.fetchGetPlayer(player.id!);
      // Get.toNamed(RoutesPath.mainDashboardScreen);
      SnackbarUtils.showSuccess(response.message.toString());
      // Get.snackbar('Success', 'User Add Player in successfully');
      // Navigate to home or dashboard
    } else {
      SnackbarUtils.showErrorr(response.message.toString());
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
    orgCode.clear();
    teamNameController.clear();
    sportType.value = '';
    teamType.value = '';
    ageGroupController.clear();
    seasonController.clear();
    cityController.clear();
    countryController.clear();
    organizationId = null; // or 0, depending on its type
  }

  Future<void> addPsitionedInPlayers(BuildContext context) async {
    final response = await TeamsApi.playerPositionedAdd(
      teamController.playerPreference,
      createTeamResponse.value!.id,
    );

    if (response.success!) {
      SnackbarUtils.showSuccess(response.message!);
      // Navigator.pop(context);
      Get.offAndToNamed(RoutesPath.mainDashboardScreen);
    } else {
      SnackbarUtils.showErrorr(response.message.toString());
      print('No team data saved');
    }
  }
}
