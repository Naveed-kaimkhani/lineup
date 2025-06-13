class Position {
  final int? id;
  final String? name;
  final String? category;
  final String? display_name;
  final int? isEditable;

  Position({
     this.id,
     this.name,
    this.category,
    this.display_name,
  this.isEditable,
  });

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      display_name: json['display_name'],
      isEditable: json['is_editable'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'display_name': display_name,
      'category': category,
      'is_editable': isEditable,
    };

  }



  Position copyWith({
    int? id,
    String? name,
    String? category,
    String? display_name,
    int? isEditable,
  }) {
    return Position(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      display_name: display_name ?? this.display_name,
      isEditable: isEditable ?? this.isEditable,
    );
  }




  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}
