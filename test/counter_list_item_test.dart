import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xiv_compendium/Widget/content_list_item.dart';

void main() {
  // NOTE: This is not the recommended way. Since it disable network overrides for all test
  // Unit Tests should be isolated to external API
  setUpAll(() => HttpOverrides.global = null);

  testWidgets('Test ContentListItem path and name is not empty', (WidgetTester tester) async {
    // Given
    const String name = "Test";
    const String iconPath = "i/020000/020001.png";

    bool onTapCalled = false;
    void onTap() {
      onTapCalled = true;
    }

    // When
    // NOTE: Need container to solve implicit size issue
    Widget testWidget = SizedBox(child: ContentListItem(name: name, iconPath: iconPath, onTap: onTap), height: 300, width: 1000,);
    await tester.pumpWidget(testWidget);

    // Then
    final nameFinder = find.text(name);
    expect(nameFinder, findsOneWidget);

    await tester.tap(find.byWidget(testWidget));
    expect(onTapCalled, true);
  });
}
