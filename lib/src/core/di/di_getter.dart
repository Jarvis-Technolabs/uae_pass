import 'package:ft_uaepass/src/features/uae_pass_web_view/domain/uae_pass_repo.dart';

enum Choice { mockData, prodData }

abstract class DIGetter {
  UaePassRepo getUaePassRepo();
}
