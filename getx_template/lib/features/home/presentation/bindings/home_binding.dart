import 'package:get/get.dart';
import 'package:juno_getx_base_project/features/home/data/datasources/github_repo_list_remote_datasource.dart';
import 'package:juno_getx_base_project/features/home/data/repositories/github_repo_list_repository_impl.dart';
import 'package:juno_getx_base_project/features/home/domain/repositories/github_repo_list_repository.dart';
import 'package:juno_getx_base_project/features/home/domain/usecases/get_github_project.dart';
import 'package:juno_getx_base_project/features/home/presentation/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // register remote datasource
    Get.lazyPut<GithubRepoListRemoteDataSource>(
        () => GithubListRemoteDataSourceImpl());
    // register repository
    Get.lazyPut<GithubRepoListRepository>(
        () => GithubRepoListRepositoryImpl(remoteDataSource: Get.find()));
    // register usecase
    Get.lazyPut<GetGithubProject>(
        () => GetGithubProject(repository: Get.find()));
    // register controller
    Get.lazyPut<HomeController>(
        () => HomeController(getGithubProject: Get.find()));
  }
}
