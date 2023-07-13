import 'package:dependencecoping/provider/countdown/countdown.dart';
import 'package:dependencecoping/provider/static/static.dart';
import 'package:dependencecoping/storage/reset_log.dart';
import 'package:dependencecoping/tokens/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TimeModal extends StatefulWidget {
  const TimeModal({
    super.key,
    this.auth,
  });

  final User? auth;

  @override
  State<TimeModal> createState() => _TimeModalState();
}

class _TimeModalState extends State<TimeModal> {
  List<CountdownReset> resets = [];

  @override
  void initState() {
    final settings = BlocProvider.of<CountdownTimerCubit>(context);
    if (settings.state != null) resets.addAll(settings.state!.resets);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<CountdownEvent> c = [];

    for (var element in resets.reversed) {
      if (element.resumeTime != null) c.add(CountdownEvent(id: element.id!, resume: true, time: element.resumeTime!));
      c.add(CountdownEvent(id: element.id!, resume: false, time: element.resetTime));
    }

    return BlocBuilder<StaticCubit, StaticRecords?>(builder: (context, staticRec) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(children: [
          Flexible(
            child: ListView(
              children: c.map(record).toList(),
            ),
          ),
          FilledButton(
              onPressed: () {
                if (widget.auth != null) context.read<CountdownTimerCubit>().overwrite(resets);
                if (Navigator.of(context).canPop()) Navigator.of(context).pop();
              },
              child: const Text('Save')),
        ]),
      );
    });
  }

  Widget record(CountdownEvent r) {
    final tsm = GoogleFonts.spaceMono(
      textStyle: Theme.of(context).textTheme.titleSmall,
    ).copyWith(
      color: r.resume ? Theme.of(context).colorScheme.onPrimaryContainer : Theme.of(context).colorScheme.onTertiaryContainer,
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 8),
                r.resume
                    ? SvgIcon(
                        assetName: 'play_arrow',
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      )
                    : SvgIcon(
                        assetName: 'stop',
                        color: Theme.of(context).colorScheme.onTertiaryContainer,
                      ),
                const SizedBox(width: 8),
                Text(
                  DateFormat('dd.MM.yyyy HH:mm:ss').format(r.time),
                  style: tsm,
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(r.time),
                    );
                  },
                  icon: SvgIcon(
                    assetName: 'edit',
                    color: r.resume ? Theme.of(context).colorScheme.onPrimaryContainer : Theme.of(context).colorScheme.onTertiaryContainer,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CountdownEvent {
  const CountdownEvent({
    required this.id,
    required this.resume,
    required this.time,
  });

  final int id;
  final bool resume;
  final DateTime time;
}
