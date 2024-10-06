// import 'package:flutter/material.dart';
// import 'package:screenshot/screenshot.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
//
// class ScreenShotScreen extends StatelessWidget {
//   final String imageDesign;
//   final String receiverName;
//   final String title;
//   final String content;
//   final String sender;
//   final bool isPremium;
//   final ScreenshotController screenshotController = ScreenshotController();
//
//   ScreenShotScreen({
//     required this.imageDesign,
//     required this.receiverName,
//     required this.title,
//     required this.content,
//     required this.sender,
//     required this.isPremium,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Greeting Card'),
//       ),
//       body: Center(
//         child: Screenshot(
//           controller: screenshotController,
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               Image.network(
//                 'http://backend.quokka-mesh.com/$imageDesign', // Display imageDesign
//                 width: 300,
//                 height: 400,
//                 fit: BoxFit.cover,
//               ),
//               Positioned(
//                 bottom: 40,
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                   decoration: BoxDecoration(
//                     color: Colors.black.withOpacity(0.5),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Column(
//                     children: [
//                       // Text(
//                       //   title,
//                       //   style: TextStyle(
//                       //     color: Colors.white,
//                       //     fontSize: 24,
//                       //     fontWeight: FontWeight.bold,
//                       //     fontFamily: 'Arial', // Customize the font family if needed
//                       //     shadows: [
//                       //       Shadow(
//                       //         blurRadius: 10.0,
//                       //         color: Colors.black,
//                       //         offset: Offset(3.0, 3.0),
//                       //       ),
//                       //     ],
//                       //   ),
//                       // ),
//                       // Text(
//                       //   content,
//                       //   style: TextStyle(
//                       //     color: Colors.white,
//                       //     fontSize: 16,
//                       //     fontWeight: FontWeight.bold,
//                       //     fontFamily: 'Arial', // Customize the font family if needed
//                       //     shadows: [
//                       //       Shadow(
//                       //         blurRadius: 10.0,
//                       //         color: Colors.black,
//                       //         offset: Offset(3.0, 3.0),
//                       //       ),
//                       //     ],
//                       //   ),
//                       // ),
//                       // Text(
//                       //   'Sender: $sender',
//                       //   style: TextStyle(
//                       //     color: Colors.white,
//                       //     fontSize: 16,
//                       //     fontWeight: FontWeight.bold,
//                       //     fontFamily: 'Arial', // Customize the font family if needed
//                       //     shadows: [
//                       //       Shadow(
//                       //         blurRadius: 10.0,
//                       //         color: Colors.black,
//                       //         offset: Offset(3.0, 3.0),
//                       //       ),
//                       //     ],
//                       //   ),
//                       // ),
//                       Text(
//                         'Receiver: $receiverName',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'Arial', // Customize the font family if needed
//                           shadows: [
//                             Shadow(
//                               blurRadius: 10.0,
//                               color: Colors.black,
//                               offset: Offset(3.0, 3.0),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final directory = await getApplicationDocumentsDirectory();
//           final imagePath = await screenshotController.captureAndSave(directory.path, fileName: 'screenshot.png');
//
//           if (imagePath != null) {
//             showDialog(
//               context: context,
//               builder: (context) {
//                 return AlertDialog(
//                   title: Text('Screenshot Captured'),
//                   content: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Image.file(File(imagePath)),
//                       SizedBox(height: 10),
//                       Text('Screenshot saved to $imagePath'),
//                     ],
//                   ),
//                   actions: [
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: Text('OK'),
//                     ),
//                   ],
//                 );
//               },
//             );
//           }
//         },
//         child: Icon(Icons.camera),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:io';
import 'dart:typed_data';

import '../../core/shared_constabts.dart';
import '../../utill/color_resources.dart';
import '../home/home_cubit/home_cubit.dart';
import 'package:path_provider/path_provider.dart';

class ScreenShotScreen extends StatefulWidget {
  final String imageDesign;
  final String receiverName;
  final String title;
  final String content;
  final String sender;
  final bool isPremium;

  ScreenShotScreen({
    required this.imageDesign,
    required this.receiverName,
    required this.title,
    required this.content,
    required this.sender,
    required this.isPremium,
  });

  @override
  _ScreenShotScreenState createState() => _ScreenShotScreenState();
}

class _ScreenShotScreenState extends State<ScreenShotScreen> {
  final ScreenshotController screenshotController = ScreenshotController();

  // Future<void> _captureAndSaveScreenshot() async {
  //   Uint8List? imageBytes = await screenshotController.capture();
  //   if (imageBytes == null) return;
  //
  //   final directory = await getApplicationDocumentsDirectory();
  //   final imagePath = '${directory.path}/screenshot.png';
  //   final imageFile = File(imagePath);
  //   await imageFile.writeAsBytes(imageBytes);
  //
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text('Screenshot Captured'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Image.file(imageFile),
  //             const SizedBox(height: 10),
  //             Text('Screenshot saved to $imagePath'),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  saveToGallery () {
    screenshotController.capture().then((Uint8List? image) {
     saveScreenshot(image!);
    });
    Constants.showToast(msg: "Image saved to gallery",
              gravity: ToastGravity.BOTTOM,
              color: Colors.green);
  }

  saveScreenshot(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String().replaceAll('.', '-').replaceAll(':', '-');
    final name = "ScreenShot$time";
    await ImageGallerySaver.saveImage(bytes,name: name);
  }

  Future<void> shareScreenshot() async {
    Uint8List? imageBytes = await screenshotController.capture();
    if (imageBytes == null) return;

    final directory = await getTemporaryDirectory();
    final imagePath = File('${directory.path}/screenshot.png');
    await imagePath.writeAsBytes(imageBytes);

    Share.shareXFiles([XFile(imagePath.path)]);
  }

  String getTextUntilSecondSpace(String text) {
    int spaceCount = 0;
    int endIndex = text.length;

    for (int i = 0; i < text.length; i++) {
      if (text[i] == ' ') {
        spaceCount++;
        if (spaceCount == 2) {
          endIndex = i;
          break;
        }
      }
    }

    return text.substring(0, endIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: Colors.white,
            child: Text(
                HomeCubit.get(context).isArabic
                    ? "كارت التهنئة"
                    : 'Greeting Card',

            )
        ),
        // actions: [
        //   horizontalSpace(7),
        //   InkWell(
        //     onTap: () {
        //       showDialog(
        //         context: context,
        //         builder: (BuildContext context) {
        //           return const ShareDialog(content: 'Hello');
        //         },
        //       );
        //     },
        //     child: const Icon(
        //       FontAwesomeIcons.share,
        //       color: ColorResources.apphighlightColor,
        //     ),
        //   ),
        //   horizontalSpace(10),
        // ],
      ),

      body: Stack(

        children: [
          Image.asset(
            'assets/images/background.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,

          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFFFFFEBB4).withOpacity(0.8),
          ),
          Center(
          child: Screenshot(
            controller: screenshotController,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  'http://backend.quokka-mesh.com/${widget.imageDesign}',
                  width: 300,
                  height: 400,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        // Text(
                        //   widget.title,
                        //   style: const TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 24,
                        //     fontWeight: FontWeight.bold,
                        //     fontFamily: 'Arial', // Customize the font family if needed
                        //     shadows: [
                        //       Shadow(
                        //         blurRadius: 20.0,
                        //         color: Colors.grey,
                        //         offset: Offset(3.0, 3.0),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Text(
                        //   widget.content,
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.bold,
                        //     fontFamily: 'Arial', // Customize the font family if needed
                        //     shadows: [
                        //       Shadow(
                        //         blurRadius: 10.0,
                        //         color: Colors.black,
                        //         offset: Offset(3.0, 3.0),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Text(
                        //   'Sender: ${widget.sender}',
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.bold,
                        //     fontFamily: 'Arial', // Customize the font family if needed
                        //     shadows: [
                        //       Shadow(
                        //         blurRadius: 10.0,
                        //         color: Colors.black,
                        //         offset: Offset(3.0, 3.0),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Text(
                          getTextUntilSecondSpace(widget.receiverName.toString()),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Arial', // Customize the font family if needed
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black,
                                offset: Offset(3.0, 3.0),
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
          ),
        )],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,

        children: [
          FloatingActionButton(
            foregroundColor: ColorResources.appColor,
            backgroundColor: ColorResources.appColor,
            // onPressed: _captureAndSaveScreenshot,
            onPressed: saveToGallery,
            child: Shimmer.fromColors(
              baseColor: ColorResources.white,
              highlightColor: ColorResources.apphighlightColor,
              child: const Icon(
                  Icons.camera_alt_outlined
              ),
            ),
          ),

          const SizedBox(width: 5,),
          FloatingActionButton(
            foregroundColor: ColorResources.appColor,
            backgroundColor: ColorResources.appColor,
             onPressed: shareScreenshot,
            // onPressed: (){
            //   showDialog(
            //     context: context,
            //     builder: (BuildContext context) {
            //       return const ShareDialog( imageFile: ,);
            //     },
            //   );
            // },
            child: Shimmer.fromColors(
              baseColor: ColorResources.white,
              highlightColor: ColorResources.apphighlightColor,
              child: const Icon(
                FontAwesomeIcons.share,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
