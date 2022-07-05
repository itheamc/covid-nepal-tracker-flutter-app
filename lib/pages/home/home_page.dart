import 'package:covid_nepal_tracker/pages/home/components/a_covid_tracker.dart';
import 'package:covid_nepal_tracker/pages/home/components/a_map_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // Tab Controller to manage the tab activities
  late TabController _tabController;

  // Label for out tabs
  final _tabLabels = <String>["Tracker", "Map"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabLabels.length, vsync: this);
  }

  ThemeData get _theme => Theme.of(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Covid Nepal - Tracker"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.purple,
            child: TabBar(
              controller: _tabController,
              labelStyle: _theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              tabs: _tabLabels
                  .map(
                    (e) => Tab(
                      text: e,
                    ),
                  )
                  .toList(),
            ),
          ),
          Flexible(
            child: TabBarView(
              controller: _tabController,
              children: const [
                // For Tracker Tabs
                ACovidTracker(),
                // For Map Tab
                AMapView(),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
