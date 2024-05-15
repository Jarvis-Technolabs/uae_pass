import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uae_pass/src/core/di/injection_container.dart';
import 'package:uae_pass/src/core/flavour/flavour_config.dart';
import 'package:uae_pass/src/features/uae_pass_web_view/data/models/UAEDataModel.dart';
import 'package:uae_pass/src/features/uae_pass_web_view/data/models/UAEPassAccessToken.dart';
import 'package:uae_pass/src/features/uae_pass_web_view/domain/uae_pass_repo.dart';

import '../../../../core/const/UAEPassApiConstant.dart';
import 'uae_pass_web_view_state.dart';
import 'uaee_pass_web_view_event.dart';

class UAEPassWebViewBloc
    extends Bloc<UAEPassWebViewEvent, UAEPassWebViewState> {
  UAEPassWebViewBloc() : super(UAEPassWebViewInitialState());

  UaePassRepo? uaePassRepo = sl();

  Stream<UAEPassWebViewState> mapEventToState(
    UAEPassWebViewEvent event,
  ) async* {
    if (event is FetchUAEPassProfileEvent) {
      yield* fetchUAEPassProfile(event.accessToken);
    } else if (event is SetUAEPassLoginAuthenticationUrlEvent) {
      yield SetUAEPassLoginAuthenticationUrlState(
          authenticationUrl: event.authenticationUrl);
    } else if (event is ErrorEvent) {
      yield ErrorState(event.error, event.apiStatus);
    }
  }

  Stream<UAEPassWebViewState> fetchUAEPassProfile(String accessToken) async* {
    UAEPassAccessToken uaePassAccessToken = UAEPassAccessToken(
      code: accessToken,
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
              yield ErrorState("", PROFILE_ERROR_USER_TYPE_SOP1,
                  uaeDataModel: model);
            } else {
              yield FetchUAEPassProfileState(uaeDataModel: model);
            }
          },
        );
      },
    );
  }
}
