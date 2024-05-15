import 'dart:async';
import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_with_flask_api/contact_us.dart';
import 'package:flutter_app_with_flask_api/knowYourSign.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required String title});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;
  String? message = "";

  int direction = 0;
  String output = 'Output displays here';
  String url =
      'https://50db-2409-40e0-100c-89b4-58cd-a33b-1963-5eeb.ngrok-free.app/upload';

  void captureFrame() async {
    final image = await cameraController.takePicture();
    final int imageLength = await image.length();
    final request = http.MultipartRequest("POST", Uri.parse(url));

    final headers = {"Content-type": "multipart/form-data"};

    request.files.add(http.MultipartFile(
        'image', image.readAsBytes().asStream(), imageLength,
        filename: image.path.split('/').last));

    request.headers.addAll(headers);

    final response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    log(res.body);
    setState(() {
      output = res.body;
    });
  }

  late Timer timer;

  Future<void> startCaptureLoop() async {
    timer = Timer.periodic(Duration(seconds: 2), (_) => captureFrame());
  }

  @override
  void initState() {
    super.initState();
    startCamera(1).then((_) {
      startCaptureLoop();
    });
  }

  Future<void> startCamera(int direction) async {
    cameras = await availableCameras();

    cameraController = CameraController(
        cameras[direction], ResolutionPreset.ultraHigh,
        enableAudio: false);

    await cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError(
      (e) {
        print(e);
      },
    );
  }

  void stopCaptureLoop() {
    timer?.cancel();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
    stopCaptureLoop();
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Bridge Hands',
              style: GoogleFonts.greatVibes(
                  textStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 12),
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      direction = direction == 0 ? 1 : 0;
                      startCamera(direction);
                    });
                  },
                  child: Icon(Icons.flip_camera_ios_rounded)),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => KnowYourSign(),
                    ),
                  );
                },
                leading: Icon(Icons.handshake),
                title: Text(
                  'Know your signs',
                  style: GoogleFonts.geologica(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  'About us',
                  style: GoogleFonts.geologica(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (cotext) => ContactUsPage(
                        title: '',
                      ),
                    ),
                  );
                },
                leading: Icon(Icons.phone),
                title: Text(
                  'Contact us',
                  style: GoogleFonts.geologica(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text(
                  'Help/FAQ',
                  style: GoogleFonts.geologica(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text(
                  'Settings',
                  style: GoogleFonts.geologica(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width,
                  child: CameraPreview(cameraController),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  padding: EdgeInsets.all(15),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    output,
                    style: GoogleFonts.anta(textStyle: TextStyle(fontSize: 30)),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
