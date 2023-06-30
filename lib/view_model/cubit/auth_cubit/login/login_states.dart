abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {}

class LoginErrorState extends LoginStates {}

class PasswordVisibilityState extends LoginStates {}

class GetUserdataLoadingState extends LoginStates {}

class GetUserdataSuccessState extends LoginStates {}

class GetUserdataErrorState extends LoginStates {}