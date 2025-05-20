import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';
import 'package:gaming_web_app/screens/main_dashboard/primary_dropdown_field.dart'; // Import the new dropdown field

// This class represents a screen for adding or editing player positions
// It allows selecting a position name and category from predefined lists
class AddPositionScreen extends StatefulWidget {
  // Controllers to manage the text input values, passed from parent widget
  final TextEditingController positionNameController;
  final TextEditingController positionCategoryController;

  // Constructor requires both text controllers to be provided
  AddPositionScreen({
    super.key,
    required this.positionNameController, // Controls position name value
    required this.positionCategoryController, // Controls position category value
  });

  @override
  // Create the state that will manage this widget's behavior
  State<AddPositionScreen> createState() => _AddPositionScreenState();
}

// State class that holds the mutable state for the AddPositionScreen
class _AddPositionScreenState extends State<AddPositionScreen> {
  // List of available baseball positions (P=Pitcher, C=Catcher, etc.)
  final List<String> positions = [
    'P',
    'C',
    '1B',
    '2B',
    '3B',
    'SS',
    'LF',
    'CF',
    'RF',
  ];

  // List of position categories (INF=Infield, OF=Outfield, NA=Not Applicable)
  final List<String> categories = ['INF', 'OF', 'NA'];

  // Variables to track currently selected values in the dropdown menus
  String?
  selectedPosition; // Currently selected position (null if nothing selected)
  String?
  selectedCategory; // Currently selected category (null if nothing selected)

  @override
  Widget build(BuildContext context) {
    // Main layout is a vertical column of widgets
    return Column(
      children: [
        // Add vertical spacing at the top (16 height units)
        SizedBox(height: 16.h),

        // Title text for the screen
        Text(
          'Edit POSITION',
          style: tableContentHeader.copyWith(
            color: AppColors.primaryColor, // Use the app's primary color
            fontSize: 25.sp, // Size responsive to screen size
          ),
        ),

        // More vertical spacing (24 height units)
        SizedBox(height: 24.h),

        // Position Name Dropdown selector
        PrimaryDropdownField(
          label: 'Position Name', // Label above the dropdown
          items: positions, // List of position options
          value: selectedPosition, // Currently selected value
          hintText: 'Select Position', // Text shown when nothing is selected
          onChanged: (value) {
            // When user selects a new position:
            setState(() {
              // 1. Update the selectedPosition variable
              selectedPosition = value;
              // 2. Update the text controller's value to match
              widget.positionNameController.text = value!;
            });
          },
        ),

        // Category Dropdown selector
        PrimaryDropdownField(
          label: 'Category', // Label above the dropdown
          items: categories, // List of category options
          value: selectedCategory, // Currently selected value
          hintText: 'Select Category', // Text shown when nothing is selected
          onChanged: (value) {
            // When user selects a new category:
            setState(() {
              // 1. Update the selectedCategory variable
              selectedCategory = value;
              // 2. Update the text controller's value to match
              widget.positionCategoryController.text = value!;
            });
          },
        ),

        // Vertical spacing (20 pixels)
        SizedBox(height: 20),

        // Row containing the action buttons
        Row(
          // Space buttons evenly across the row
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // Center the buttons vertically
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Delete Position button
            ElevatedButton(
              // When pressed, close this screen and return to previous screen
              onPressed: () {
                Navigator.pop(context); // Close the current screen
              },
              // Button styling
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor, // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r), // Rounded corners
                ),
              ),
              // Button text
              child: Text(
                "Delete Position",
                style: tableLabel.copyWith(color: Colors.white), // White text
              ),
            ),

            // Save Position button
            ElevatedButton(
              // When pressed, close this screen and return to previous screen
              // In a real app, this would also save the selected values to database
              onPressed: () {
                Navigator.pop(context); // Close the current screen
              },
              // Button styling
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    AppColors.secondaryColor, // Secondary color background
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r), // Rounded corners
                ),
              ),
              // Button text
              child: Text(
                "Save Position",
                style: tableLabel.copyWith(color: Colors.white), // White text
              ),
            ),
          ],
        ),
      ],
    );
  }
}
