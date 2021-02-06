import 'package:clean_space/core/enums/view_state.dart';
import 'package:flutter/material.dart';
import 'package:clean_space/core/errors/errors.dart';
import 'package:clean_space/core/errors/failures.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.initial;
  ViewState get state => _state;

  String _error;
  String get error => _error;
  bool get hasError => _error != null;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  void setError(String message) => _error = message;

  Future performTryOrFailure(Function execute, {bool globalNotify = true}) async {
    if (globalNotify) setState(ViewState.loading);
    try {
      await execute();
      setError(null);
    } on Error catch(e){
      print(e);
      setError(e.message);
    }
    on Failure catch(f){
      print(f.message);
      setError("Something goes wrong, Please try again later or report us!");
    } catch (e) {
      print(e.toString());
      setError("Something goes wrong, Please try again later or report us!");
    } finally {
      if (globalNotify) setState(ViewState.loaded);
    }
  }


}