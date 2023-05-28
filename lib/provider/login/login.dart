import 'package:sca6/auth/auth.dart';
import 'package:sca6/storage/profiles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Profile {
  Profile({
    required this.id,
    required this.email,
    required this.auth,
    required this.profile,
  });

  String id;
  String email;
  User auth;
  ProfileRecord? profile;
}

class LoginCubit extends Cubit<Profile?> {
  LoginCubit() : super(null);

  Future<void> signIn(String email, String password) async {
    final auth = await supalogin(email, password);
    if (auth == null) {
      return;
    }

    final p = await getProfile(auth);

    emit(Profile(
      id: auth.id,
      email: auth.email ?? '',
      auth: auth,
      profile: p,
    ));
  }

  Future<void> signUp(String email, String password) async {
    final auth = await suparegister(email, password);
    if (auth == null) {
      return;
    }

    final p = await getProfile(auth);

    emit(Profile(
      id: auth.id,
      email: auth.email ?? '',
      auth: auth,
      profile: p,
    ));
  }

  Future<void> signOut() async {
    emit(null);
  }

  Future<void> setBreathingTime(double breathingTime) async {
    if (state == null) {
      return;
    }

    final auth = state!.auth;

    var p = state?.profile ??
        ProfileRecord(
          firstName: '',
          secondName: '',
          breathingTime: 0,
        );

    p.breathingTime = breathingTime;

    syncProfileBreathingTime(auth, breathingTime);

    emit(Profile(
      id: auth.id,
      email: auth.email ?? '',
      auth: auth,
      profile: p,
    ));
  }

  Future<void> saveProfile(
    String firstName,
    String secondName,
  ) async {
    if (state == null) {
      return;
    }

    final auth = state!.auth;

    var p = state?.profile ??
        ProfileRecord(
          firstName: '',
          secondName: '',
          breathingTime: 0,
        );
    p.firstName = firstName;
    p.secondName = secondName;

    syncProfile(auth, p);

    emit(Profile(
      id: auth.id,
      email: auth.email ?? '',
      auth: auth,
      profile: p,
    ));
  }
}
