import 'package:dartz/dartz.dart';
import 'package:juno_provider_base_project/core/core.dart';
import 'package:juno_provider_base_project/features/project_details/domain/usecases/get_project_details.dart';

class ProjectDetailsProvider extends BaseProvider {
  final GetGithubProjectDetails getGithubProjectDetails;

  Item? _projectUiData;

  ProjectDetailsProvider({required this.getGithubProjectDetails});

  Item? get projectUiData => _projectUiData;

  void onInit(ProjectDetailsArgument argument) {
    final dataModel = argument.dataModel;

    _getGithubProjectDetails(
        login: dataModel.owner?.login, name: dataModel.name);
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
    _projectUiData = Item(
        name: r.name,
        owner: r.owner,
        stargazersCount: r.stargazersCount,
        forks: r.forks,
        watchers: r.watchers,
        score: r.score,
        description: r.description);
  }
}
