import 'package:flutter/material.dart';
import '../models/article.dart';
import '../screens/article_screen.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({super.key, required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (__) => ArticleScreen(
                    article: article,
                  ))),
      child: Row(
        children: [
          Container(
            height: 80,
            width: MediaQuery.of(context).size.width * 0.25,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                    image: NetworkImage(
                        article.urlToImage == null ? '' : article.urlToImage!),
                    fit: BoxFit.cover)),
          ),
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    article.title == null ? '' : article.title!,
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.schedule,
                        size: 14,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                          '${DateTime.now().difference(DateTime.parse(article.publishedAt == null ? '' : article.publishedAt!)).inDays} day ago'),
                    ],
                  ),
                ]),
          )
        ],
      ),
    );
    ;
  }
}
