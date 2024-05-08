class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthLodingState extends AuthStates {}

class AuthSuccesState extends AuthStates {}

class AuthFailerState extends AuthStates {
  final String error;

  AuthFailerState({required this.error});
}
