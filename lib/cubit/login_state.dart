import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;
  final Map<String, dynamic>? userData;

  const LoginState({
    required this.isLoading,
    required this.isSuccess,
    this.errorMessage = '',
    this.userData,
  });

  LoginState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    Map<String, dynamic>? userData,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      userData: userData ?? this.userData,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, errorMessage, userData];
}
