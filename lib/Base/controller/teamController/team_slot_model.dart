class TeamSlotModel {
  final int availableTeamSlotsCount;

  TeamSlotModel({required this.availableTeamSlotsCount});

  factory TeamSlotModel.fromJson(Map<String, dynamic> json) {
    return TeamSlotModel(
      availableTeamSlotsCount: json['available_team_slots_count'] ?? 0,
    );
  }
}
