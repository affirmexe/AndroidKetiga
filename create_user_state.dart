part of 'create_user_cubit.dart';

@freezed
abstract class CreateUserState with _$CreateUserState {
  const factory CreateUserState.initial() = _Initial;
  const factory CreateUserState.loading() = _Loading;
  const factory CreateUserState.success({required Student dataUser}) = _Success;
  const factory CreateUserState.failur(String errorMessage) = _Failure;
}
