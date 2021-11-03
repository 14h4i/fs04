import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Bt02Page extends StatefulWidget {
  const Bt02Page({Key? key}) : super(key: key);

  @override
  State<Bt02Page> createState() => _Bt02PageState();
}

class _Bt02PageState extends State<Bt02Page> {
  Response? response;
  bool isLoading = false;
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BT 02'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.cloud_download,
        ),
        onPressed: _getData,
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : response == null
                ? const Text('Empty data')
                : response!.statusCode == 200
                    ? Text('${response!.data}')
                    : Text(error),
      ),
    );
  }

  _getData() async {
    String url = 'https://api.dofhunt.200lab.io/v1/categories';
    setState(() {
      isLoading = true;
    });
    try {
      response = await Dio().get(url);
    } catch (e) {
      error = 'Has error: $e';
    }
    setState(() {
      isLoading = false;
    });
  }
}
