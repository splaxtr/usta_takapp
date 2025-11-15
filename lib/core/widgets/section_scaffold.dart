import 'package:flutter/material.dart';

class SectionScaffold extends StatelessWidget {
  final List<Tab> tabs;
  final List<Widget> children;

  const SectionScaffold({
    super.key,
    required this.tabs,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          Material(
            color: Theme.of(context).colorScheme.surface,
            child: TabBar(
              tabs: tabs,
              isScrollable: true,
              indicatorColor: Theme.of(context).colorScheme.primary,
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Colors.grey,
            ),
          ),
          Expanded(child: TabBarView(children: children)),
        ],
      ),
    );
  }
}
