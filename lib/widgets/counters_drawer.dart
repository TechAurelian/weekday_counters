// Copyright 2020-2022 TechAurelian. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../common/app_strings.dart';
import '../models/counter.dart';
import '../utils/utils.dart';
import 'color_list_tile.dart';

/// Drawer extra actions enumeration.
enum DrawerExtraActions { settings, help, rate }

/// A material design drawer that shows navigation links for all available counters.
class CountersDrawer extends StatelessWidget {
  /// Creates a counters drawer widget.
  const CountersDrawer({
    super.key,
    required this.title,
    required this.counters,
    this.onExtraSelected,
  });

  /// The title of the drawer displayed in the drawer header.
  final String title;

  /// The map of counters.
  final Counters counters;

  /// Called when the user taps a drawer list tile.
  final void Function(DrawerExtraActions value)? onExtraSelected;

  void _onExtraActionTap(BuildContext context, DrawerExtraActions action) {
    Navigator.pop(context);
    onExtraSelected?.call(action);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListTileTheme(
        selectedColor: Colors.black,
        child: ListView(
          children: <Widget>[
            _buildDrawerHeader(context),
            ...CounterType.values.map((type) => _buildCounterListTile(context, type)),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text(AppStrings.settingsItemTitle),
              onTap: () => _onExtraActionTap(context, DrawerExtraActions.settings),
            ),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text(AppStrings.helpItemTitle),
              onTap: () => _onExtraActionTap(context, DrawerExtraActions.help),
            ),
            ListTile(
              leading: const Icon(Icons.rate_review),
              title: const Text(AppStrings.rateItemTitle),
              onTap: () => _onExtraActionTap(context, DrawerExtraActions.rate),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight + 8.0,
      child: DrawerHeader(
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }

  Widget _buildCounterListTile(BuildContext context, CounterType counterType) {
    return ColorListTile(
      color: Counter.colorOf(counterType),
      title: Counter.nameOf(counterType),
      subtitle: toDecimalString(context, counters[counterType].value),
      enabled: counterType == counters.current.type,
      selected: counterType == counters.current.type,
      onTap: () => Navigator.pop(context),
    );
  }
}
