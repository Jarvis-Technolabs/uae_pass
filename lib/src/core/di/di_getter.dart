import 'package:uae_pass/src/features/uae_pass_web_view/domain/uae_pass_repo.dart';

enum Choice { MOCK_DATA, PROD_DATA }

abstract class DIGetter {
  UaePassRepo getUaePassRepo();
}
