class Room {
  final int? id;
  final String? name;
  final int? capacity;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Room({
    this.id,
    this.name,
    this.capacity,
    this.createdAt,
    this.updatedAt,
  });

  factory Room.fromJson(Map<String, dynamic>? data) {
    return Room(
      id: data?['id'],
      name: data?['name'],
      capacity: data?['capacity'],
      createdAt: DateTime.parse(data?['createdAt']),
      updatedAt: DateTime.parse(data?['updatedAt']),
    );
  }
}
