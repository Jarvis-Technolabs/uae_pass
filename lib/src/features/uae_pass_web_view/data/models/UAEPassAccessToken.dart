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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['grant_type'] = grant_type;
    data['code'] = code;
    data['redirect_uri'] = redirect_uri;
    return data;
  }
}
