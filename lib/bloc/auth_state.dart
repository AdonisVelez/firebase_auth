import 'package:alarma/model/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

// Estado inicial
class AuthInitial extends AuthState {}

// Estado cuando se está cargando (login, registro, logout)
class AuthLoading extends AuthState {}

// Estado cuando el usuario está autenticado
class AuthAuthenticated extends AuthState {
  final UserModel user;

  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

// Estado cuando ocurre un error
class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

// estado para indicar éxito en el registro
class AuthRegistrationSuccess extends AuthState {}

// Estado cuando el usuario no está autenticado
class AuthUnauthenticated extends AuthState {}
