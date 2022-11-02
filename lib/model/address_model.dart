class Address {
  Address({
    required this.city,
  });

  String city = '';

  Address.fromJson(Map<String, dynamic> json) {
    city = json["city"];
  }

  Map<String, dynamic> toMap() => {
        "city": city,
      };
}
