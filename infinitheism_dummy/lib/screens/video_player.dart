// import 'dart:html';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:infinitheism_dummy/widgets/video_card.dart';
import 'package:provider/provider.dart';
import 'package:infinitheism_dummy/providers/thumbnailData.dart';
import 'package:infinitheism_dummy/utils/textStyles.dart' as constants;

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController? _video;
  Future<void>? _initializeVideoPlayerFuture;
  String description = '';
  String chapter = '';
  String videoUrl = '';
  String playButtun = 'Resume';

  @override
  void initState() {
    // TODO: implement initState
    List list = [];
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final ab = Provider.of<Thumbnail>(context, listen: false);
      list = ab.thumbnailList;
      ab.getThumbnail();
      // description=ab.thumbnailList[0]['description'] ?? "desc";
      // print("${ab.thumbnailList}  video player");
      // for (var element in ab.thumbnailList) {
      //   print(element);
      // }
      // print(ab);
    });
    print(list);

    videoPlayer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _video!.dispose();
    super.dispose();
  }

  void videoPlayer() async {
    _video = VideoPlayerController.network(videoUrl);
    _initializeVideoPlayerFuture = _video?.initialize();
    _video?.setLooping(true);
    _video?.setVolume(1.0);
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    final instanceForThumbnail = context.watch<Thumbnail>();
    instanceForThumbnail.getThumbnail();
    // description=abc.thumbnailList[0]["description"];
    // chapter=abc.thumbnailList[0]["chapter"];
    return Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                //for video play
                Stack(
                  children: [
                    Positioned(
                        // top:20,

                        child: Container(
                            height: 240,
                            width: double.maxFinite,
                            child: FutureBuilder(
                              future: _initializeVideoPlayerFuture,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return AspectRatio(
                                    aspectRatio: _video!.value.aspectRatio,
                                    child: VideoPlayer(_video!),
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              "assets/images/back_arrow.svg",
                              height: 12,
                              width: 9,
                            )),
                        DotsIndicator(
                          dotsCount: 3,
                          axis: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.center,
                          decorator: const DotsDecorator(
                              // color: Color.fromRGBO(r, g, b, opacity)
                              color: Colors.red,
                              activeColor: Colors.red),
                        ),
                        SizedBox(
                          width: 0,
                        )
                      ],
                    ),
                  ],
                ),

                //description
                Container(
                  // height:double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/BG-3.jpg"),
                        fit: BoxFit.cover),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text("Dinacharya",
                              style: GoogleFonts.libreCaslonDisplay(
                                textStyle: const TextStyle(
                                    fontSize: 29,
                                    color: Color.fromARGB(227, 227, 227, 227),
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(description,
                              style: GoogleFonts.nunitoSans(
                                textStyle: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(227, 227, 227, 1)),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                              "$chapter | ${_video!.value.duration.inMinutes}:${_video!.value.duration.inSeconds} mins",
                              style: GoogleFonts.nunitoSans(
                                textStyle: const TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 19,
                                    color: Color.fromRGBO(255, 255, 255, 0.6)),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          // video controll button
                          Container(
                              // height: 40,
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 2, color: Color(0xFF3556D5)))),
                              child: Container(
                                width: 176,
                                height: 40,
                                margin:
                                    const EdgeInsets.fromLTRB(72, 10, 72, 10),
                                // padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                decoration: const BoxDecoration(
                                    boxShadow: [
                                      // BoxShadow(
                                      //   color: Color.fromARGB(225, 225, 225, 225),

                                      // ),
                                      //inner shadow of button
                                      BoxShadow(
                                        color: Color(0x4EFCFCFC),
                                        spreadRadius: 0.0,
                                        blurRadius: 20.0,
                                        offset: Offset(11, 7),
                                      ),
                                      //outer shadow of button
                                      BoxShadow(
                                        color: Color(0x3F000000),
                                        spreadRadius: 2.0,
                                        blurRadius: 14.0,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                    // border of button resume
                                    border: Border(
                                      left: BorderSide(
                                          width: 2,
                                          color: Color.fromARGB(
                                              225, 225, 225, 225)),
                                      top: BorderSide(
                                          width: 2,
                                          color: Color.fromARGB(
                                              225, 225, 225, 225)),
                                      right: BorderSide(
                                          width: 2,
                                          color: Color.fromARGB(
                                              225, 225, 225, 225)),
                                      bottom: BorderSide(
                                          width: 2,
                                          color: Color.fromARGB(
                                              225, 225, 225, 225)),
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.elliptical(30, 30))),
                                child: GestureDetector(
                                  onTap: () {
                                    if (_video!.value.isPlaying) {
                                      _video!.pause();
                                      playButtun = "Resume";
                                    } else {
                                      _video!.play();
                                      playButtun = "Pause";
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        playButtun == "Resume"
                                            ? Icons.play_arrow
                                            : Icons.pause,
                                        color: Color(0xFFFFFFFF),
                                        size: 19,
                                        weight: 15,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(playButtun,
                                          style: GoogleFonts.nunitoSans(
                                              textStyle: TextStyle(
                                                  fontSize: 19,
                                                  color: Color.fromARGB(
                                                      227, 227, 227, 227)))),
                                    ],
                                  ),
                                ),
                              )),
                          const SizedBox(
                            height: 31,
                          ),
                          //tabs
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                    icon: SvgPicture.asset(
                                      "assets/images/take_notes.svg",
                                      height: 25,
                                      width: 21,
                                    ),
                                    onPressed: () {
                                      //no functionality
                                    },
                                  ),
                                  Text(
                                    "Take Notes",
                                    style: GoogleFonts.nunitoSans(
                                      textStyle: constants.tabsText,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    icon: SvgPicture.asset(
                                      "assets/images/fav.svg",
                                      height: 25,
                                      width: 21,
                                    ),
                                    onPressed: () {
                                      //no functionality
                                    },
                                  ),
                                  Text(
                                    "Add to Fav",
                                    style: GoogleFonts.nunitoSans(
                                      textStyle: constants.tabsText,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    icon: SvgPicture.asset(
                                      "assets/images/download.svg",
                                      height: 25,
                                      width: 21,
                                    ),
                                    onPressed: () {
                                      //no functionality
                                    },
                                  ),
                                  Text(
                                    "Download",
                                    style: GoogleFonts.nunitoSans(
                                      textStyle: constants.tabsText,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    icon: SvgPicture.asset(
                                      "assets/images/Share.svg",
                                      height: 25,
                                      width: 21,
                                    ),
                                    onPressed: () {
                                      //no functionality
                                    },
                                  ),
                                  Text(
                                    "Share",
                                    style: GoogleFonts.nunitoSans(
                                      textStyle: constants.tabsText,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          //play list
                          Text(
                            "All Chapters",
                            style: GoogleFonts.libreCaslonDisplay(
                                textStyle: TextStyle(),
                                fontSize: 24,
                                color: Colors.white),
                          ),
                          // SizedBox(
                          //   // height: double.maxFinite,
                          //   child: 
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  instanceForThumbnail.thumbnailList.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                    title: GestureDetector(
                                  child: VideoCard(
                                      thumbnail: instanceForThumbnail
                                          .thumbnailList[index]["thumbnail"],
                                      playButton: instanceForThumbnail
                                          .thumbnailList[index]["playButton"],
                                      description: instanceForThumbnail
                                          .thumbnailList[index]["description"],
                                      chapter: instanceForThumbnail
                                          .thumbnailList[index]["chapter"]),
                                  onTap: () {
                                    description = instanceForThumbnail
                                        .thumbnailList[index]["description"];
                                    chapter = instanceForThumbnail
                                        .thumbnailList[index]["chapter"];
                                    videoUrl = instanceForThumbnail
                                        .thumbnailList[index]["videoUrl"];
                                    videoPlayer();
                                  },
                                ));
                              },
                            ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}

//in_line  documentation
//all styles should be declared in styles file
// names like ab, abc, thumbnailList to thumbNailList
//colors font size... make as variables in colors file
// use mediaquerry
