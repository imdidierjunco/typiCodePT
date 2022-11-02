class Company {
  Company({
    required this.name,
  });

  String name = '';

  Company.fromJson(Map<String, dynamic> json) {
    name = json["name"];
  }

  Map<String, dynamic> toMap() => {
        "name": name,
      };
}
