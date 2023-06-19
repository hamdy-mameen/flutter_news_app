import 'package:flutter/material.dart';
import 'package:news_app/models/article.dart';
import './tag_container.dart';
import '../screens/web_view_screen.dart';

class ArticleContent extends StatelessWidget {
  const ArticleContent({super.key, required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TagContainer(backgroundColor: Colors.grey.shade200, childern: [
                const Icon(
                  Icons.timer,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '${DateTime.now().difference(DateTime.parse(article.publishedAt ?? '')).inHours} hours ago',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.black),
                ),
              ]),
              const SizedBox(
                width: 5,
              ),
              if (article.author != null)
                TagContainer(backgroundColor: Colors.black, childern: [
                  const Icon(
                    Icons.source,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    constraints: BoxConstraints(maxWidth: 100),
                    child: Text(
                      article.author ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.white),
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                  ),
                ]),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            article.description ?? '',
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.5),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(article.content ?? '',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(height: 1.5)),
          if (article.url != null)
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(WebViewScreen.routeName,
                      arguments: article.url);
                },
                child: const Text('Read more'))
        ],
      ),
    );
  }
}
