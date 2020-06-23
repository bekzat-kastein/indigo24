import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:indigo24/pages/add_tape.dart';
import 'package:indigo24/services/api.dart';
import 'package:photo_view/photo_view.dart';
import 'package:indigo24/services/localization.dart' as localization;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:video_player/video_player.dart';
import '../main.dart';
import 'tape.dart';

class TapesPage extends StatefulWidget {
  @override
  _TapesPageState createState() => _TapesPageState();
}

class _TapesPageState extends State<TapesPage> with AutomaticKeepAliveClientMixin {
  Future<int> _listFuture;
  bool isLoaded = false;
  var api = Api();
  List result;
  int tapePage = 1;

  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  
  @override
  void initState() {
    getTapes();
    super.initState();
  }
  rebuildTage(){
    api.getTapes('1').then((tapes) {
      if(tapes['message'] == 'Not authenticated' && tapes['success'].toString() == 'false')
      {
        logOut(context);
        return true;
      } else{
        return setTapes(tapes);
      }
    });
  }
  getTapes() {
    api.getTapes('$tapePage').then((tapes) {
      if(tapes['message'] == 'Not authenticated' && tapes['success'].toString() == 'false')
      {
        logOut(context);
        return true;
      } else{
        return setTapes(tapes);
      }
    });
  }


  Future addTapes(tapes) async {
    setState(() {
      var r = tapes["result"].toList();
      result.addAll(r);
      isLoaded = false;
    });
  }

  Future setTapes(tapes) async {
    if(tapePage == 1) 
      setState(() {
        result = tapes["result"].toList();
        _listFuture = Future(foo);
        result.forEach((el) async {
          if (el['myLike'] == true) {
            _saved.add(el['id']);
          }
        });
      });
    else
      setState(() {
        result.addAll(tapes["result"].toList());
        result.forEach((el) async {
          if (el['myLike'] == true) {
            _saved.add(el['id']);
          }
        });
      });
  }

  void _onLoading() async{
    tapePage ++;
    getTapes();
    // if(mounted)
    _refreshController.loadComplete();
  }
  int foo() {
    return 1;
  }

  var likeResult;
  var commentResult;

  @override
  void dispose() {
    super.dispose();
    print("dispose TAPES PAGES");
    _videoPlayerController.dispose();
    _chewieController.dispose();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  final Set _saved = Set();

  void _onRefresh(){
    rebuildTage();
    setState(() {
      
    });
    _refreshController.refreshCompleted();
  }

  RefreshController _refreshController = RefreshController(initialRefresh: false);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        brightness: Brightness.light,
        title: Text(
          "${localization.tape}",
          style: TextStyle(
            color: Color(0xFF001D52),
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          IconButton(
            icon: Container(
              height: 20,
              width: 20,
              child: Image(
                image: AssetImage(
                  'assets/images/newPost.png',
                ),
              ),
            ),
            onPressed: () {
              
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTapePage(),
                ),
              ).whenComplete(() {
                getTapes();
              });
            },
          )
        ],
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: FutureBuilder(
            future: _listFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData == true)
                return SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  footer: CustomFooter(
                    builder:(BuildContext context, LoadStatus mode) {
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
                    reverse: false,
                    itemCount: result.length,
                    itemBuilder: (BuildContext context, int index) {
                      // if (result[index]['media'].endsWith('mp4')) {
                      //   print(result[index]['media']);
                      //   _controller =
                      //       VideoPlayerController.network(result[index]['media'])
                      //         ..initialize().then((_) {
                      //           print('inited');
                      //           setState(() {});
                      //         });
                      // }
                      if (result[index]['media'].endsWith('mp4'))
                        return Container();
                      return Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Container(
                                color: Color(0xfff7f8fa),
                                padding: const EdgeInsets.only(
                                  top: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                            child: Image.network(
                                              // 'https://media.indigo24.com/avatars/${result[index]['avatar']}',
                                              'https://indigo24.xyz/uploads/avatars/${result[index]['avatar']}',
                                              width: 35,
                                            ),
                                          ),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(left: 10.0),
                                                  child: Text(
                                                    '${result[index]['name']}',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(left: 10.0),
                                                  child: Text(
                                                    '${result[index]['title']}',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onDoubleTap: () async {
                                        await api
                                            .likeTape('${result[index]['id']}')
                                            .then((value) {
                                          likeResult = value;
                                        });
                                        setState(() {
                                          if (likeResult['result']['myLike']) {
                                            _saved.add(result[index]['id']);
                                            result[index]['likesCount'] += 1;
                                            final snackBar = SnackBar(
                                              elevation: 200,
                                              duration: Duration(seconds: 2),
                                              content: Text(
                                                'Вы лайнули пост ${result[index]['title']} от ${result[index]['name']}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              backgroundColor: Colors.blue,
                                            );
                                            Scaffold.of(context)
                                                .showSnackBar(snackBar);
                                          } else {
                                            _saved.remove(result[index]['id']);
                                            result[index]['likesCount'] -= 1;
                                          }
                                        });
                                      },
                                      child: Container(
                                        height: MediaQuery.of(context).size.width,
                                        child: Center(
                                          child: 
                                          (result[index]['media'].toString().endsWith("MOV") || result[index]['media'].toString().endsWith("mp4") || result[index]['media'].toString().endsWith("mpeg"))? 
                                          new ChewieVideo(
                                            controller: VideoPlayerController.network("https://indigo24.xyz/uploads/tapes/${result[index]['media']}"),
                                          )
                                          :
                                          Image(
                                            image: NetworkImage(
                                              "https://indigo24.xyz/uploads/tapes/${result[index]['media']}",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        IconButton(
                                          icon: Container(
                                            width: 35,
                                            height: 35,
                                            child: Image(
                                              image: AssetImage(
                                                 _saved
                                                    .contains(result[index]['id']) ? 'assets/images/tapeLiked.png' : 'assets/images/tapeUnliked.png',
                                              ),
                                            ),
                                          ),
                                          onPressed: () async {
                                            await api
                                                .likeTape(
                                                    '${result[index]['id']}')
                                                .then((value) {
                                              print(value);
                                              setState(() {
                                                likeResult = value;
                                              });
                                            });

                                            setState(() {
                                              if (likeResult['result']
                                                  ['myLike']) {
                                                _saved.add(result[index]['id']);
                                                result[index]['likesCount'] += 1;
                                              } else {
                                                _saved
                                                    .remove(result[index]['id']);
                                                result[index]['likesCount'] -= 1;
                                              }
                                            });
                                          },
                                        ),
                                        Container(
                                          width: 30,
                                          child: Text(
                                            '${result[index]['likesCount']}',
                                          ),
                                        ),
                                        IconButton(
                                           icon: Container(
                                            width: 35,
                                            height: 35,
                                            child: Image(
                                              image: AssetImage(
                                                 'assets/images/tapeComment.png',
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    TapePage(result[index]),
                                              ),
                                            ).whenComplete(() {

                                            });
                                          },
                                        ),
                                        // Container(
                                        //   width: 30,
                                        //   child: Text(
                                        //     '${result[index]['commentsCount']}',
                                        //   ),
                                        // ),
                                        Expanded(
                                          child: Text(''),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10.0),
                                          child: Text(
                                            '${result[index]['created']}',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        '${result[index]['description']}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 16),
                                        maxLines: 2,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, top: 10),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                              // child: Image.network(
                                              //   'https://indigo24.xyz/uploads/avatars/${db.getItem('own_avatar')}',
                                              //   width: 35,
                                              // ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              else
                return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ));
  }

  @override
  bool get wantKeepAlive => true;
}

class ChewieVideo extends StatefulWidget {
  final VideoPlayerController controller;
  final size;
  ChewieVideo({this.controller, this.size});

  @override
  _ChewieVideoState createState() => _ChewieVideoState();
}

class _ChewieVideoState extends State<ChewieVideo> with RouteAware {
  VideoPlayerController controller;
  ChewieController _chewieController;
  
  Future<void> _future;

  Future<void> initVideoPlayer() async {
    await controller.initialize();
    setState(() {
      print(controller.value.aspectRatio);
      _chewieController = ChewieController(
        videoPlayerController: controller,     
        aspectRatio: controller.value.aspectRatio,
        autoInitialize: true,
        autoPlay: false,
        looping: true,   
        placeholder: buildPlaceholderImage(),   
        errorBuilder: (context, errorMessage) {
          return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    errorMessage,
                    style: TextStyle(color: Colors.white),
                ),
              ),
          );
        },
      );
    });
  }

  @override
  void initState() {
    super.initState();
    setControllers();
  }

  setControllers(){
    controller = widget.controller;
    _future = initVideoPlayer();
  }
  
  @override
  void deactivate() {
    super.deactivate();
    print("deactive");
    if(controller!=null && _chewieController != null){
      controller.dispose();
      _chewieController.dispose();
      _future = null;
    }
  }

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context));
    super.didChangeDependencies();
  }
  
  @override
  void dispose() {
    super.dispose();
    if(controller!=null && _chewieController != null){
      controller.dispose();
      _chewieController.dispose();
    }
    // _chewieController.videoPlayerController.dispose();
  }
  
  @override
  void didPop() {
    print("didPop");
    super.didPop();
  }
  @override
  void didPopNext() {
    print("didPopNext");
    // if(controller!=null && _chewieController != null){
    //   _future = null;
    //   controller.dispose();
    //   _chewieController.dispose();
    // } else if(controller == null && _chewieController == null){
    //   setControllers();
    // } 
    super.didPopNext();
  }

  @override
  void didPush() { 
    print("didPush");
    super.didPush();
  }

  @override
  void didPushNext() {
    print("didPushNext");
    if(controller!=null && _chewieController != null){
      controller.pause();
      // _chewieController.dispose();
    }
    super.didPushNext();
  }

  buildPlaceholderImage(){
    return Center(
       child: CircularProgressIndicator(),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) return buildPlaceholderImage();
        if(_chewieController==null) return buildPlaceholderImage();
        return Chewie(
          controller: _chewieController,
        );
      }
      
    );
  }
}
