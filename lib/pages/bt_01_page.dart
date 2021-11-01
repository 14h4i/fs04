import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

const url = "https://randomuser.me/api/portraits/lego/6.jpg";

class Bt01Page extends StatefulWidget {
  const Bt01Page({Key? key}) : super(key: key);

  @override
  State<Bt01Page> createState() => _Bt01PageState();
}

class _Bt01PageState extends State<Bt01Page> {
  bool isDownloading = false;
  bool isDeleted = false;
  double progress = 0;
  String path = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BT 01'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 2,
                    color: Colors.red,
                  ),
                ),
                child: FutureBuilder(
                  future: File(path).exists(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      if (snapshot.data == true) {
                        return Image.file(
                          File(path),
                        );
                      } else {
                        return const Center(child: Text('Null'));
                      }
                    }
                    return Container();
                  },
                )),
            const SizedBox(height: 20),
            SizedBox(
              height: 40,
              width: 250,
              child: (isDownloading || progress == 100)
                  ? Column(
                      children: [
                        SizedBox(
                          height: 20,
                          child: LinearProgressIndicator(
                            value: progress / 100,
                          ),
                        ),
                        Text(
                          '${progress.toStringAsFixed(0)}%',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ),
            ElevatedButton(
              onPressed: _downloadVideo,
              child: const Text('Download Image'),
            ),
            ElevatedButton(
              onPressed: _delete,
              child: const Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }

  _delete() async {
    if (await File(path).exists()) {
      setState(() {
        File(path).delete();
        progress = 0;
      });
    }
  }

  _downloadVideo() async {
    setState(() {
      isDownloading = true;
      progress = 0;
    });
    var appDocDir = await getApplicationDocumentsDirectory();
    path = appDocDir.path + "/temp.jpg";
    await Dio().download(
      url,
      path,
      onReceiveProgress: (rcv, total) {
        // print('${rcv}');

        setState(() {
          if (total != -1) {
            progress = ((rcv / total) * 100);
          }
        });
      },
    );

    setState(() {
      if (path != '') {
        isDownloading = false;
      }
    });
  }
}
