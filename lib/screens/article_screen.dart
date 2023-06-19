import 'package:flutter/material.dart';
import '../models/article.dart';
import '../data/local/db_helper.dart';
import '../widgets/article_content.dart';

class ArticleScreen extends StatefulWidget {
  final Article article;
  ArticleScreen({super.key, required this.article});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  var isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(widget.article.urlToImage ?? ''),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  IconButton(
                      iconSize: 40,
                      onPressed: () async {
                        if (!isFavorite) {
                          final result =
                              await DBHelper.insertArticle(widget.article);
                          if (result != 0) {
                            setState(() {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Article Added Successfuly'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                              isFavorite = !isFavorite;
                            });
                          }
                        }
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.article.title ?? '',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        height: 1.25,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            ArticleContent(article: widget.article)
          ],
        ),
      ),
    );
  }
}
