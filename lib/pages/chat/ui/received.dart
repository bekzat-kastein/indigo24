import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:indigo24/pages/chat/chat.dart';
import 'package:indigo24/pages/chat/chat_page_view_test.dart';
import 'package:indigo24/pages/chat/chat_user_profile.dart';
import 'package:indigo24/pages/chat/ui/replyMessage.dart';
import 'package:indigo24/services/socket.dart';
import 'package:indigo24/services/constants.dart';
import 'package:indigo24/style/colors.dart';
import 'package:indigo24/widgets/linkMessage.dart';
import 'package:indigo24/widgets/video_player_widget.dart';
import 'package:indigo24/services/localization.dart' as localization;

EmojiParser _parser = EmojiParser();

class Received extends StatelessWidget {
  final m;
  final chatId;
  final bool isGroup;
  Received(this.m, {this.chatId, this.isGroup});
  @override
  Widget build(BuildContext context) {
    var a = (m['attachments'] == false ||
            m['attachments'] == null ||
            m['attachments'] == '')
        ? false
        : jsonDecode(m['attachments']);
    var replyData = (m['reply_data'] == false || m['reply_data'] == null)
        ? false
        : m['reply_data'];
    return Align(
      alignment: Alignment(-1, 0),
      child: Container(
        child: CupertinoContextMenu(
          actions: [
            CupertinoContextMenuAction(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${localization.reply}', style: TextStyle(fontSize: 14)),
                  Icon(CupertinoIcons.reply_thick_solid, size: 20)
                ],
              ),
              onPressed: () {
                ChatRoom.shared.replyingMessage(m);
                Navigator.pop(context);
              },
            ),
            CupertinoContextMenuAction(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${localization.forward}',
                      style: TextStyle(fontSize: 14)),
                  Icon(CupertinoIcons.reply_thick_solid, size: 20)
                ],
              ),
              onPressed: () {
                // ChatRoom.shared.replyingMessage(m);
                Navigator.pop(context);
                Navigator.pop(context, m);
              },
            ),
          ],
          child: Material(
            color: Colors.transparent,
            child: ReceivedMessageWidget(
                phone: "${m['phone']}",
                content: '${m['text']}',
                time: time('${m['time']}'),
                name: '${m['user_name']}',
                image: (m["avatar"] == null || m["avatar"] == "")
                    ? "${avatarUrl}noAvatar.png"
                    : m["avatar_url"] == null
                        ? "$avatarUrl${m["avatar"].toString().replaceAll("AxB", "200x200")}"
                        : "${m["avatar_url"]}${m["avatar"].toString().replaceAll("AxB", "200x200")}",
                type: "${m["type"]}",
                media: (a == false || a == null)
                    ? null
                    : "${m["type"]}" == '12' ? a[0]['link'] : a[0]['filename'],
                rMedia: (a == false || a == null)
                    ? null
                    : a[0]['r_filename'] == null
                        ? a[0]['filename']
                        : a[0]['r_filename'],
                mediaUrl:
                    (a == false || a == null) ? null : m['attachment_url'],
                edit: "${m["edit"]}",
                isGroup: isGroup,
                anotherUser: "${m["type"]}" == '11'
                    ? jsonDecode(jsonEncode({
                        "id": "${m["another_user_id"]}",
                        "avatar": "${m["another_user_avatar"]}",
                        "name": "${m["another_user_name"]}"
                      }))
                    : null,
                replyData: (replyData == false || replyData == null)
                    ? null
                    : replyData,
                forwardData: m['forward_data']),
          ),
        ),
      ),
    );
  }

  String time(timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(
      int.parse(timestamp) * 1000,
    );
    TimeOfDay roomBooked = TimeOfDay.fromDateTime(DateTime.parse('$date'));
    var hours;
    var minutes;
    hours = '${roomBooked.hour}';
    minutes = '${roomBooked.minute}';

    if (roomBooked.hour.toString().length == 1) hours = '0${roomBooked.hour}';
    if (roomBooked.minute.toString().length == 1)
      minutes = '0${roomBooked.minute}';
    return '$hours:$minutes';
  }
}

class ReceivedMessageWidget extends StatelessWidget {
  final String content;
  final String time;
  final String image;
  final String name;
  final String media;
  final String mediaUrl;
  final String rMedia;
  final String type;
  final String edit;
  final bool isGroup;
  final phone;
  final anotherUser;
  final replyData;
  final forwardData;

  const ReceivedMessageWidget({
    Key key,
    this.phone,
    this.content,
    this.time,
    this.image,
    this.name,
    this.media,
    this.mediaUrl,
    this.rMedia,
    this.type,
    this.edit,
    this.isGroup,
    this.anotherUser,
    this.replyData,
    this.forwardData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var a = _parser.unemojify(content);
    int l = a.length - 1;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        SizedBox(width: 5),
        isGroup
            ? InkWell(
                onTap: () {
                  ChatRoom.shared.cabinetController.close();
                  ChatRoom.shared.setCabinetInfoStream();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatUserProfilePage(
                        '100',
                        email: 'email',
                        image: image,
                        name: name,
                        phone: phone,
                      ),
                    ),
                  ).whenComplete(() {
                    ChatRoom.shared.closeCabinetInfoStream();
                  });
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(image),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: image,
                      errorWidget: (context, url, error) => CachedNetworkImage(
                          imageUrl: "${avatarUrl}noAvatar.png"),
                    ),
                  ),
                ),
              )
            : Container(),
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: edit == '1' ? 150.0 : 130.0,
            ),
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(
                  right: 75.0,
                  left: 8.0,
                  top: 8.0,
                  bottom: 8.0,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Container(
                    color: type == '11' ? primaryColor : whiteColor,
                    child: Stack(children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          isGroup
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0,
                                      left: 8.0,
                                      top: 5.0,
                                      bottom: 0.0),
                                  child: Text(
                                    name,
                                    style: TextStyle(
                                      color: Colors.amber,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(top: 5.0),
                                ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: (type == "3") ? 5 : 8.0,
                                left: (type == "3") ? 2 : 8.0,
                                top: 0.0,
                                bottom: (type == "3") ? 1 : 15.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                '$forwardData' != 'null'
                                    ? Text(
                                        '${localization.forward} from ${forwardData}')
                                    : SizedBox(height: 0, width: 0),
                                (type == "12")
                                    ? LinkMessage("$media")
                                    : (a[0] == ":" &&
                                            a[l] == ":" &&
                                            content.length < 9)
                                        ? Text(content,
                                            style: TextStyle(fontSize: 40))
                                        : (a[0] == ":" &&
                                                a[l] == ":" &&
                                                content.length > 8)
                                            ? Text(content,
                                                style: TextStyle(fontSize: 24))
                                            : (type == "1")
                                                ? (() {
                                                    listMessages
                                                        .forEach((element) {
                                                      if (element['type']
                                                              .toString() ==
                                                          '1') {
                                                        imageCount.add(element);
                                                        test = element;
                                                      }
                                                    });
                                                    return ImageMessage(
                                                        "$mediaUrl$rMedia",
                                                        "$mediaUrl$media",
                                                        content: content,
                                                        imageCount: imageCount
                                                            .indexOf(test));
                                                  }())
                                                : (type == "2")
                                                    ? Container(
                                                        color: Colors.pinkAccent
                                                            .withOpacity(0.2),
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        child: Text(
                                                          '${localization.document} ${localization.error}',
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      )
                                                    // FileMessage(
                                                    // url: "$mediaUrl$media") // TODO FIX FILES
                                                    : (type == "3")
                                                        ? AudioMessage(
                                                            "$mediaUrl$media",
                                                          )
                                                        : (type == "4")
                                                            ? VideoPlayerWidget(
                                                                "$mediaUrl$media",
                                                                "network",
                                                              )
                                                            : (type == "10")
                                                                ? ReplyMessage(
                                                                    content,
                                                                    replyData,
                                                                  )
                                                                : type == '11'
                                                                    ? Container(
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                Container(width: 30.0, height: 30.0, decoration: new BoxDecoration(shape: BoxShape.circle, image: new DecorationImage(fit: BoxFit.fill, image: new NetworkImage("$avatarUrl${anotherUser["avatar"].toString().replaceAll('AxB', '200x200')}")))),
                                                                                SizedBox(width: 5),
                                                                                Flexible(
                                                                                  child: Text(
                                                                                    "${anotherUser["name"]}",
                                                                                    maxLines: 1,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    style: TextStyle(fontWeight: FontWeight.w600, color: whiteColor),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                            SizedBox(height: 5),
                                                                            Flexible(
                                                                              child: Text(
                                                                                '+$content KZT',
                                                                                maxLines: 1,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle(fontWeight: FontWeight.w600, color: whiteColor),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      )
                                                                    : SelectableText(
                                                                        content,
                                                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 1,
                        right: 10,
                        child: Row(
                          children: [
                            edit == '1'
                                ? Text(
                                    "${localization.editedMessage}. ",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                  )
                                : Container(),
                            Text(
                              time,
                              style: TextStyle(
                                fontSize: 10,
                                color: type == '11'
                                    ? whiteColor
                                    : Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
