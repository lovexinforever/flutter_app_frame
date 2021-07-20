part of 'welcome_bloc.dart';

abstract class WelcomeEvent extends Equatable {
  const WelcomeEvent();
}

class GetWelcomePageInfoEvent extends WelcomeEvent{
  final BuildContext context;

  GetWelcomePageInfoEvent(this.context);

  @override
  List<Object?> get props => [context];
}
