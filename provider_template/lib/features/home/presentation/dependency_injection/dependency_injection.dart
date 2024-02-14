import 'package:get_it/get_it.dart';
import 'package:juno_provider_base_project/features/home/home.dart';

void registerHomeDeps(GetIt sl) {
  // register remote datasource
  sl.registerFactory<GithubRepoListRemoteDataSource>(
      () => GithubListRemoteDataSourceImpl());
  // register repository
  sl.registerFactory<GithubRepoListRepository>(
      () => GithubRepoListRepositoryImpl(remoteDataSource: sl()));
  // register usecase
  sl.registerFactory<GetGithubProject>(
      () => GetGithubProject(repository: sl()));
  // register controller
  sl.registerFactory<HomeProvider>(() => HomeProvider(getGithubProject: sl()));
}
