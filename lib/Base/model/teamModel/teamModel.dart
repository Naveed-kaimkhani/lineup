import 'dart:developer';

class Team {
  int id;
  int userId;
  int organizationId;
  String name;
  String season;
  int year;
  String sportType;
  String teamType;
  String ageGroup;
  String city;
  String state;
  String createdAt;
  String updatedAt;
  String accessStatus;
  String? accessExpiresAt;
  Organizations? organization;
  List<Game> games;
  List<Player> players;

  Team({
    required this.id,
    required this.userId,
    required this.organizationId,
    required this.name,
    required this.season,
    required this.year,
    required this.sportType,
    required this.teamType,
    required this.ageGroup,
    required this.city,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
    required this.accessStatus,
    this.accessExpiresAt,
   this.organization,
    required this.games,
    required this.players,
  });

  factory Team.fromJson(Map<String, dynamic> json) {

    return Team(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      organizationId: json['organization_id'] ?? 0,
      name: json['name'] ?? '',
      season: json['season'] ?? '',
      year: json['year'] ?? 0,
      sportType: json['sport_type'] ?? '',
      teamType: json['team_type'] ?? '',
      ageGroup: json['age_group'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      accessStatus: json['access_status'] ?? '',
      accessExpiresAt: json['access_expires_at'],
        organization:
        json['organization'] != null
            ? Organizations.fromJson(json['organization'])
            : null,
      games: [],
      // games: (json['games'] as List)
      //     .map((gameJson) => Game.fromJson(gameJson))
      //     .toList(),
      players: []
      // (json['players'] as List)
      //     .map((playerJson) => Player.fromJson(playerJson))
      //     .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'organization_id': organizationId,
      'name': name,
      'season': season,
      'year': year,
      'sport_type': sportType,
      'team_type': teamType,
      'age_group': ageGroup,
      'city': city,
      'state': state,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'access_status': accessStatus,
      'access_expires_at': accessExpiresAt,
      'organization': organization?.toJson(),
      'games': games.map((game) => game.toJson()).toList(),
      'players': players.map((player) => player.toJson()).toList(),
    };
  }
}



class Player {
  int id;
  int teamId;
  String firstName;
  String lastName;
  String jerseyNumber;
  String email;

  Player({
    required this.id,
    required this.teamId,
    required this.firstName,
    required this.lastName,
    required this.jerseyNumber,
    required this.email,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'] ?? 0,
      teamId: json['team_id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      jerseyNumber: json['jersey_number'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'team_id': teamId,
      'first_name': firstName,
      'last_name': lastName,
      'jersey_number': jerseyNumber,
      'email': email,
    };
  }
}





class Game {
  int id;
  int teamId;
  String opponentName;
  String gameDate;
  int innings;
  String locationType;
  List<dynamic> lineupData;
  String? submittedAt;
  String createdAt;
  String updatedAt;

  Game({
    required this.id,
    required this.teamId,
    required this.opponentName,
    required this.gameDate,
    required this.innings,
    required this.locationType,
    required this.lineupData,
    this.submittedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'] ?? 0,
      teamId: json['team_id'] ?? 0,
      opponentName: json['opponent_name'] ?? '',
      gameDate: json['game_date'] ?? '',
      innings: json['innings'] ?? 0,
      locationType: json['location_type'] ?? '',
      lineupData: List<dynamic>.from(json['lineup_data'] ?? []),
      submittedAt: json['submitted_at'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'team_id': teamId,
      'opponent_name': opponentName,
      'game_date': gameDate,
      'innings': innings,
      'location_type': locationType,
      'lineup_data': lineupData,
      'submitted_at': submittedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}




class Organizations {
  int? id;
  String? name;
  String? email;
  String? createdAt;
  String? updatedAt;

  Organizations({
   this.id,
   this.name,
   this.email,
   this.createdAt,
   this.updatedAt,
  });

  factory Organizations.fromJson(Map<String, dynamic> json) {

    return Organizations(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
