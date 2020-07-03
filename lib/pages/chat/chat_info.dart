import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indigo24/main.dart';
import 'package:indigo24/pages/chat/chat_members_selection.dart';
import 'package:indigo24/pages/chat/chat_user_profile.dart';
import 'package:indigo24/pages/wallet/wallet.dart';
import 'package:indigo24/services/api.dart';
import 'package:indigo24/services/helper.dart';
import 'package:indigo24/services/socket.dart';
import 'package:indigo24/style/fonts.dart';
import 'package:indigo24/services/user.dart' as user;
import 'package:indigo24/services/localization.dart' as localization;
import 'package:indigo24/services/constants.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class ChatProfileInfo extends StatefulWidget {
  final chatName;
  final chatAvatar;
  final chatId;
  final chatType;
  final memberCount;
  ChatProfileInfo({
    this.chatType, 
    this.chatId, 
    this.chatName, 
    this.chatAvatar,
    this.memberCount,
  });
  @override
  _ChatProfileInfoState createState() => _ChatProfileInfoState();
}

class _ChatProfileInfoState extends State<ChatProfileInfo> {

  List membersList = [];
  String _chatTitle;

  File _image;
  @override
  void initState() {
    _chatTitle = '${widget.chatName}';
    listen();
    ChatRoom.shared.chatMembers(widget.chatId, page: chatMembersPage);
    chatTitleController.text = '${_chatTitle[0].toUpperCase()}${_chatTitle.substring(1)}';
    super.initState();
    memberCount = 0;



  }

  final picker = ImagePicker();
  var api = Api();

  listen() {
    ChatRoom.shared.onChatInfoChange.listen((e) {
      print("CHAT INFO EVENT");
      print(e.json);
      var cmd = e.json['cmd'];
      var message = e.json['data'];

      switch (cmd) {
        case "chat:members":
          setState(() {
            memberCount = 0;
            if(chatMembersPage.toString() == '1') {
              membersList = message;
            } else{
              membersList.addAll(message);
            }
            if(membersList.isNotEmpty){
              membersList.forEach((member){
                if(member['user_id'].toString() == '${user.id}') {
                  myPrivilege = member['role'].toString();
                }
                if(member['online'] == 'online') {
                  memberCount++;
                }
              });
            }
          });
          break;
        case "chat:members:privileges":
          ChatRoom.shared.chatMembers(widget.chatId);
          break;
        case "chat:members:delete":
          ChatRoom.shared.chatMembers(widget.chatId);
          break;
        case "chat:member:leave":
          print('isLeaved is true');
          Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Tabs()),(r) => false);
          break;
        default:
          print('Default of chat info $message');
      }
    });
  }


  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    print("_onRefresh");
    _refreshController.refreshCompleted();
  }

  int chatMembersPage = 1;

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if(membersList.length % 20 == 0){
      chatMembersPage++;
      if (mounted)
        setState(() {
          print("_onLoading chat members with page $chatMembersPage");
          ChatRoom.shared.chatMembers(widget.chatId, page: chatMembersPage);

          // for(int i = 0; i < 20; i++){
          //   membersList.add({'name' : 'test'});
          //   print(membersList.length);
          // }

        });
      _refreshController.loadComplete();
    }
  }

  Future getImage(ImageSource imageSource) async {
    final pickedFile = await picker.getImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      api.uploadAvatar(_image.path).then((r) async {
        if (r["success"]) {
          await SharedPreferencesHelper.setString('avatar', '${r["fileName"]}');
          setState(() {
            user.avatar = r["fileName"];
          });
        }
      });
    }
  }

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/cover.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  var anotherUserObject;

  Widget _buildProfileImage() {
    return InkWell(
      onTap: () {
        if(widget.chatType == 1){
          // if(myPrivilege){
          //   // action()
          //   // action(widget.chatId, membersList[i]);
          // }
        } else{
          if(membersList.length == 2){
            membersList.forEach((member){
              if(member['user_id'].toString() != '${user.id}'){
                memberAction(member);
              }
            });
          }
          
        }

        // Navigator.push(context,MaterialPageRoute(builder: (context) => ChatUserProfilePage(membersList[0])));
      },
      // onTap: () => PlatformActionSheet().displaySheet(
      //     context: context,
      //     message: Text("${localization.selectOption}"),
      //     actions: [
      //       ActionSheetAction(
      //         text: "Сфотографировать",
      //         onPressed: () {
      //           getImage(ImageSource.camera);
      //           Navigator.pop(context);
      //         },
      //         hasArrow: true,
      //       ),
      //       ActionSheetAction(
      //         text: "Выбрать из галереи",
      //         onPressed: () {
      //           getImage(ImageSource.gallery);
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ActionSheetAction(
      //         text: "Назад",
      //         onPressed: () => Navigator.pop(context),
      //         isCancel: true,
      //         defaultAction: true,
      //       )
      //     ]),
      child: Center(
        child: Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80.0),
            border: Border.all(
              color: Color(0xFF001D52),
              width: 5.0,
            ),
          ),
          child: ClipOval(
            child: Center(
                child: 
                widget.chatType.toString() == '1' 
                ? GridView.count(
                  crossAxisCount: 2,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(4, (index) {
                    var tempAvatar;
                    membersList.length > index 
                    ? tempAvatar = '$avatarUrl${membersList[index]["avatar"]}'
                    : tempAvatar = '';
                    return AspectRatio(
                      aspectRatio: 450 / 450,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            alignment: FractionalOffset.topCenter,
                            image: NetworkImage('$tempAvatar'),
                          )
                        ),
                      ),
                    );
                  }),
                )
                :   CachedNetworkImage(
                  imageUrl: widget.chatAvatar!=null
                  ? '$avatarUrl${widget.chatAvatar}' 
                  : '${avatarUrl}noAvatar.png',
                  errorWidget: (context, url, error) => CachedNetworkImage(
                    imageUrl: "${avatarUrl}noAvatar.png",
                  ),
                ),
              ),
          ),
        ),
      ),
    );
  }

  adminAction(chatId, member){
    final act = CupertinoActionSheet(
    title: Text('${localization.selectOption}'),
    actions: <Widget>[
      CupertinoActionSheetAction(
        child: Text('${localization.profile}'),
        onPressed: () {
          Navigator.pop(context);
          ChatRoom.shared.cabinetController.close();
          ChatRoom.shared.setCabinetInfoStream();
          Navigator.push(context,MaterialPageRoute(builder: (context) => ChatUserProfilePage(
            member,
            name: member['user_name'],
            phone: member['phone'],
            email: member['email'],
            image: member['avatar_url']+member['avatar'],
          ))).whenComplete(() {
            ChatRoom.shared.closeCabinetInfoStream();
          });
        },
      ),
      member['role'] == '$memberRole' ? CupertinoActionSheetAction(
        isDestructiveAction: true,
        child: Text('${localization.delete}'),
        onPressed: () {
          ChatRoom.shared.deleteChatMember(chatId, member['user_id']);
          Navigator.pop(context);
        },
      ) : Center()
    ],
    cancelButton: CupertinoActionSheetAction(
      child: Text('${localization.back}'),
      onPressed: () {
        Navigator.pop(context);
      },
    ));
    showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => act);
  }

  memberAction(member){
    final act = CupertinoActionSheet(
    title: Text('${localization.selectOption}'),
    actions: <Widget>[
      CupertinoActionSheetAction(
        child: Text('${localization.profile}'),
        onPressed: () {
          Navigator.pop(context);
          ChatRoom.shared.cabinetController.close();
          ChatRoom.shared.setCabinetInfoStream();
          Navigator.push(context,MaterialPageRoute(builder: (context) => ChatUserProfilePage(
            member,
            name: member['user_name'],
            phone: member['phone'],
            email: member['email'],
            image: member['avatar_url']+member['avatar'],
          ))).whenComplete(() {
            ChatRoom.shared.closeCabinetInfoStream();
          });
        },
      ),
    ],
    cancelButton: CupertinoActionSheetAction(
      child: Text('${localization.back}'),
      onPressed: () {
        Navigator.pop(context);
      },
    ));
    showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => act);
  }

  addMembers(chatId){
  final act = CupertinoActionSheet(
    title: Text('${localization.selectOption}'),
    actions: <Widget>[
      myPrivilege == '$ownerRole' ? CupertinoActionSheetAction(
        child: Text('${localization.addToGroup}'),
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(context,MaterialPageRoute(builder: (context) => ChatMembersSelection(chatId, membersList))).whenComplete(() {
            ChatRoom.shared.contactController.close();
            ChatRoom.shared.closeContactsStream();
            ChatRoom.shared.chatMembers(widget.chatId);
          });
        },
      ) : Container(),
      CupertinoActionSheetAction(
        isDestructiveAction: true,
        child: Text('${localization.exitGroup}'),
        onPressed: () {
          Widget okButton = CupertinoDialogAction(
            isDestructiveAction: true,
            child: Text("${localization.yes}"),
            onPressed: () {
              Navigator.pop(context);
              ChatRoom.shared.leaveChat(widget.chatId);
            },
          );
          Widget noButton = CupertinoDialogAction(
            child: Text("${localization.no}"),
            onPressed: () {
              Navigator.pop(context);
            },
          );
          CupertinoAlertDialog alert = CupertinoAlertDialog(
            title: Text("${localization.alert}"),
            content: Text('${localization.sureExitGroup}'),
            actions: [
              noButton,
              okButton,
            ],
          );
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
        },
      ),
    ],
    cancelButton: CupertinoActionSheetAction(
      child: Text('${localization.back}'),
      onPressed: () {
        Navigator.pop(context);
      },
    ));
    showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => act);
  }

  action(chatId, member){
    final act = CupertinoActionSheet(
    title: Text('${localization.selectOption}'),
    actions: <Widget>[
      CupertinoActionSheetAction(
        child: Text('${localization.watch}'),
        onPressed: () {
          Navigator.pop(context);
          ChatRoom.shared.cabinetController.close();
          ChatRoom.shared.setCabinetInfoStream();
          Navigator.push(context,MaterialPageRoute(builder: (context) => ChatUserProfilePage(
            member,
            name: member['user_name'],
            phone: member['phone'],
            email: member['email'],
            image: member['avatar_url']+member['avatar'],
          ))).whenComplete(() {
            ChatRoom.shared.closeCabinetInfoStream();
          });
        },
      ),
      CupertinoActionSheetAction(
        child: member['role'] == '$memberRole' ? Text('${localization.makeAdmin}') : member['role'] ==  '$adminRole' ? Text('${localization.makeMember}') : Text('${localization.error}'),
        onPressed: () {
          print('${member['role']} $memberRole $adminRole $ownerRole');
           switch (member['role'].toString()) {
            case '$memberRole':
              print('toAdmin');
              ChatRoom.shared.changePrivileges(chatId, member['user_id'], '$adminRole');
              break;
            case '$adminRole':
              print('toMember');
              ChatRoom.shared.changePrivileges(chatId, member['user_id'], '$memberRole');
              break;
             default:
           }
          ChatRoom.shared.chatMembers(widget.chatId);
          Navigator.pop(context);
        },
      ),
      CupertinoActionSheetAction(
        isDestructiveAction: true,
        child: Text('${localization.delete}'),
        onPressed: () {
          ChatRoom.shared.deleteChatMember(chatId, member['user_id']);
          Navigator.pop(context);
        },
      )
    ],
    cancelButton: CupertinoActionSheetAction(
      child: Text('${localization.back}'),
      onPressed: () {
        Navigator.pop(context);
      },
    ));
    showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => act);
  }

  TextEditingController chatTitleController = TextEditingController();
  int memberCount = 0;
  String myPrivilege = '';
  bool isEditing = false;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            body: Stack(
              children: <Widget>[
                _buildCoverImage(screenSize),
                Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Container(
                            padding: EdgeInsets.all(5),
                            child: Image(
                              image: AssetImage(
                                'assets/images/backWhite.png',
                              ),
                            ),
                          ),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Flexible(
                          child: InkWell(
                            onTap: () {
                             if(myPrivilege.toString() == '$ownerRole' && widget.chatType != 0){
                               print('$myPrivilege my privilege, ${widget.chatType} chat type');
                                setState(() {
                                  isEditing = !isEditing;
                                });
                             }
                            },
                            child: isEditing ? Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    controller: chatTitleController,
                                    style: fS26(c: 'ffffff'),
                                    onSubmitted: (value){
                                      ChatRoom.shared.changeChatName(widget.chatId, value);
                                    },
                                    decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.only(left: 0, bottom: 0, top: 0, right: 0),
                                    ),
                                  ),
                                ),
                                Icon(Icons.edit, color: Colors.white)
                              ],
                            ) : Text('${_chatTitle[0].toUpperCase()}${_chatTitle.substring(1)}', style: fS26(c: 'ffffff'), maxLines: 1, overflow: TextOverflow.ellipsis,)
                            )
                        ),
                        IconButton(
                          icon: Icon(Icons.more_vert),
                          color: widget.chatType != 0 ? Colors.white : Colors.transparent,
                          onPressed: () {
                            widget.chatType == 1 
                            ? addMembers(widget.chatId) 
                            : print('Change this action to private functions');
                            // ChatRoom.shared.addMembers(widget.chatId, )
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _buildProfileImage(),
                      ],
                    ),
                    SizedBox(height: 10),
                    widget.chatType == 1
                    ? Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        '${localization.members} ${widget.memberCount}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                    : Container(),
                    widget.chatType == 1
                    ? Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        '$memberCount online',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                    : Center(),
                    SizedBox(height: 10),
                    membersList.isEmpty
                        ? Center(child: CircularProgressIndicator())
                        :
                        widget.chatType == 1 ?
                        Flexible(
                            child: ScrollConfiguration(
                              behavior: MyBehavior(),
                              child: SmartRefresher(
                                enablePullDown: false,
                                enablePullUp: true,
                                // header: WaterDropHeader(),
                                footer: CustomFooter(
                                  builder: (BuildContext context, LoadStatus mode) {
                                    Widget body;
                                    return Container(
                                      height: 55.0,
                                      child: Center(child: body),
                                    );
                                  },
                                ),
                                controller: _refreshController,
                                onRefresh: _onRefresh,
                                onLoading: _onLoading,
                                child: ListView.builder(
                                  itemCount: membersList.length,
                                  itemBuilder: (context, i) {
                                    // print(membersList[i]);
                                    return ListTile(
                                      onTap: () {
                                        if(membersList[i]['user_id'].toString() == '${user.id}'){
                                          print(membersList[i]['user_id'].toString() == '${user.id}');
                                          // memberAction(membersList[i]);
                                        } else{
                                          switch (myPrivilege.toString()) {
                                            case '$ownerRole':
                                                print('ownerAction');
                                                action(widget.chatId, membersList[i]);
                                              break;
                                            case '$adminRole':
                                                print('adminAction');
                                                adminAction(widget.chatId, membersList[i]);
                                              break;
                                            case '$memberRole':
                                                print('memberAction');
                                                memberAction(membersList[i]);
                                              break;
                                            default:
                                          }
                                        }
                                        // ChatRoom.shared.checkUserOnline(ids);
                                        // ChatRoom.shared
                                        //     .getMessages(membersList[i]['id']);
                                      },
                                      leading: Container(
                                        height: 42,
                                        width: 42,
                                        child: Stack(
                                          children: <Widget>[
                                            CircleAvatar(
                                                backgroundImage: (membersList[i]["avatar"] == null ||
                                                        membersList[i]["avatar"] == '' ||
                                                        membersList[i]["avatar"] == false)
                                                    ? CachedNetworkImageProvider(
                                                        "${avatarUrl}noAvatar.png")
                                                    : 
                                                    CachedNetworkImageProvider(
                                                        '$avatarUrl${membersList[i]["avatar"]}'),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Container(
                                                padding: EdgeInsets.all(2),
                                                decoration:  BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: membersList[i]['online'] == 'online' ? Colors.white: Colors.transparent
                                                  ),
                                                child: Container(
                                                  decoration:  BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: membersList[i]['online'] == 'online' ? Color(0xFF00cc00) : Colors.transparent
                                                  ),
                                                  height: 15, 
                                                  width: 15, 
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      title: Text("${membersList[i]["user_name"]}"),
                                      subtitle: memberName(membersList[i])
                                    );
                                  },
                                ),
                              ),
                            ),
                          )
                         : Center(
                          child: Text("${localization.status}", style: TextStyle(
                            fontSize: 24,
                            // fontFamily: ""
                          )),
                        ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text memberName(member) {
    switch ('${member["role"]}') {
      case '100':
        return Text('${localization.creator}');
        break;
      case '50':
        return Text('${localization.admin}');
        break;
      case '2':
        return Text('${localization.member}');
        break;
      default:
        return Text('');
    }
  } 
}
