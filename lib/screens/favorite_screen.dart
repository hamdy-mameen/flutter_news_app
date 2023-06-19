import 'package:flutter/material.dart';
import '../data/local/db_helper.dart';
import '../screens/web_view_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: DBHelper.getAllArticles(),
          builder: (ctx, dataSnapShot) {
            if (dataSnapShot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (dataSnapShot.hasError) {
              return const Center(child: Text('An Error Occurred'));
            } else if (dataSnapShot.hasData) {
              if (dataSnapShot.data != null) {
                return ListView.builder(
                  itemBuilder: (ctx, index) => Dismissible(
                    key: ValueKey(dataSnapShot.data![index].id),
                    background: Container(
                      color: Theme.of(context).colorScheme.error,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 40,
                      ),
                      alignment: Alignment.centerRight,
                    ),
                    onDismissed: (direction) {
                      DBHelper.deleteArticle(dataSnapShot.data![index])
                          .then((value) {
                        if (value != 0) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Article Removed')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Something went wrong')));
                        }
                      });
                    },
                    child: InkWell(
                      onTap: () => Navigator.of(context).pushNamed(
                          WebViewScreen.routeName,
                          arguments: dataSnapShot.data![index].url),
                      child: ListTile(
                        leading: Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: dataSnapShot.data![index].urlToImage != null
                                ? Image.network(
                                    dataSnapShot.data![index].urlToImage!)
                                : const Text('')),
                        title: Text(
                          dataSnapShot.data![index].title ?? '',
                          softWrap: true,
                          maxLines: 1,
                        ),
                        subtitle: Text(dataSnapShot.data![index].author ?? ''),
                      ),
                    ),
                  ),
                  itemCount: dataSnapShot.data!.length,
                );
              }
            }
            return const Center(
              child: Text('No thing to show yet'),
            );
          }),
    );
  }
}
