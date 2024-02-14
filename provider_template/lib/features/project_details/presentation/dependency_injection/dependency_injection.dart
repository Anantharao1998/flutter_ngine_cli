import 'package:get_it/get_it.dart';
import 'package:juno_provider_base_project/features/project_details/project_details.dart';

void registerProjectDetailsDeps(GetIt sl) {
  // register remote datasource
  sl.registerFactory<GithubProjectDetailsRemoteDataSource>(
      () => GithubProjectDetailsRemoteDataSourceImpl());
  // register repository
  sl.registerFactory<GithubProjectDetailsRepository>(
      () => GithubProjectDetailsRepositoryImpl(remoteDataSource: sl()));
  // register usecase
  sl.registerFactory<GetGithubProjectDetails>(
      () => GetGithubProjectDetails(repository: sl()));
  // register controller
  sl.registerFactory<ProjectDetailsProvider>(
      () => ProjectDetailsProvider(getGithubProjectDetails: sl()));
}
