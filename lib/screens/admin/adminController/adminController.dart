import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../Base/controller/getTeamData.dart';
import '../../../Base/model/adminModel/makeOrginization.dart';
import '../../../Base/model/adminModel/paymentTrackingModel.dart';
import '../../../Base/model/adminModel/promoCodeModel.dart';
import '../../../Base/model/getAllUser.dart';
import '../../../Base/model/positioned.dart';
import '../../../Base/model/teamModel/teamModel.dart';
import '../../../service/api/adminApi.dart';
import '../../../service/api/orginizationApi.dart';
import '../../../service/api/team.dart';
import '../../../utils/snackbarUtils.dart';
import 'orginatizationDialog.dart';

import 'package:http/http.dart' as http;
class AdminController extends GetxController {
  var organization = <Organizations?>[].obs; // flat list of Organizations

  Organizations? selectedOrganization;
  RxList<TeamData?> teamData = <TeamData?>[].obs;
  var orginizationNameController = TextEditingController();
  var orginizationEmail = TextEditingController();
  var organization_code = TextEditingController();

  final positionedNameController = TextEditingController();
  final positionedLabelController = TextEditingController();
  final positionedCategoryController = TextEditingController();

  RxList<UserListResponse> paginatedUserResponse = <UserListResponse>[].obs;
  RxList<Position> teamPositioned = <Position>[].obs;
  RxList<PaymentModel> paymentModel = <PaymentModel>[].obs;
  RxList<PromoCodeResponse> promoCodeResponse = <PromoCodeResponse>[].obs;

  // Rx<PaginatedUserResponse> paginatedUserResponse = PaginatedUserResponse().obs;

  RxInt selectedTab = 1.obs;

  Future<void> fetchAllUser() async {
    try {
      final response = await AdminApi.getUser();

      //
      if (response?.data != null) {
        paginatedUserResponse.value = response!.data!;

        update();
      } else {
        print('No user data found.');
      }
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  Future<void> fetchTeamsPositioned() async {
    try {
      // Call the API to get the list of teams
      final response = await AdminApi.adminPosition();

      // Check if the response contains data and update the teams list
      if (response.data != null && response.data!.isNotEmpty) {
        teamPositioned.value = response.data!.cast<Position>();
        teamPositioned.refresh();
        debugger();
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

  Future<void> fetchTeamsPayment() async {
    try {
      // Call the API to get the list of teams
      final response = await AdminApi.adminPayment();

      // Check if the response contains data and update the teams list
      if (response.data != null && response.data!.isNotEmpty) {
        paymentModel.value = response.data!.cast<PaymentModel>();

        debugger();
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

  Future<void> fetchPromoCode() async {
    try {
      // Call the API to get the list of teams
      final response = await AdminApi.getPromoCode();

      // Check if the response contains data and update the teams list
      if (response.data != null && response.data!.isNotEmpty) {
        teamPositioned.refresh();
        promoCodeResponse.value = response.data!.cast<PromoCodeResponse>();
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

  Future<void> fetchOrganization() async {
    try {
      // Call the API to get the list of teams
      final response = await OrginizationsApi.getOrganization();

      // Check if the response contains data and update the teams list
      if (response.data != null && response.data!.isNotEmpty) {
        organization.value = response.data!;
        organization = organization;
        update();
      } else {
        // Handle the case where no teams are returned
      }
    } catch (e) {
      // Handle any errors that occur
      print('Error fetching teams: $e');
    }
  }

  Future<void> updateOrganization(var team) async {
    try {
      final orginizationCreate = OrginizationCreate(
        name: orginizationNameController.text.trim(),
        email: orginizationEmail.text.trim(),
        id: team.id,
      );
      // Call the API to get the list of teams
      final response = await OrginizationsApi.updateOrginization(
        orginizationCreate,
      );

      // Check if the response contains data and update the teams list
      if (response.success!) {
        fetchOrganization();
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

  Future<void> adminCreateOrganization() async {
    try {
      log("hn bhai");
      final orginizationCreate = OrginizationCreate(
        name: orginizationNameController.text.trim(),
        email: orginizationEmail.text.trim(),
        organization_code: organization_code.text.trim(),
      );
      // Call the API to get the list of teams
      // if (int.tryParse(organization_code.text) == null) {
      //   SnackbarUtils.showErrorr("Organization code must be an integer");
      //   return;
      // }
      final response = await OrginizationsApi.createOrginization(
        orginizationCreate,
      );

      // Check if the response contains data and update the teams list
      if (response.success!) {
        fetchOrganization();
        SnackbarUtils.showSuccess("Organization Add Successfully");

        // SnackbarUtils.showSuccess("Hi jack");
      } else {
        log(response.message ?? "");
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

      // Check if the response contains data and update the teams list
      if (response.data != null && response.data!.isNotEmpty) {
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

  void createPositionedDialog(BuildContext context) {
    // final nameController = TextEditingController();
    // final emailController = TextEditingController();

    Get.dialog(
      PosisionedDialog(
        nameController: positionedNameController,
        labelController: positionedLabelController,
        categoryController: positionedCategoryController,
        onSubmit: () async {
          final name = positionedNameController.text.trim();
          final label = positionedLabelController.text.trim();
          final category = positionedCategoryController.text.trim();

          // Perform your validation or logic here
          if (name.isEmpty || label.isEmpty || category.isEmpty) {
            Navigator.pop(context);
            Get.snackbar("Error", "Please enter All Value");
          } else {
            final response = await AdminApi.createPosition(
              Position(
                name: label,
                category: category,
                display_name: name,
                isEditable: 1,
              ),
            );
            Navigator.pop(context);

            if (response.success!) {
              fetchTeamsPositioned();
              clearAllPositionedFields();
              Get.snackbar("Success", response.message.toString());
            } else {
              Get.snackbar("Error", response.message.toString());
            }

            // print("Name: $name, Email: $email");
            // You can call your controller method here
          }
        },
      ),
    );
  }

  void UpdatePositionedDialog(BuildContext context, Position position) {
    // final nameController = TextEditingController();
    // final emailController = TextEditingController();

    Get.dialog(
      PosisionedDialog(
        nameController: TextEditingController(
          text: position.display_name ?? "",
        ),
        labelController: TextEditingController(text: position.name ?? ""),
        categoryController: TextEditingController(
          text: position.category ?? "",
        ),
        onSubmit: () async {
          final name = position.display_name;
          final label = position.name;
          final category = position.category;

          // Perform your validation or logic here
          if (name!.isEmpty || label!.isEmpty || category!.isEmpty) {
            Navigator.pop(context);
            Get.snackbar("Error", "Please enter All Value");
          } else {
            final response = await AdminApi.updatePosition(position);
            Navigator.pop(context);

            if (response.success!) {
              fetchTeamsPositioned();
              clearAllPositionedFields();
              Get.snackbar("Success", response.message.toString());
            } else {
              Get.snackbar("Error", response.message.toString());
            }
          }
        },
      ),
    );
  }

  void showCreatePromoCodeDialog(
    BuildContext context,
    PromoCodeResponse promoCode,
  ) {
    final codeController = TextEditingController(text: promoCode.code);
    final descriptionController = TextEditingController(
      text: promoCode.description,
    );
    final expiresAtController = TextEditingController(
      text: promoCode.expiresAt,
    );
    final maxUsesController = TextEditingController(
      text: promoCode.maxUses.toString(),
    );
    final useCountController = TextEditingController(
      text: promoCode.useCount.toString(),
    );
    final maxUsesPerUserController = TextEditingController(
      text: promoCode.maxUsesPerUser.toString(),
    );

    Get.dialog(
      FCreatePromoCodeDialog(
        code: codeController,
        description: descriptionController,
        expires_at: expiresAtController,
        max_uses: maxUsesController,
        use_count: useCountController,
        max_uses_per_user: maxUsesPerUserController,
        onSubmit: () async {
          final code = codeController.text.trim();
          final description = descriptionController.text.trim();
          final expiresAt = expiresAtController.text.trim();
          final maxUses = maxUsesController.text.trim();
          final useCount = useCountController.text.trim();
          final maxUsesPerUser = maxUsesPerUserController.text.trim();

          final updatedPromoCode = PromoCodeResponse(
            id: promoCode.id,
            code: code,
            description: description,
            expiresAt: expiresAt,
            maxUses: int.tryParse(maxUses) ?? 0,
            useCount: int.tryParse(useCount) ?? 0,
            maxUsesPerUser: int.tryParse(maxUsesPerUser) ?? 0,
            isActive: true,
            createdAt: '',
            updatedAt: '',
          );

          final response = await AdminApi.createPromotoCode(
            request: updatedPromoCode,
            isBody: true,
          );

          if (response.success!) {
            Navigator.pop(context);
            fetchPromoCode(); // reload data
            Get.snackbar("Success", response.message ?? "Promo code updated");
          } else {
            Get.snackbar("Error", response.message ?? "Update failed");
          }
        },
      ),
    );
  }

  void showUpdatePromoCodeDialog(
    BuildContext context,
    PromoCodeResponse promoCode,
  ) {
    final codeController = TextEditingController(text: promoCode.code);
    final descriptionController = TextEditingController(
      text: promoCode.description,
    );
    final expiresAtController = TextEditingController(
      text: promoCode.expiresAt,
    );
    final maxUsesController = TextEditingController(
      text: promoCode.maxUses.toString(),
    );
    final useCountController = TextEditingController(
      text: promoCode.useCount.toString(),
    );
    final maxUsesPerUserController = TextEditingController(
      text: promoCode.maxUsesPerUser.toString(),
    );

    Get.dialog(
      FCreatePromoCodeDialog(
        code: codeController,
        description: descriptionController,
        expires_at: expiresAtController,
        max_uses: maxUsesController,
        use_count: useCountController,
        max_uses_per_user: maxUsesPerUserController,
        onSubmit: () async {
          final code = codeController.text.trim();
          final description = descriptionController.text.trim();
          final expiresAt = expiresAtController.text.trim();
          final maxUses = maxUsesController.text.trim();
          final useCount = useCountController.text.trim();
          final maxUsesPerUser = maxUsesPerUserController.text.trim();

          // if (code.isEmpty || description.isEmpty || expiresAt.isEmpty || maxUses.isEmpty || useCount.isEmpty || maxUsesPerUser.isEmpty) {
          //   Navigator.pop(context);
          //   Get.snackbar("Error", "Please fill in all fields.");
          //   return;
          // }

          final updatedPromoCode = PromoCodeResponse(
            id: promoCode.id,
            code: code,
            description: description,
            expiresAt: expiresAt,
            maxUses: int.tryParse(maxUses) ?? 0,
            useCount: int.tryParse(useCount) ?? 0,
            maxUsesPerUser: int.tryParse(maxUsesPerUser) ?? 0,
            isActive: true,
            createdAt: '',
            updatedAt: '',
          );

          final response = await AdminApi.updatePromotoCode(
            request: updatedPromoCode,
          );

          Navigator.pop(context);

          if (response.success!) {
            fetchPromoCode(); // reload data
            Get.snackbar("Success", response.message ?? "Promo code updated");
          } else {
            Get.snackbar("Error", response.message ?? "Update failed");
          }
        },
      ),
    );
  }

  void clearAllPositionedFields() {
    positionedNameController.clear();
    positionedLabelController.clear();
    positionedCategoryController.clear();
  }
}
