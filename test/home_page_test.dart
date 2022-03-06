import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/helper/database_helper.dart';
import 'package:restaurant_app/pages/favorite_page.dart';
import 'package:restaurant_app/provider/database_provider.dart';

Widget createHomeScreen() => ChangeNotifierProvider<DatabaseProvider>(
      create: (context) => DatabaseProvider(databaseHelper: DatabaseHelper()),
      child: MaterialApp(
        home: FavoritePage(),
      ),
    );

void main() {
  group('Home Page Widget Tests', () {
    testWidgets('Testing jika ListView dapat tertampil', (tester) async {
      await tester.pumpWidget(createHomeScreen());
      expect(find.byType(ListView), findsOneWidget);
    });
    testWidgets('Testing Scroll ListView', (tester) async {
      await tester.pumpWidget(createHomeScreen());
      await tester.fling(find.byType(ListView), Offset(0, -200), 3000);
      await tester.pump();
      expect(find.byType(ListView), findsOneWidget);
    });
  });
}
