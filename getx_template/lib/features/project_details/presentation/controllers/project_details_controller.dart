import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:juno_getx_base_project/core/base/base.dart';
import 'package:juno_getx_base_project/core/domain/domain.dart';
import 'package:juno_getx_base_project/core/errors/errors.dart';
import 'package:juno_getx_base_project/features/project_details/domain/usecases/get_project_details.dart';

class ProjectDetailsController extends BaseController {
  final GetGithubProjectDetails getGithubProjectDetails;

  final Rxn<Item> _projectUiData = Rxn<Item>();

  ProjectDetailsController({required this.getGithubProjectDetails});

  Item? get projectUiData => _projectUiData.value;

  @override
  void onInit() {
    final dataModel = Get.arguments;

    if (dataModel is Item) {
      _getGithubProjectDetails(
          login: dataModel.owner?.login, name: dataModel.name);
    }
    super.onInit();
  }

  Future<void> _getGithubProjectDetails(
      {required String? login, required String? name}) async {
    final GithubProjectDetailsParam params = GithubProjectDetailsParam(
      userName: login ?? '',
      repositoryName: name ?? '',
    );
    setLoading();

    final Either<Failure, Item> result =
        await getGithubProjectDetails.call(params: params);

    result.fold(
        (l) => setError(l), (r) => _handleProjectDetailsResponseSuccess(r));
    setSuccess();
  }

  void _handleProjectDetailsResponseSuccess(Item r) {
    _projectUiData.value = Item(
        name: r.name,
        owner: r.owner,
        stargazersCount: r.stargazersCount,
        forks: r.forks,
        watchers: r.watchers,
        score: r.score,
        description: r.description);
  }
}
