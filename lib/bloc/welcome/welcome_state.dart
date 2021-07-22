part of 'welcome_bloc.dart';

abstract class WelcomeState extends Equatable {
  const WelcomeState();
}

class WelcomeInitial extends WelcomeState {
  @override
  List<Object> get props => [];
}

/// 欢迎页面数据 state
class WelcomeInfoDataState extends WelcomeState {
  final Adv adv;

  WelcomeInfoDataState(this.adv);

  @override
  List<Object?> get props => [adv];
}

/// 欢迎页面无数据 state
class WelcomeInfoNoDataState extends WelcomeState {
  @override
  List<Object?> get props => [];
}
