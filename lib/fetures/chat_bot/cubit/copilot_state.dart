part of 'copilot_cubit.dart';

@immutable
sealed class CopilotState {}

final class CopilotInitial extends CopilotState {}

class CopilotLoading extends CopilotState {
  final List<ChatMessage> messages;
  CopilotLoading(this.messages);
}

class CopilotLoaded extends CopilotState {
  final List<ChatMessage> messages;
  CopilotLoaded(this.messages);
}

class CopilotError extends CopilotState {
  final String error;
  CopilotError(this.error);
}
