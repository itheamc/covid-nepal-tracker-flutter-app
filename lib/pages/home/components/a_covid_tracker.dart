import 'package:covid_nepal_tracker/controllers/connectivity_controller.dart';
import 'package:covid_nepal_tracker/controllers/covid_case_controller.dart';
import 'package:covid_nepal_tracker/models/covid_case.dart';
import 'package:covid_nepal_tracker/utils/extension_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ACovidTracker extends StatefulWidget {
  const ACovidTracker({Key? key}) : super(key: key);

  @override
  State<ACovidTracker> createState() => _ACovidTrackerState();
}

class _ACovidTrackerState extends State<ACovidTracker> {
  // Scroll controllers for controlling the scroll behaviours
  late ScrollController _trackerScrollController;

  // Text Editing controller for text field controlling
  late TextEditingController _searchEditingController;

  // Controllers
  CovidCaseController get _caseController => Get.find();

  ConnectivityController get _connectivityController => Get.find();

  @override
  void initState() {
    super.initState();
    _trackerScrollController = ScrollController();
    _searchEditingController = TextEditingController(text: "Nepal");
  }

  ThemeData get _theme => Theme.of(context);

  @override
  Widget build(BuildContext context) {
    _caseController.fetchCovidCases("nepal");

    return CustomScrollView(
      controller: _trackerScrollController,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5.0,
            vertical: 20.0,
          ),
          sliver: SliverToBoxAdapter(
            child: Text(
              "Type the country name",
              style: _theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: _theme.primaryColor,
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          sliver: SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: _theme.dividerColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.only(top: 5.0),
              child: TextFormField(
                controller: _searchEditingController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "e.g. Nepal, India etc.",
                  prefixIcon: Icon(Icons.search),
                ),
                textInputAction: TextInputAction.search,
                onFieldSubmitted: _onSubmitted,
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5.0,
            vertical: 15.0,
          ),
          sliver: SliverToBoxAdapter(
            child: Obx(
              () {
                final covidCases = _caseController.covidCases;
                final covidCase =
                    covidCases.isNotEmpty ? covidCases.last : CovidCase();

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200.0,
                      decoration: BoxDecoration(
                        color: _theme.dividerColor.withOpacity(0.05),
                        border: Border.all(
                          color: _theme.primaryColor,
                          width: 3.0,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Image.asset(
                            "assets/images/map.png",
                            width: double.maxFinite,
                            fit: BoxFit.contain,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "COVID-19",
                                    style: _theme.textTheme.headline4?.copyWith(
                                      fontWeight: FontWeight.w900,
                                      color: _theme.textTheme.labelLarge?.color,
                                    ),
                                  ),
                                  Container(
                                    color: Colors.red,
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "UPDATES",
                                      style: _theme.textTheme.titleMedium
                                          ?.copyWith(
                                        color: Colors.white70,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: _CaseTile(
                                title: "Confirmed",
                                cases: covidCase.confirmed ?? 0,
                                color: Colors.red,
                              ),
                            ),
                            Expanded(
                              child: _CaseTile(
                                title: "Active",
                                cases: covidCase.active ?? 0,
                                color: Colors.blue,
                                crossAxisAlignment: CrossAxisAlignment.end,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: _CaseTile(
                                title: "Recovered",
                                cases: covidCase.recovered ?? 0,
                                color: Colors.green,
                              ),
                            ),
                            Expanded(
                              child: _CaseTile(
                                title: "Death",
                                cases: covidCase.deaths ?? 0,
                                color: Colors.blueGrey,
                                crossAxisAlignment: CrossAxisAlignment.end,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  // Method to handle the search text submit
  Future<void> _onSubmitted(String s) async {
    if (s.trim().isEmpty) {
      Get.showSnackbar(
        const GetSnackBar(
          message: "Enter country name!!",
          margin: EdgeInsets.all(15.0),
          duration: Duration(milliseconds: 1500),
        ),
      );
      return;
    }
    if (!_connectivityController.hasInternet) {
      Get.showSnackbar(
        const GetSnackBar(
          message: "No internet connection!!",
          margin: EdgeInsets.all(15.0),
          duration: Duration(milliseconds: 1500),
        ),
      );
      return;
    }

    await _caseController.fetchCovidCases(s.trim().toLowerCase());
  }

  @override
  void dispose() {
    _trackerScrollController.dispose();
    _searchEditingController.dispose();
    super.dispose();
  }
}

/// Stateless widget for the _case tile
class _CaseTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final num cases;
  final Color? color;
  final CrossAxisAlignment crossAxisAlignment;

  const _CaseTile({
    Key? key,
    required this.title,
    this.subtitle = "Total",
    required this.cases,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title.toUpperCase(),
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          subtitle,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: color?.withOpacity(0.85),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          cases.toGroupSeparate,
          style: theme.textTheme.headline4?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
