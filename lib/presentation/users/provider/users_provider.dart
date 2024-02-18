import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_state_management/datasource/remote_datasource.dart';
import 'package:riverpod_state_management/presentation/users/provider/users_state.dart';
import 'package:riverpod_state_management/utils/state/view_data_state.dart';

part 'users_provider.g.dart';

@riverpod
class UsersNotifier extends _$UsersNotifier {
  @override
  UsersState build() => UsersState(usersState: ViewData.initial());

  getUsers() async {
    state = UsersState(usersState: ViewData.loading());
    RemoteDataSource remoteDataSource = RemoteDataSourceImpl();
    final result = await remoteDataSource.getUsers();
    result.fold(
      (failure) => state = UsersState(
        usersState: ViewData.error(
          message: failure.errorMessage,
          failure: failure,
        ),
      ),
      (result) {
        if (result.data!.isEmpty) {
          state = UsersState(
            usersState: ViewData.noData(message: 'No Data'),
          );
        } else {
          state = UsersState(
            usersState: ViewData.loaded(data: result.data!),
          );
        }
      },
    );
  }
}
