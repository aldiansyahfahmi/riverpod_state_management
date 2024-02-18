import 'package:equatable/equatable.dart';
import 'package:riverpod_state_management/models/user.dart';
import 'package:riverpod_state_management/utils/state/view_data_state.dart';

class UsersState extends Equatable {
  final ViewData<List<UserData>> usersState;

  const UsersState({required this.usersState});

  @override
  List<Object?> get props => [usersState];
}
