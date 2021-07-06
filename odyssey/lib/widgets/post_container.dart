import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:odyssey/models/models.dart';
import 'package:odyssey/screens/comment_post.dart';
import 'package:odyssey/widgets/profile_avatar.dart';

class PostContainer extends StatelessWidget {
  final Post post;

  const PostContainer({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final bool isDesktop = Responsive.isDesktop(context);
    return Card(
      shadowColor: Colors.white,
      margin: EdgeInsets.symmetric(
        vertical: 5.0,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _PostHeader(post: post),
                  const SizedBox(height: 4.0),
                  Text(post.caption),
                  post.imageUrl != null
                      ? const SizedBox.shrink()
                      : const SizedBox(height: 14.0),
                ],
              ),
            ),
            post.imageUrl != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Image(
                      image: NetworkImage(
                          'https://source.unsplash.com/random/400x450'),
                    ),
                  )
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: _PostButtons(post: post),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final Post post;

  const _PostHeader({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(imageUrl: post.user.imageUrl),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${post.user.name} • ${post.timeAgo}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        FocusedMenuHolder(
          openWithTap: true,
          onPressed: () {},
          menuItems: [
            FocusedMenuItem(
              title: Text('Delete Post'),
              trailingIcon: Icon(Icons.delete),
              onPressed: () {},
            ),
          ],
          child: IconButton(
            icon: const Icon(Icons.more_horiz),
            // onPressed: () => print('More'),
          ),
        ),
      ],
    );
  }
}

class _PostButtons extends StatelessWidget {
  final Post post;

  const _PostButtons({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
                          const SizedBox(height: 8.0),

        Row(
          children: [
            const Icon(
              Icons.emoji_emotions_outlined,
              size: 24.0,
            ),
            const SizedBox(width: 4.0),
            Text(
              '${post.likes}',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(width: 8.0),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Comment(),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.comment_outlined,
                    size: 24.0,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    '${post.comments}',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            const Icon(
              Icons.share_outlined,
              size: 24.0,
            ),
            const SizedBox(width: 4.0),
            Text(
              '${post.shares}',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.bookmark_border_outlined,
                    size: 24,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4.0),
            
          ],
        ),
        // const Divider(),
        const SizedBox(height: 12.0),
      ],
    );
  }
}
