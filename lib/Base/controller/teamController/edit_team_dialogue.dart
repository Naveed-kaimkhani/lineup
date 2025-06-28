import 'package:flutter/material.dart';
import 'package:gaming_web_app/Base/controller/teamController/EditTeamController.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:get/get.dart';

void showEditTeamDialog(String teamId, {Map<String, String>? hints}) {
  final controller = Get.put(CreateTeamViewModel());

  // Initialize controllers with passed hints
  controller.teamNameController.text = hints?['teamName'] ?? "";
  controller.enterAgeGroupController.text = hints?['ageGroup'] ?? "";
  controller.seasonController.text = hints?['season'] ?? "";
  controller.ageGroupController.text = hints?['year'] ?? "";
  controller.cityController.text = hints?['city'] ?? "";
  controller.countryController.text = hints?['state'] ?? "";

  controller.sportType.value = hints?['sportType'] ?? "";

  controller.teamType.value = hints?['teamType'] ?? "";

  // Show themed dialog
  Get.dialog(
    Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Edit Team",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller.teamNameController,
                    "Team Name",
                    hints?['teamName'],
                  ),
                  _buildTextField(
                    controller.enterAgeGroupController,
                    "Age Group",
                    hints?['ageGroup'],
                  ),
                  _buildTextField(
                    controller.seasonController,
                    "Season",
                    hints?['season'],
                  ),
                  _buildTextField(
                    controller.ageGroupController,
                    "Year",
                    hints?['year'],
                  ),
                  _buildTextField(
                    controller.cityController,
                    "City",
                    hints?['city'],
                  ),
                  _buildTextField(
                    controller.countryController,
                    "State",
                    hints?['state'],
                  ),
                  const SizedBox(height: 12),
                  _buildDropdown(
                    value:
                        controller.sportType.value.isEmpty
                            ? null
                            : controller.sportType.value,
                    hint: hints?['sportType'] ?? "Sport Type",
                    items: ['baseball', 'softball'],
                    onChanged: (val) => controller.sportType.value = val!,
                  ),
                  const SizedBox(height: 12),
                  _buildDropdown(
                    value:
                        controller.teamType.value.isEmpty
                            ? null
                            : controller.teamType.value,
                    hint: hints?['teamType'] ?? "Team Type",
                    items: ['travel', 'recreation', 'school'],
                    onChanged: (val) => controller.teamType.value = val!,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        onPressed: () => Get.back(),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black87,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          side: const BorderSide(color: Colors.black12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.updateTeam(teamId);
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text("Save"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _buildTextField(
  TextEditingController controller,
  String label,
  String? hint,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
      ),
    ),
  );
}

Widget _buildDropdown({
  required String? value,
  required String hint,
  required List<String> items,
  required ValueChanged<String?> onChanged,
}) {
  return DropdownButtonFormField<String>(
    value: value,
    onChanged: onChanged,
    decoration: InputDecoration(
      labelText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    ),
    items:
        items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
  );
}
