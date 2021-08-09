import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../controllers/chat.controller.dart';
import '../../../controllers/profile.controller.dart';
import '../../../global/themes/color.theme.dart';
import '../../../global/themes/layout.theme.dart';
import '../../../global/widgets/gutter.dart';

class IndividualChatScreen extends StatefulWidget {
  IndividualChatScreen({
    Key? key,
    required this.orderId,
    required this.name,
  }) : super(key: key);

  final int orderId;
  final String name;

  @override
  _IndividualChatScreenState createState() => _IndividualChatScreenState();
}

class _IndividualChatScreenState extends State<IndividualChatScreen> {
  FocusNode focusNode = FocusNode();
  TextEditingController _texctController = TextEditingController();

  ProfileController _profileController = Get.find();
  ChatController _chatController = Get.find();
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _chatController.connectToChatRoom(widget.orderId);
    _chatController.getChatRoomMessage(widget.orderId);
    _chatController.update();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      initState: (_) {
        _chatController.connectToChatRoom(widget.orderId);
        _chatController.getChatRoomMessage(widget.orderId);
        _chatController.update();
      },
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  splashRadius: 20,
                  icon: Icon(
                    Icons.arrow_back,
                    size: 24,
                  ),
                ),
              ],
            ),
            title: Text(
              widget.name,
              style: TextStyle(
                fontSize: 18.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SmartRefresher(
            enablePullDown: true,
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    reverse: true,
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(gutter / 2),
                      itemCount: controller.currentChatMessage.length,
                      itemBuilder: (context, index) => Align(
                        alignment: _profileController.profileModel.id.toString() == controller.currentChatMessage[index].senderId ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          constraints: BoxConstraints(maxWidth: Get.width * 0.7),
                          decoration: BoxDecoration(
                            color: _profileController.profileModel.id.toString() == controller.currentChatMessage[index].senderId ? Get.theme.primaryColor : Colors.white,
                            borderRadius: BorderRadius.circular(borderRadius),
                          ),
                          padding: EdgeInsets.symmetric(vertical: gutter / 2, horizontal: gutter),
                          child: Text(
                            controller.currentChatMessage[index].message!,
                            style: Get.textTheme.bodyText1!.copyWith(
                              color: _profileController.profileModel.id.toString() == controller.currentChatMessage[index].senderId ? Colors.white : Get.theme.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => Gutter(scale: 0.5),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(gutter),
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        margin: EdgeInsets.only(left: 2, right: 2, bottom: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextFormField(
                          controller: _texctController,
                          focusNode: focusNode,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          minLines: 1,
                          cursorColor: iconColor,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type a message",
                            hintStyle: TextStyle(color: Colors.grey),
                            prefixIcon: Icon(Icons.keyboard, color: iconColor),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.send, color: iconColor),
                              onPressed: () {
                                if (_texctController.value.text.length > 0) {
                                  controller.chat(chatRoomId: widget.orderId, message: _texctController.value.text);
                                  _texctController.clear();
                                  focusNode.unfocus();
                                }
                              },
                            ),
                            contentPadding: EdgeInsets.all(5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
