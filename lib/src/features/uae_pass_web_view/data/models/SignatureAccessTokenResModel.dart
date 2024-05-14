class SignatureAccessTokenResModel {
  String? scope;
  String? accessToken;
  String? tokenType;
  int? expiresIn;

  SignatureAccessTokenResModel(
      {this.scope, this.accessToken, this.tokenType, this.expiresIn});

  SignatureAccessTokenResModel.fromJson(Map<String, dynamic> json) {
    scope = json['scope'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
  }
}
