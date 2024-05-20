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

  Stream<UAEPassWebViewState> fetchUAEPassProfile(
    FetchUAEPassProfileEvent fetchUAEPassProfileEvent,
    Emitter<UAEPassWebViewState> emit,
  ) async* {
    UAEPassAccessToken uaePassAccessToken = UAEPassAccessToken(
      code: fetchUAEPassProfileEvent.accessToken,
      grant_type: KEY_AUTHORIZATION_CODE,
      redirect_uri: FlavourConfig.instance.redirectUrl,
    );
    final output =
        await uaePassRepo!.callUAEPassAccessToken(uaePassAccessToken);
    yield* output.fold(
      (failure) async* {
        yield ErrorState("", PROFILE_ERROR);
      },
      (responseToken) async* {
        final userDataOutput =
            await uaePassRepo!.getUserData(responseToken.data);
        yield* userDataOutput.fold(
          (failure) async* {
            yield ErrorState("", PROFILE_ERROR);
          },
          (responseModel) async* {
            UAEDataModel model = responseModel.data;
            if (model.userType == USER_TYPE_SOP1) {
              yield ErrorState(
                "",
                PROFILE_ERROR_USER_TYPE_SOP1,
                uaeDataModel: model,
              );
            } else {
              yield FetchUAEPassProfileState(uaeDataModel: model);
            }
          },
        );
      },
    );
  }

  Stream<UAEPassWebViewState> setUAEPassLoginAuthenticationUrl(
    SetUAEPassLoginAuthenticationUrlEvent setUAEPassLoginAuthenticationUrlEvent,
    Emitter<UAEPassWebViewState> emit,
  ) async* {
    emit(
      SetUAEPassLoginAuthenticationUrlState(
        authenticationUrl:
            setUAEPassLoginAuthenticationUrlEvent.authenticationUrl,
      ),
    );
  }

  Stream<UAEPassWebViewState> errorEvent(
    ErrorEvent errorEvent,
    Emitter<UAEPassWebViewState> emit,
  ) async* {
    emit(
      ErrorState(
        errorEvent.error,
        errorEvent.apiStatus,
      ),
    );
  }
}
