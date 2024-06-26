import 'package:ft_uaepass/src/features/uae_pass_web_view/data/models/uae_data_model.dart';

abstract class UAEPassWebViewState {}

class UAEPassWebViewInitialState extends UAEPassWebViewState {
  UAEPassWebViewInitialState();
}

class SetUAEPassLoginAuthenticationUrlState extends UAEPassWebViewState {
  final String authenticationUrl;

  SetUAEPassLoginAuthenticationUrlState({required this.authenticationUrl});
}

class FetchUAEPassProfileState extends UAEPassWebViewState {
  final UAEDataModel uaeDataModel;

  FetchUAEPassProfileState({required this.uaeDataModel});
}

class ErrorState extends UAEPassWebViewState {
  final String? errorMessage;
  final int apiStatus;
  final UAEDataModel? uaeDataModel;

  ErrorState(
    this.errorMessage,
    this.apiStatus, {
    this.uaeDataModel,
  });
}
