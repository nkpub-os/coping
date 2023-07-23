import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dependencecoping/provider/login/login.dart';
import 'package:dependencecoping/tokens/input.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileModal extends StatelessWidget {
  const ProfileModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, Profile?>(builder: (context, u) {
      var cFirstName = TextEditingController(text: u?.profile?.firstName ?? '');
      var cSecondName = TextEditingController(text: u?.profile?.secondName ?? '');

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Form(
          child: Column(
            children: [
              Input(title: AppLocalizations.of(context)!.profileFirstName, ctrl: cFirstName, autocorrect: true),
              const SizedBox(height: 8),
              Input(title: AppLocalizations.of(context)!.profileSecondName, ctrl: cSecondName, autocorrect: true),
              const SizedBox(height: 8),
              Flexible(child: ListView()),
              FilledButton(
                onPressed: () {
                  context.read<LoginCubit>().saveProfile(
                        cFirstName.text,
                        cSecondName.text,
                      );
                  if (Navigator.of(context).canPop()) Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(AppLocalizations.of(context)!.profileSave),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
