class UAEPassAccessToken {
  String? grantType;
  String? code;
  String? redirectUri;

  UAEPassAccessToken({
    this.grantType,
    this.code,
    this.redirectUri,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['grant_type'] = grantType;
    data['code'] = code;
    data['redirect_uri'] = redirectUri;
    return data;
  }
}
