import 'package:flutter_hacker_news_app/src/hooks/mutation_hook.dart';
import 'package:url_launcher/url_launcher_string.dart';

MutationHook<String?> useOpenUrl() {
  return useMutation<String>(
    fetcher: (url, _) async {
      if (url == null) {
        return;
      }

      await launchUrlString(url, mode: LaunchMode.externalApplication);
    },
  );
}
