import 'package:flutter_hacker_news_app/src/types/data_source.dart';

typedef Fetcher<TI, TO> = Future<TO> Function(
  TI input,
  DataSource<TO>? dataSource,
);
