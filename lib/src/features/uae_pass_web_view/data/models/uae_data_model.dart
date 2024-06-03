class UAEDataModel {
  String? idType;
  String? sub;
  String? spuuid;
  String? lastnameEN;
  String? firstnameEN;
  String? nationalityAR;
  String? idn;
  String? userType;
  String? fullnameAR;
  String? email;
  String? fullnameEN;
  String? firstnameAR;
  String? nationalityEN;
  String? domain;
  String? gender;
  String? lastnameAR;
  String? uuid;
  String? acr;
  String? mobile;

  UAEDataModel({
    this.idType,
    this.sub,
    this.spuuid,
    this.lastnameEN,
    this.firstnameEN,
    this.nationalityAR,
    this.idn,
    this.userType,
    this.fullnameAR,
    this.email,
    this.fullnameEN,
    this.firstnameAR,
    this.nationalityEN,
    this.domain,
    this.gender,
    this.lastnameAR,
    this.uuid,
    this.acr,
    this.mobile,
  });

  UAEDataModel.fromJson(Map<String, dynamic> json) {
    idType = json['idType'] ?? "";
    sub = json['sub'] ?? "";
    spuuid = json['spuuid'] ?? "";
    lastnameEN = json['lastnameEN'] ?? "";
    firstnameEN = json['firstnameEN'] ?? "";
    nationalityAR = json['nationalityAR'] ?? "";
    idn = json['idn'] ?? "";
    userType = json['userType'] ?? "";
    fullnameAR = json['fullnameAR'] ?? "";
    email = json['email'] ?? "";
    fullnameEN = json['fullnameEN'] ?? "";
    firstnameAR = json['firstnameAR'] ?? "";
    nationalityEN = json['nationalityEN'] ?? "";
    domain = json['domain'] ?? "";
    gender = json['gender'] ?? "";
    lastnameAR = json['lastnameAR'] ?? "";
    uuid = json['uuid'] ?? "";
    acr = json['acr'] ?? "";
    mobile = json['mobile'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idType'] = idType;
    data['sub'] = sub;
    data['spuuid'] = spuuid;
    data['lastnameEN'] = lastnameEN;
    data['firstnameEN'] = firstnameEN;
    data['nationalityAR'] = nationalityAR;
    data['idn'] = idn;
    data['userType'] = userType;
    data['fullnameAR'] = fullnameAR;
    data['email'] = email;
    data['fullnameEN'] = fullnameEN;
    data['firstnameAR'] = firstnameAR;
    data['nationalityEN'] = nationalityEN;
    data['domain'] = domain;
    data['gender'] = gender;
    data['lastnameAR'] = lastnameAR;
    data['uuid'] = uuid;
    data['acr'] = acr;
    data['mobile'] = mobile;
    return data;
  }

  @override
  String toString() =>
      'UAEDataModel{idType: $idType, sub: $sub, spuuid: $spuuid, lastnameEN: $lastnameEN, firstnameEN: $firstnameEN, nationalityAR: $nationalityAR, idn: $idn, userType: $userType, fullnameAR: $fullnameAR, email: $email, fullnameEN: $fullnameEN, firstnameAR: $firstnameAR, nationalityEN: $nationalityEN, domain: $domain, gender: $gender, lastnameAR: $lastnameAR, uuid: $uuid, acr: $acr, mobile: $mobile}';
}
