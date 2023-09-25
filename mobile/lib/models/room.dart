class Room {
  int? id;
  String? name;
  int? capacity;
  String? createdAt;
  String? updatedAt;
  bool? active;

  Room(
      {this.id,
      this.name,
      this.capacity,
      this.createdAt,
      this.updatedAt,
      this.active});

  Room.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    capacity = json['capacity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['capacity'] = capacity;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['active'] = active;
    return data;
  }
}
