abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class CreationSuccessState extends RegisterStates {}

class CreationErrorState extends RegisterStates {
  final String error;
  CreationErrorState(this.error);
}

class CreationLoadingState extends RegisterStates {}

class PasswordVisibilityState extends RegisterStates {}

class RadioSelectionState extends RegisterStates {}

class GetUserdataLoadingState extends RegisterStates {}

class GetUserdataSuccessState extends RegisterStates {}

class GetUserdataErrorState extends RegisterStates {}

