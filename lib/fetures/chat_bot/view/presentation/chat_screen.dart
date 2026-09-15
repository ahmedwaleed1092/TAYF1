import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tayf/core/routing/routs.dart';
import 'package:tayf/core/theme/app_colors.dart';
import 'package:tayf/core/theme/app_style.dart';
import 'package:tayf/fetures/chat_bot/cubit/copilot_cubit.dart';
import 'package:tayf/fetures/chat_bot/view/components/chat_bubble.dart';
import 'package:tayf/fetures/chat_bot/view/components/chat_input_bar.dart';
import 'package:tayf/fetures/chat_bot/view/components/suggested_questions.dart';

class AiCopilotScreen extends StatefulWidget {
  const AiCopilotScreen({super.key});

  @override
  State<AiCopilotScreen> createState() => _AiCopilotScreenState();
}

class _AiCopilotScreenState extends State<AiCopilotScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _handleSend([String? text]) {
    final content = (text ?? _controller.text).trim();
    if (content.isEmpty) return;
    _controller.clear();
    context.read<CopilotCubit>().sendMessage(content);
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: false,
        leading: BackButton(
          color: AppColors.chatPrimary,
          onPressed: () {
            context.pushReplacementNamed(Routs.home);
          },
        ),
        title: Text('AI Copilot', style: AppStyle.chatAppBarTitle),
      ),
      body: BlocConsumer<CopilotCubit, CopilotState>(
        listener: (context, state) {
          if (state is CopilotLoading || state is CopilotLoaded) {
            _scrollToBottom();
          }
          if (state is CopilotError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<CopilotCubit>();
          final messages = cubit.messages;
          final isLoading = state is CopilotLoading;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  itemCount: messages.length + (isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    // Show a typing indicator as the last item while loading
                    if (isLoading && index == messages.length) {
                      return const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.chatPrimary,
                            ),
                          ),
                        ),
                      );
                    }
                    final message = messages[index];
                    return ChatBubble(
                      isUser: message.isUser,
                      text: message.text,
                      time: message.time,
                      action: message.action,
                    );
                  },
                ),
              ),
              // Show suggested questions only when there's just the welcome message
              if (messages.length <= 1)
                SuggestedQuestions(
                  questions: cubit.suggestedQuestions,
                  onTap: _handleSend,
                ),
              ChatInputBar(
                controller: _controller,
                onSend: _handleSend,
                onSuggestionTap: _handleSend,
              ),
            ],
          );
        },
      ),
    );
  }
}
