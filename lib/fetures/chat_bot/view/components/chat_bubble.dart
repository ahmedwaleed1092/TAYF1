import 'package:flutter/material.dart';
import 'package:tayf/core/theme/app_colors.dart';
import 'package:tayf/core/theme/app_style.dart';
import 'package:tayf/fetures/chat_bot/model/chat_message.dart';
import 'package:tayf/fetures/chat_bot/view/components/recommended_action_card.dart';

/// A single chat bubble, bot (left) or user (right), with optional
/// embedded recommended-action card and a timestamp underneath.
class ChatBubble extends StatelessWidget {
  final bool isUser;
  final String text;
  final String time;
  final RecommendedAction? action;

  const ChatBubble({
    super.key,
    required this.isUser,
    required this.text,
    required this.time,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment:
                isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isUser) ...[
                const _BotAvatar(),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.72,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isUser
                          ? AppColors.chatUserBubble
                          : AppColors.chatBotBubble,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(isUser ? 16 : 4),
                        bottomRight: Radius.circular(isUser ? 4 : 16),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          style: isUser
                              ? AppStyle.chatUserMessage
                              : AppStyle.chatBotMessage,
                        ),
                        if (action != null) ...[
                          const SizedBox(height: 10),
                          RecommendedActionCard(action: action!),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              if (isUser) ...[
                const SizedBox(width: 8),
                const _UserAvatar(),
              ],
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 4,
              left: isUser ? 0 : 40,
              right: isUser ? 40 : 0,
            ),
            child: Text(time, style: AppStyle.chatTimestamp),
          ),
        ],
      ),
    );
  }
}

class _BotAvatar extends StatelessWidget {
  const _BotAvatar();

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 14,
      backgroundColor: AppColors.chatBotAvatarBg,
      child: Icon(
        Icons.blur_circular,
        color: AppColors.chatBotAvatarIcon,
        size: 16,
      ),
    );
  }
}

class _UserAvatar extends StatelessWidget {
  const _UserAvatar();

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 14,
      backgroundColor: AppColors.chatUserAvatarBg,
      child: Icon(
        Icons.person,
        color: AppColors.chatUserAvatarIcon,
        size: 16,
      ),
    );
  }
}
