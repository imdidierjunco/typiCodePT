class Company {
  Company({
    required this.name,
  });

  String name = '';

  factory Company.fromJsonMap(Map<String, dynamic> json) => Company(
        name: json["name"],
      );

  Company.fromJson(Map<String, dynamic> json) {
    name = json["name"];
  }

  Map<String, dynamic> toMap() => {
        "name": name,
      };
}
