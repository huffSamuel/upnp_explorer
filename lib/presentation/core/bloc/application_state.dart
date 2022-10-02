part of 'application_bloc.dart';

abstract class ApplicationState extends Equatable {
  final bool build;
  const ApplicationState({this.build = true});

  @override
  List<Object> get props => [];
}

class DiscoveryInitial extends ApplicationState {}

class NoNetwork extends ApplicationState {}
class Ready extends ApplicationState {}
class ReviewRequested extends ApplicationState {
  ReviewRequested() : super(build: false);
}
