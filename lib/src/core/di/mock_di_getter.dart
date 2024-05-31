import 'package:ft_uaepass/src/core/di/di_getter.dart';
import 'package:ft_uaepass/src/core/di/injection_container.dart';
import 'package:ft_uaepass/src/features/uae_pass_web_view/data/repository/uae_pass_repo_impl.dart';
import 'package:ft_uaepass/src/features/uae_pass_web_view/domain/uae_pass_repo.dart';

class MockDIGetter implements DIGetter {
  @override
  UaePassRepo getUaePassRepo() => UaePassRepoImpl(
        uaePassDataSource: sl(),
        networkInfo: sl(),
      );
}
