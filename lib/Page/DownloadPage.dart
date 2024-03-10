import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadPage extends StatelessWidget {
  const DownloadPage({required this.onBack});

  final Function() onBack;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          constraints: BoxConstraints(maxWidth: 500),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildRow(
                  "Windows",
                  ElevatedButton(
                      onPressed: () {
                        launchUrl(Uri.parse(
                            "https://firebasestorage.googleapis.com/v0/b/babeltowerfm.appspot.com/o/babeltower_windows.zip?alt=media"));
                      },
                      child: Text("Download"))),
              SizedBox(
                height: 16,
              ),
              _buildRow(
                  "Mac",
                  ElevatedButton(
                      onPressed: () {
                        launchUrl(Uri.parse(
                            "https://firebasestorage.googleapis.com/v0/b/babeltowerfm.appspot.com/o/babeltower.dmg?alt=media"));
                      },
                      child: Text("Download"))),
              SizedBox(
                height: 16,
              ),
              _buildRow(
                  "iOS",
                  GestureDetector(
                    onTap: () {
                      launchUrl(Uri.parse(
                          "https://apps.apple.com/hk/app/build-babel-tower/id6478923155"));
                    },
                    child: Image.asset(
                      "assets/images/app-store-badge-200h.png",
                      width: 120,
                    ),
                  )),
              SizedBox(
                height: 16,
              ),
              _buildRow(
                  "Android",
                  GestureDetector(
                      onTap: () {
                        launchUrl(Uri.parse(
                            "https://play.google.com/store/apps/details?id=com.kylam.babeltower"));
                      },
                      child: Image.asset("assets/images/google-play-badge.png",
                          width: 120))),
              SizedBox(
                height: 24,
              ),
              ElevatedButton(onPressed: onBack, child: Text("BACK"))
            ],
          ),
        ),
      ),
    );
  }

  _buildRow(String label, Widget button) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 24),
        ),
        Spacer(),
        button
      ],
    );
  }
}
