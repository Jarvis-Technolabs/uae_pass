import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uae_pass/src/core/const/api_constants.dart';
import 'package:uae_pass/src/core/di/injection_container.dart';
import 'package:uae_pass/src/core/flavour/flavour_config.dart';
import 'package:uae_pass/src/features/uae_pass_web_view/data/models/uae_data_model.dart';
import 'package:uae_pass/src/features/uae_pass_web_view/data/models/uae_pass_access_token.dart';
import 'package:uae_pass/src/features/uae_pass_web_view/domain/uae_pass_repo.dart';

import 'uae_pass_web_view_event.dart';
import 'uae_pass_web_view_state.dart';

class UAEPassWebViewBloc
    extends Bloc<UAEPassWebViewEvent, UAEPassWebViewState> {
  UaePassRepo? uaePassRepo = sl();

  UAEPassWebViewBloc() : super(UAEPassWebViewInitialState()) {
    on<FetchUAEPassProfileEvent>(fetchUAEPassProfile);
    on<SetUAEPassLoginAuthenticationUrlEvent>(setUAEPassLoginAuthenticationUrl);
    on<ErrorEvent>(errorEvent);
  }

  Future<void> fetchUAEPassProfile(
    FetchUAEPassProfileEvent fetchUAEPassProfileEvent,
    Emitter<UAEPassWebViewState> emit,
  ) async {
    UAEPassAccessToken uaePassAccessToken = UAEPassAccessToken(
      code: fetchUAEPassProfileEvent.accessToken,
      grant_type: KEY_AUTHORIZATION_CODE,
      redirect_uri: FlavourConfig.instance.redirectUrl,
    );
    final output =
        await uaePassRepo!.callUAEPassAccessToken(uaePassAccessToken);
    await output.fold(
      (failure) async {
        emit(ErrorState("", PROFILE_ERROR));
      },
      (responseToken) async {
        final userDataOutput =
            await uaePassRepo!.getUserData(responseToken.data);
        await userDataOutput.fold(
          (failure) async {
            emit(ErrorState("", PROFILE_ERROR));
          },
          (responseModel) async {
            UAEDataModel model = responseModel.data;
            if (model.userType == USER_TYPE_SOP1) {
              emit(
                ErrorState(
                  "",
                  PROFILE_ERROR_USER_TYPE_SOP1,
                  uaeDataModel: model,
                ),
              );
            } else {
              emit(
                FetchUAEPassProfileState(
                  uaeDataModel: model,
                ),
              );
            }
          },
        );
      },
    );
  }

  Future<void> setUAEPassLoginAuthenticationUrl(
    SetUAEPassLoginAuthenticationUrlEvent setUAEPassLoginAuthenticationUrlEvent,
    Emitter<UAEPassWebViewState> emit,
  ) async {
    emit(
      SetUAEPassLoginAuthenticationUrlState(
        authenticationUrl:
            setUAEPassLoginAuthenticationUrlEvent.authenticationUrl,
      ),
    );
  }

  Future<void> errorEvent(
    ErrorEvent errorEvent,
    Emitter<UAEPassWebViewState> emit,
  ) async {
    emit(
      ErrorState(
        errorEvent.error,
        errorEvent.apiStatus,
      ),
    );
  }
}
