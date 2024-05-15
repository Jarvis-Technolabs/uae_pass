abstract class UAEPassWebViewEvent {}

class UAEPassWebViewPageInitialEvent extends UAEPassWebViewEvent {
  UAEPassWebViewPageInitialEvent();
}

class SetUAEPassLoginAuthenticationUrlEvent extends UAEPassWebViewEvent {
  final String authenticationUrl;

  SetUAEPassLoginAuthenticationUrlEvent({required this.authenticationUrl});
}

class FetchUAEPassProfileEvent extends UAEPassWebViewEvent {
  final String accessToken;

  FetchUAEPassProfileEvent({required this.accessToken});
}

class ErrorEvent extends UAEPassWebViewEvent {
  final String? error;
  final int apiStatus;

  ErrorEvent(this.error, this.apiStatus);
}
