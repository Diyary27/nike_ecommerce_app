import 'package:flutter/material.dart';
import 'package:nike_ecommerce_app/data/comment.dart';

class CommentItem extends StatelessWidget {
  final CommentEntity comment;

  const CommentItem({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.fromLTRB(12, 6, 12, 6),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  Text(
                    comment.email,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              Text(
                comment.date,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            comment.content,
            style: TextStyle(height: 1.25),
          ),
        ],
      ),
    );
  }
}
