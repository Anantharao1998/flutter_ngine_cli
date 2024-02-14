import 'package:flutter/material.dart';
import 'package:juno_provider_base_project/config/config.dart';
import 'package:juno_provider_base_project/core/enum/enum.dart';
import 'package:juno_provider_base_project/core/errors/errors.dart';
import 'package:logger/logger.dart';

abstract class BaseProvider extends ChangeNotifier {
  final Logger logger = FlavorConfig.instance.logger;

  String _errorMessage = '';
  //Controls page state
  ViewState _viewState = ViewState.initial;

  ViewState get viewState => _viewState;

  String get errorMessage => _errorMessage;

  void _updateViewState(ViewState state) {
    if (state != _viewState) {
      _viewState = state;

      notifyListeners();
    }
  }

  void setLoading() => _updateViewState(ViewState.loading);

  void setSuccess() => _updateViewState(ViewState.success);

  void setNoInternet() => _updateViewState(ViewState.noInternet);

  void setErrorMessage(String msg) {
    _errorMessage = msg;
    notifyListeners();
  }

  void setError(Failure f) {
    logger.e('Basecontroller error: >>>>>>> ${f.detailedMessage}');

    if (f is NoInternetConnectionFailure) {
      setErrorMessage('No internet connection');
    } else {
      setErrorMessage(f.detailedMessage);
    }

    _updateViewState(ViewState.error);
  }

  // Use this method when you have more than one PageState in a controller
  // this will help to different from the main PageState used for say API calling
  void setViewState(ViewState currentState, ViewState newState) {
    if (newState != currentState) {
      currentState = newState;
      notifyListeners();
    }
  }
}
