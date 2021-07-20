part of 'global_bloc.dart';

abstract class GlobalState extends Equatable {
  const GlobalState();
}

class GlobalInitial extends GlobalState {
  @override
  List<Object> get props => [];
}
