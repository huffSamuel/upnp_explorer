part of 'application_bloc.dart';

abstract class ApplicationEvent extends Equatable {
  const ApplicationEvent();

  @override
  List<Object> get props => [];
}

class ConnectivityChanged extends ApplicationEvent {
  final ConnectivityResult connectivity;

  ConnectivityChanged(this.connectivity);

  @override
  List<Object> get props => [connectivity];
}

class NeverReview extends ApplicationEvent {}

class ReviewNow extends ApplicationEvent {}
