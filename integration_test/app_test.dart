import 'package:dependencecoping/main.dart';
import 'package:dependencecoping/storage/local.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  patrolTest(
    'counter state is the same after going to home and switching apps',
    nativeAutomation: true,
    (t) async {
      await Supabase.initialize(
        url: 'https://tcqkyokyndgebhcybfhx.supabase.co',
        anonKey:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRjcWt5b2t5bmRnZWJoY3liZmh4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODU0NjUxOTMsImV4cCI6MjAwMTA0MTE5M30.Nd9M8OSPkIW2zjj_wJjPCBJi8NEApMise-W8nYso1Tw',
      );

      clearLocalStorage();

      await t.pumpWidgetAndSettle(const App());

      if (await t.native.isPermissionDialogVisible(timeout: const Duration(seconds: 5))) {
        await t.native.grantPermissionWhenInUse();
      }

      expect(t('app'), findsOneWidget);
      await t.native.pressHome();
    },
  );
}
