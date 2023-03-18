import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/blocs/internet_bloc/internet_state.dart';

import 'internet_event.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  StreamSubscription? subscription;

  InternetBloc() : super(InitState()) {
    on<OnConnected>((event, emit) =>
        emit(Connected(msg: 'Internet connected successfully')));
    on<OnNotConnected>(
        (event, emit) => emit(Connected(msg: 'Internet connection problems ')));

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        add(OnConnected());
      } else {
        add(OnNotConnected());
      }
    });
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
