import 'package:flutter/material.dart';
import 'package:news_app/widgets/breaking_item.dart';
import '../widgets/tag_container.dart';
import 'package:provider/provider.dart';
import '../provider/articles_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      final data = Provider.of<Articles>(context, listen: false);
      data.getHeadLines();
    });
  }

  @override
  Widget build(BuildContext context) {
    final articles = Provider.of<Articles>(context).articles;
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        CachedNetworkImage(
          imageUrl: articles == null
              ? ''
              : articles.isEmpty
                  ? ''
                  : articles[0].urlToImage == null
                      ? ''
                      : articles[0].urlToImage!,
          placeholder: (context, url) =>
              Image.asset('assets/images/loading.gif'),
          errorWidget: (context, url, error) => const Icon(
            Icons.error,
            color: Colors.red,
          ),
          imageBuilder: (context, imageProvider) => Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image:
                    DecorationImage(image: imageProvider, fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TagContainer(backgroundColor: Colors.black54, childern: [
                  Text(
                    'News of the day',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white),
                  )
                ]),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  articles == null
                      ? ''
                      : articles.isEmpty
                          ? ''
                          : articles[0].title == null
                              ? ''
                              : articles[0].title!,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      height: 1.25,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Breaking News',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: articles == null ? 0 : articles.length,
                    itemBuilder: (ctx, index) {
                      return (articles != null && articles.isNotEmpty)
                          ? BreakingItem(250, articles[index])
                          : Container();
                    }),
              )
            ],
          ),
        )
      ],
    );
  }
}
