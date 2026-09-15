import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tayf/fetures/chat_bot/model/chat_message.dart';
import 'package:tayf/fetures/chat_bot/services/copilot_service.dart';

part 'copilot_state.dart';

class CopilotCubit extends Cubit<CopilotState> {
  CopilotCubit() : super(CopilotInitial()) {
    // Add a welcome message on creation
    messages.add(
      ChatMessage(
        isUser: false,
        text: 'How can I help you with your solar plant?',
        time: _formattedTime(),
      ),
    );
  }

  final List<ChatMessage> messages = [];

  final List<String> suggestedQuestions = const [
    'What happened',
    'Why did it happen',
    'How much did we lose',
    'What should we do?',
  ];

  String _formattedTime() {
    final now = DateTime.now();
    final hour = now.hour > 12
        ? now.hour - 12
        : (now.hour == 0 ? 12 : now.hour);
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  Future<void> sendMessage(String message) async {
    // Add user message immediately for instant UI feedback
    messages.add(
      ChatMessage(text: message, isUser: true, time: _formattedTime()),
    );
    emit(CopilotLoading(List.from(messages)));

    try {
      final response = await CopilotService.sendMessage(message);
      messages.add(
        ChatMessage(
          text: response.message,
          isUser: false,
          time: _formattedTime(),
        ),
      );
      emit(CopilotLoaded(List.from(messages)));
    } catch (e) {
      emit(CopilotError(e.toString()));
    }
  }
}
