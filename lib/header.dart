import 'package:flutter/material.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // actions: [
      //   Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Icon(Icons.add),
      //   )
      // ],
      title: Text('ホーム'),
      centerTitle: true,
      elevation: 0.0,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
