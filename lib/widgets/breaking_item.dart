import 'package:flutter/material.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/screens/article_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BreakingItem extends StatelessWidget {
  final double imageHeight;
  final Article article;

  BreakingItem(this.imageHeight, this.article);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: MediaQuery.of(context).size.width * 0.5,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (__) => ArticleScreen(
                        article: article,
                      )));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              height: imageHeight * 0.55,
              width: MediaQuery.of(context).size.width * 0.5,
              imageUrl: this.article.urlToImage ?? '',
              imageBuilder: (context, imageProvider) => Container(
                margin: EdgeInsets.only(top: 10),
                height: imageHeight * 0.55,
                width: MediaQuery.of(context).size.width * 0.5,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover)),
              ),
              placeholder: (context, url) =>
                  Image.asset('assets/images/loading.gif'),
              errorWidget: (context, url, error) => Icon(
                Icons.error,
                color: Colors.red,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              article.title ?? '',
              maxLines: 2,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold, height: 1.5),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
                '${DateTime.now().difference(DateTime.parse(article.publishedAt ?? '')).inHours} hours ago',
                style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(
              height: 2,
            ),
            Text(
              article.author ?? '',
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
