import 'package:flutter/material.dart';

class DownloadListTile extends StatefulWidget {
  final Widget title;
  final Uri uri;

  const DownloadListTile({
    Key? key,
    required this.title,
    required this.uri,
  }) : super(key: key);

  @override
  State<DownloadListTile> createState() => _DownloadListTileState();
}

class _DownloadListTileState extends State<DownloadListTile> {
  bool _downloading = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: widget.title,
      onTap: () {
        setState(() {
          _downloading = true;

          Future.delayed(Duration(seconds: 2)).then((value) {
            setState(() {
              _downloading = false;
            });
          });
        });
      },
      trailing: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        child: !_downloading
            ? Icon(Icons.chevron_right)
            : SizedBox(
                height: 15,
                width: 15,
                child: Center(
                  child: const CircularProgressIndicator(),
                ),
              ),
      ),
    );
  }
}
