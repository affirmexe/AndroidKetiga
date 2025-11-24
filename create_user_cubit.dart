import 'package:flutter_application_2/models/student.dart';
import 'package:flutter_application_2/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_user_state.dart';
part 'create_user_cubit.freezed.dart';

class CreateUserCubit extends Cubit<CreateUserState> {
  final AuthRepository _authRepository;

  CreateUserCubit(this._authRepository) : super(_Initial());

  Future<void> createUser({
    required String nama,
    required String username,
    required String password,
  }) async {
    emit(_Loading());

    try {
      final result = await _authRepository.createUser(
        nama: nama,
        username: username,
        password: password,
      );

      final dataUser = result['dataUser'];

      emit(_Success(dataUser: dataUser));
    } catch (e) {
      emit(_Failure(e.toString()));
    }
  }
}
