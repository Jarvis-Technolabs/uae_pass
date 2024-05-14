class UAEPassAccessToken {
  String? grant_type;
  String? code;
  String? redirect_uri;

  UAEPassAccessToken({
    this.grant_type,
    this.code,
    this.redirect_uri,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['grant_type'] = this.grant_type;
    data['code'] = this.code;
    data['redirect_uri'] = this.redirect_uri;
    return data;
  }
}
