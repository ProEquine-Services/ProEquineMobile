import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeBoolState {
  final bool thereAreNotification;

  ChangeBoolState({this.thereAreNotification = false});

  ChangeBoolState copyWith({
    bool? notification,
  }) {
    return ChangeBoolState(
      thereAreNotification: notification ?? thereAreNotification,

    );
  }
}

class ChangeBoolCubit extends Cubit<ChangeBoolState> {
  ChangeBoolCubit(super.initialState);

  void changeStatusToTrue() {
    emit(state.copyWith(
      notification: true,
    ));

  }
  void changeStatusToFalse() {
    emit(state.copyWith(
      notification: false,
    ));
  }
}