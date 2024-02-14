import 'package:get/get.dart';
import 'package:juno_getx_base_project/features/project_details/data/repositories/github_project_details_repository_impl.dart';
import 'package:juno_getx_base_project/features/project_details/domain/repositories/github_project_details_repository.dart';
import 'package:juno_getx_base_project/features/project_details/domain/usecases/get_project_details.dart';
import 'package:juno_getx_base_project/features/project_details/project_details.dart';

class ProjectDetailsBinding extends Bindings {
  @override
  void dependencies() {
    // register remote datasource
    Get.lazyPut<GithubProjectDetailsRemoteDataSource>(
        () => GithubProjectDetailsRemoteDataSourceImpl());
    // register repository
    Get.lazyPut<GithubProjectDetailsRepository>(
        () => GithubProjectDetailsRepositoryImpl(remoteDataSource: Get.find()));
    // register usecase
    Get.lazyPut<GetGithubProjectDetails>(
        () => GetGithubProjectDetails(repository: Get.find()));
    // register controller
    Get.lazyPut<ProjectDetailsController>(
        () => ProjectDetailsController(getGithubProjectDetails: Get.find()));
  }
}
