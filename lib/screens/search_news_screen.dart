import 'package:flutter/material.dart';
import 'package:news_app/provider/articles_provider.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../widgets/search_item.dart';

class SearchNewsScreen extends StatefulWidget {
  const SearchNewsScreen({super.key});

  @override
  State<SearchNewsScreen> createState() => _SearchNewsScreenState();
}

class _SearchNewsScreenState extends State<SearchNewsScreen> {
  Timer? _timer;

  void _debounce(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 500), action);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Articles>(context);

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Discover',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'News from all over world',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Search',
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none)),
                  onChanged: (value) {
                    _debounce(() {
                      provider.searchNews(value);
                    });
                  }),
              SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          provider.result == null ? 0 : provider.result!.length,
                      itemBuilder: (ctx, i) {
                        return SearchItem(article: provider.result![i]);
                      }))
            ])));
  }
}
