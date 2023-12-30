import 'package:flutter/material.dart';
import 'package:grad_proj/timeelinee/screens/home/comment_model.dart';

import '../commons/theme.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    Key? key,
    required Size media,
  })  : _media = media,
        super(key: key);

  final Size _media;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(4),
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(20),
        height: _media.height / 1.4,
        width: _media.width / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Recent Comments',
              style: cardTitleTextStyle,
            ),
            const SizedBox(height: 10),
            const Text(
              'Latest Comments on users from Material',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: commentList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                            commentList[index].image ?? 'default_image.png'),
                        radius: 30,
                      ),
                      title: Text(
                        commentList[index].name ?? 'user',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${commentList[index].comment}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: <Widget>[
                                Text(
                                  '${commentList[index].date}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const SizedBox(width: 10),
                                const Icon(Icons.edit, size: 15, color: Colors.grey),
                                const SizedBox(width: 10),
                                const Icon(Icons.highlight_off,
                                    size: 15, color: Colors.grey),
                                const SizedBox(width: 10),
                                const Icon(Icons.favorite_border,
                                    size: 15, color: Colors.pink),
                              ],
                            ),
                          ],
                        ),
                      ),
                      isThreeLine: true,
                      trailing: Material(
                        color: commentList[index].color,
                        borderRadius: BorderRadius.circular(4),
                        child: Container(
                          alignment: Alignment.center,
                          width: 60,
                          height: 20,
                          child: Text(
                            commentList[index].status?.index == 0
                                ? 'Pending'
                                : commentList[index].status?.index == 1
                                    ? 'Approved'
                                    : 'Rejected',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
