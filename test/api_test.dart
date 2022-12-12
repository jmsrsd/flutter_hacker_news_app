import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:flutter_hacker_news_app/api/item.api.dart';
import 'package:flutter_hacker_news_app/api/maxitem.api.dart';
import 'package:flutter_hacker_news_app/api/stories.api.dart';
import 'package:flutter_hacker_news_app/api/updates.api.dart';
import 'package:flutter_hacker_news_app/api/user.api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'utils.dart';

void main() {
  runTests({
    ['API']: {
      ['Item']: {
        ['GET']: {
          ['Poll', 'Part']: () async {
            final response = await ItemRequest.get(160705);

            final by = response.by;
            final id = response.id;
            final poll = response.poll;
            final score = response.score;
            final text = response.text;
            final time = response.time;
            final type = response.type;

            expect(by, equals("pg"));
            expect(id, equals(160705));
            expect(poll, equals(160704));
            expect(score.runtimeType, equals(int));
            expect(
              text,
              equals(
                "Yes, ban them; I'm tired of seeing Valleywag stories on News.YC.",
              ),
            );
            expect(time.millisecondsSinceEpoch, equals(1207886576 * 1000));
            expect(type, equals(ItemType.pollopt));
          },
          ['Poll']: () async {
            final response = await ItemRequest.get(126809);

            final by = response.by;
            final descendants = response.descendants;
            final id = response.id;
            final kids = response.kids;
            final parts = response.parts;
            final score = response.score;
            final text = response.text;
            final time = response.time;
            final title = response.title;
            final type = response.type;

            expect(by, equals("pg"));
            expect(descendants.runtimeType, equals(int));
            expect(id, equals(126809));
            expect(kids.runtimeType, equals(List<int>));
            expect(parts.runtimeType, equals(List<int>));
            expect(score.runtimeType, equals(int));
            expect(text, equals(null));
            expect(time.millisecondsSinceEpoch, equals(1204403652 * 1000));
            expect(
              title,
              equals(
                "Poll: What would happen if News.YC had explicit support for polls?",
              ),
            );
            expect(type, equals(ItemType.poll));
          },
          ['Job']: () async {
            final response = await ItemRequest.get(192327);

            final by = response.by;
            final id = response.id;
            final score = response.score;
            final text = response.text;
            final time = response.time;
            final title = response.title;
            final type = response.type;
            final url = response.url;

            expect(by, equals("justin"));
            expect(id, equals(192327));
            expect(score.runtimeType, equals(int));
            expect(
              text,
              equals(
                "Justin.tv is the biggest live video site online. We serve hundreds of thousands of video streams a day, and have supported up to 50k live concurrent viewers. Our site is growing every week, and we just added a 10 gbps line to our colo. Our unique visitors are up 900% since January.<p>There are a lot of pieces that fit together to make Justin.tv work: our video cluster, IRC server, our web app, and our monitoring and search services, to name a few. A lot of our website is dependent on Flash, and we're looking for talented Flash Engineers who know AS2 and AS3 very well who want to be leaders in the development of our Flash.<p>Responsibilities<p><pre><code>    * Contribute to product design and implementation discussions\n    * Implement projects from the idea phase to production\n    * Test and iterate code before and after production release \n</code></pre>\nQualifications<p><pre><code>    * You should know AS2, AS3, and maybe a little be of Flex.\n    * Experience building web applications.\n    * A strong desire to work on website with passionate users and ideas for how to improve it.\n    * Experience hacking video streams, python, Twisted or rails all a plus.\n</code></pre>\nWhile we're growing rapidly, Justin.tv is still a small, technology focused company, built by hackers for hackers. Seven of our ten person team are engineers or designers. We believe in rapid development, and push out new code releases every week. We're based in a beautiful office in the SOMA district of SF, one block from the caltrain station. If you want a fun job hacking on code that will touch a lot of people, JTV is for you.<p>Note: You must be physically present in SF to work for JTV. Completing the technical problem at <a href=\"http://www.justin.tv/problems/bml\" rel=\"nofollow\">http://www.justin.tv/problems/bml</a> will go a long way with us. Cheers!",
              ),
            );
            expect(time.millisecondsSinceEpoch, equals(1210981217 * 1000));
            expect(
              title,
              equals("Justin.tv is looking for a Lead Flash Engineer!"),
            );
            expect(type, equals(ItemType.job));
            expect(url, equals(""));
          },
          ['Ask']: () async {
            final response = await ItemRequest.get(121003);

            final by = response.by;
            final descendants = response.descendants;
            final id = response.id;
            final kids = response.kids;
            final score = response.score;
            final text = response.text;
            final time = response.time;
            final title = response.title;
            final type = response.type;

            expect(by, equals('tel'));
            expect(descendants.runtimeType, equals(int));
            expect(id, equals(121003));
            expect(kids.runtimeType, equals(List<int>));
            expect(score.runtimeType, equals(int));
            expect(
              text,
              equals(
                "<i>or</i> HN: the Next Iteration<p>I get the impression that with Arc being released a lot of people who never had time for HN before are suddenly dropping in more often. (PG: what are the numbers on this? I'm envisioning a spike.)<p>Not to say that isn't great, but I'm wary of Diggification. Between links comparing programming to sex and a flurry of gratuitous, ostentatious  adjectives in the headlines it's a bit concerning.<p>80% of the stuff that makes the front page is still pretty awesome, but what's in place to keep the signal/noise ratio high? Does the HN model still work as the community scales? What's in store for (++ HN)?",
              ),
            );
            expect(time.millisecondsSinceEpoch, equals(1203647620 * 1000));
            expect(title, equals("Ask HN: The Arc Effect"));
            expect(type, equals(ItemType.story));
          },
          ['Comment']: () async {
            final response = await ItemRequest.get(2921983);

            final by = response.by;
            final id = response.id;
            final kids = response.kids;
            final parent = response.parent;
            final text = response.text;
            final time = response.time;
            final type = response.type;

            expect(by, equals("norvig"));
            expect(id, equals(2921983));
            expect(
              kids.runtimeType,
              equals(List<int>),
            );
            expect(parent, equals(2921506));
            expect(
              text,
              equals(
                "Aw shucks, guys ... you make me blush with your compliments.<p>Tell you what, Ill make a deal: I'll keep writing if you keep reading. K?",
              ),
            );
            expect(time.millisecondsSinceEpoch, equals(1314211127 * 1000));
            expect(type, equals(ItemType.comment));
          },
          ['Story']: () async {
            final response = await ItemRequest.get(8863);

            final by = response.by;
            final descendants = response.descendants;
            final id = response.id;
            final kids = response.kids;
            final score = response.score;
            final time = response.time;
            final title = response.title;
            final type = response.type;
            final url = response.url;

            expect(by, equals('dhouston'));
            expect(descendants, equals(71));
            expect(id, equals(8863));
            expect(kids.runtimeType, equals(List<int>));
            expect(score.runtimeType, equals(int));
            expect(time.millisecondsSinceEpoch, equals(1175714200 * 1000));
            expect(
              title,
              equals('My YC app: Dropbox - Throw away your USB drive'),
            );
            expect(type, equals(ItemType.story));
            expect(
              url,
              equals('http://www.getdropbox.com/u/2/screencast.html'),
            );
          },
        },
      },
      ['User']: {
        ['GET']: () async {
          final response = await UserRequest.get(userId: 'jl');
          final id = response.id;
          final created = response.created.millisecondsSinceEpoch;
          final karma = response.karma;
          final about = response.about;
          final submitted = response.submitted;

          expect(id, equals('jl'));
          expect(created, equals(1173923446 * 1000));
          expect(karma.runtimeType, equals(int));
          expect(about.runtimeType, equals(String));
          expect(submitted.runtimeType, equals(List<int>));
        },
      },
      ['Max Item']: {
        ['GET']: () async {
          final response = await MaxItemRequest.get();
          expect(response.runtimeType, equals(int));
        },
      },
      ['Updates']: {
        ['GET']: () async {
          final response = await UpdatesRequest.get();
          final items = response.items;
          final profiles = response.profiles;

          expect(items.runtimeType, equals(List<int>));
          expect(profiles.runtimeType, equals(List<String>));
        },
      },
      ['Stories']: {
        ['Ask']: {
          ['GET']: () async {
            final request = StoriesRequest.ask();
            expect(request.endpoint, equals('askstories.json'));
            final response = await request.get();
            expect(response.runtimeType, equals(List<int>));
          },
        },
        ['Show']: {
          ['GET']: () async {
            final request = StoriesRequest.show();
            expect(request.endpoint, equals('showstories.json'));
            final response = await request.get();
            expect(response.runtimeType, equals(List<int>));
          },
        },
        ['Job']: {
          ['GET']: () async {
            final request = StoriesRequest.job();
            expect(request.endpoint, equals('jobstories.json'));
            final response = await request.get();
            expect(response.runtimeType, equals(List<int>));
          },
        },
        ['Top']: {
          ['GET']: () async {
            final request = StoriesRequest.top();
            expect(request.endpoint, equals('topstories.json'));
            final response = await request.get();
            expect(response.runtimeType, equals(List<int>));
          },
        },
        ['New']: {
          ['GET']: () async {
            final request = StoriesRequest.newOrLatest();
            expect(request.endpoint, equals('newstories.json'));
            final response = await request.get();
            expect(response.runtimeType, equals(List<int>));
          },
        },
        ['Best']: {
          ['GET']: () async {
            final request = StoriesRequest.best();
            expect(request.endpoint, equals('beststories.json'));
            final response = await request.get();
            expect(response.runtimeType, equals(List<int>));
          },
        },
      },
    },
  });
}
