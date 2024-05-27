import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class ShowLoader extends StatefulWidget {
  const ShowLoader({super.key});

  @override
  _ShowLoaderState createState() => _ShowLoaderState();
}

class _ShowLoaderState extends State<ShowLoader>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
      // Image.asset(
      //   AppImages.loading,
      // ),
      // ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
