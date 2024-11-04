class AddHorseRequestModel {
  int? disciplineId;
  int? stableId;
  String? name;
  String? image;
  String? dateOfBirth;
  String? placeOfBirth;
  String? color;
  String? gender;
  String? bloodLine;
  String? breed;

  AddHorseRequestModel(
      {
        this.disciplineId,
        this.stableId,
        this.name,
        this.image,
        this.dateOfBirth,
        this.placeOfBirth,
        this.color,
        this.gender,
        this.bloodLine,
        this.breed});

  AddHorseRequestModel.fromJson(Map<String, dynamic> json) {
    disciplineId = json['disciplineId'];
    stableId = json['stableId'];
    name = json['name'];
    image = json['image'];
    dateOfBirth = json['dateOfBirth'];
    placeOfBirth = json['placeOfBirth'];
    color = json['color'];
    gender = json['gender'];
    bloodLine = json['bloodLine'];
    breed = json['breed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['disciplineId'] = disciplineId;
    data['stableId'] = stableId;
    data['name'] = name;
    data['image'] = image;
    data['dateOfBirth'] = dateOfBirth;
    data['placeOfBirth'] = placeOfBirth;
    data['color'] = color;
    data['gender'] = gender;
    data['bloodLine'] = bloodLine;
    data['breed'] = breed;
    return data;
  }
}