import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatefulWidget {
  final Function sendMessage;
  const ChatInput({Key? key, required this.sendMessage}) : super(key: key);

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  bool _emojiShowing = false;
  final TextEditingController _controller = TextEditingController();

  _onEmojiSelected(Emoji emoji) {
    _controller
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
  }

  _onBackspacePressed() {
    _controller
      ..text = _controller.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: Row(
            children: [
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35.0),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0, 3), blurRadius: 5, color: Colors.grey)
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.face,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _emojiShowing = !_emojiShowing;
                          });
                        }),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                            hintText: "Type Something...",
                            hintStyle: TextStyle(
                                color: Theme.of(context).primaryColor),
                            border: InputBorder.none),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send,
                          color: Theme.of(context).primaryColor),
                      onPressed: () {
                        if (_controller.text != '') {
                          widget.sendMessage(_controller.text);
                          setState(() {
                            _controller.text = '';
                          });
                        }
                      },
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
        Offstage(
          offstage: !_emojiShowing,
          child: SizedBox(
            height: 250,
            child: EmojiPicker(
                onEmojiSelected: (Category category, Emoji emoji) {
                  _onEmojiSelected(emoji);
                },
                onBackspacePressed: _onBackspacePressed,
                config: Config(
                    columns: 7,
                    emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                    verticalSpacing: 0,
                    horizontalSpacing: 0,
                    initCategory: Category.RECENT,
                    bgColor: const Color(0xFFF2F2F2),
                    indicatorColor: Colors.blue,
                    iconColor: Colors.grey,
                    iconColorSelected: Colors.blue,
                    progressIndicatorColor: Colors.blue,
                    backspaceColor: Colors.blue,
                    skinToneDialogBgColor: Colors.white,
                    skinToneIndicatorColor: Colors.grey,
                    enableSkinTones: true,
                    showRecentsTab: true,
                    recentsLimit: 28,
                    noRecentsText: 'No Recents',
                    noRecentsStyle:
                        const TextStyle(fontSize: 20, color: Colors.black26),
                    tabIndicatorAnimDuration: kTabScrollDuration,
                    categoryIcons: const CategoryIcons(),
                    buttonMode: ButtonMode.MATERIAL)),
          ),
        ),
      ],
    );
  }
}
