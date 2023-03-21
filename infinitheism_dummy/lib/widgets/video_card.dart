import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

class VideoCard extends StatefulWidget {
  const VideoCard(
      {super.key,
      required this.thumbnail,
      required this.playButton,
      required this.description,
      required this.chapter});
  final dynamic thumbnail; //thumbnail image
  final dynamic playButton;//button on thumbnail
  final dynamic description;//description of thumbnail
  final dynamic chapter; //chapter name
  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  @override
  Widget build(BuildContext context) {
    //video card
    return Container(
      height: 62,
      // width: 40,
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(widget.thumbnail),
                    SvgPicture.asset(widget.playButton,height: 35,width: 35,),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 38,
                      width: 118,
                      child: Text(
                        widget.description, 
                        style: GoogleFonts.nunitoSans(
                          textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(227, 227, 227, 227)),
                        )
                      ),
                    ),
                    Text(
                      widget.chapter,
                      style: GoogleFonts.nunitoSans(
                        textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF97A8DB)),
                      )
                    ),
                  ],
                ),
              ],
            ),
            // download button,
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("assets/images/download.svg",height: 19,width: 20,)
            )
          ],
        ),
      ),
    );
  }
}
