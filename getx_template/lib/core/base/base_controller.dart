import 'package:get/get.dart';
import 'package:juno_getx_base_project/config/config.dart';
import 'package:juno_getx_base_project/core/enum/enum.dart';
import 'package:juno_getx_base_project/core/errors/errors.dart';
import 'package:logger/logger.dart';

abstract class BaseController extends GetxController {
  final Logger logger = FlavorConfig.instance.logger;

  final RxString _errorMessageController = ''.obs;
  //Controls page state
  final Rx<ViewState> _viewSateController = ViewState.initial.obs;

  ViewState get viewState => _viewSateController.value;

  String get errorMessage => _errorMessageController.value;

  ViewState updateViewState(ViewState state) => _viewSateController(state);

  ViewState setLoading() => updateViewState(ViewState.loading);

  ViewState setSuccess() => updateViewState(ViewState.success);

  ViewState setNoInternet() => updateViewState(ViewState.noInternet);

  void showErrorMessage(String msg) => _errorMessageController(msg);

  // Use this method when you have more than one ViewState in a controller
  // this will help to different from the main ViewState used for say API calling
  void setRxViewState(Rx<ViewState> rxViewState, ViewState value) {
    if (value != rxViewState.value) {
      rxViewState.value = value;
    }
  }

  ViewState setError(Failure f) {
    logger.e('Basecontroller error: >>>>>>> ${f.detailedMessage}');

    if (f is NoInternetConnectionFailure) {
      showErrorMessage(f.detailedMessage.tr);
    } else {
      showErrorMessage(f.detailedMessage);
    }

    return updateViewState(ViewState.error);
  }
}
