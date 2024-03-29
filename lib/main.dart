import 'package:flutter/material.dart';

/// Flutter code sample for pinned [SearchAnchor] while scrolling.

void main() {
  runApp(MaterialApp(
    theme:
        ThemeData(useMaterial3: true, colorSchemeSeed: const Color(0xff6750a4)),
    home: const PinnedSearchBarApp(),
  ));
}

class PinnedSearchBarApp extends StatefulWidget {
  const PinnedSearchBarApp({super.key});

  @override
  State<PinnedSearchBarApp> createState() => _PinnedSearchBarAppState();
}

class _PinnedSearchBarAppState extends State<PinnedSearchBarApp> {
  final focusNode = FocusScopeNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              clipBehavior: Clip.none,
              shape: const StadiumBorder(),
              scrolledUnderElevation: 0.0,
              titleSpacing: 0.0,
              backgroundColor: Colors.transparent,
              floating:
                  true, // We can also uncomment this line and set `pinned` to true to see a pinned search bar.
              title: FocusScope(
                node: focusNode,
                onFocusChange: (isFocused) {
                  debugPrint('focused $isFocused');
                  if (isFocused) {
                    focusNode.unfocus();
                  }
                },
                child: SearchAnchor.bar(
                    suggestionsBuilder:
                        (BuildContext context, SearchController controller) {
                      return List<Widget>.generate(
                        5,
                        (int index) {
                          return ListTile(
                            titleAlignment: ListTileTitleAlignment.center,
                            title: Text('Initial list item $index'),
                          );
                        },
                      );
                    },
                    barTrailing: [
                      IconButton.filledTonal(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => const AlertDialog(
                                    title: Text("Title"),
                                    content: Text("Content"),
                                  ));
                        },
                        icon: ClipOval(
                          child: Image.network(
                            "https://www.gravatar.com/avatar/b004c065bc529e98545e27af859152bb74007e535f2c149284117cfb520e76d6?d=retro&f=y",
                            height: 24,
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
            // The listed items below are just for filling the screen
            // so we can see the scrolling effect.
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  height: 100.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 100.0,
                        child: Card(
                          child: Center(child: Text('Card $index')),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 1000,
                  color: Colors.deepPurple.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
