import 'package:flutter/material.dart';

import 'package:evencir_mood_app/core/theme/fitness_theme.dart';

const _monthNames = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

String formatMonthYear(DateTime d) =>
    '${_monthNames[d.month - 1]} ${d.year}';

String formatTodayLine(DateTime d) =>
    'Today, ${d.day} ${_monthNames[d.month - 1]} ${d.year}';

String formatShortMonthDay(DateTime d) =>
    '${_monthNames[d.month - 1]} ${d.day}';

int _daysInMonth(int year, int month) => DateTime(year, month + 1, 0).day;

bool isSameCalendarDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

Future<DateTime?> showFitnessMonthCalendarPicker(
  BuildContext context, {
  required DateTime selectedDate,
}) {
  final initial = DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
  );

  final barrier = context.palette.monthSheetBarrier;

  return showModalBottomSheet<DateTime>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: barrier,
    builder: (ctx) {
      return _MonthCalendarSheet(initialSelected: initial);
    },
  );
}

class _MonthCalendarSheet extends StatefulWidget {
  const _MonthCalendarSheet({required this.initialSelected});

  final DateTime initialSelected;

  @override
  State<_MonthCalendarSheet> createState() => _MonthCalendarSheetState();
}

class _MonthCalendarSheetState extends State<_MonthCalendarSheet> {
  late DateTime _visibleMonth;
  late DateTime _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialSelected;
    _visibleMonth = DateTime(_selected.year, _selected.month);
  }

  void _prevMonth() {
    setState(() {
      _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month + 1);
    });
  }

  void _pickDay(int day) {
    final picked = DateTime(_visibleMonth.year, _visibleMonth.month, day);
    setState(() => _selected = picked);
    Navigator.of(context).pop(picked);
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final bottomPad = MediaQuery.paddingOf(context).bottom;
    final maxH = MediaQuery.sizeOf(context).height * 0.58;

    return Align(
      alignment: Alignment.bottomCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxH),
        child: Material(
          color: p.card,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(FitnessRadii.card),
          ),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomPad > 0 ? bottomPad : 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: p.dividerHandle,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: _prevMonth,
                        icon: Icon(
                          Icons.chevron_left_rounded,
                          color: p.textPrimary.withValues(alpha: 0.9),
                          size: 28,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          formatMonthYear(_visibleMonth),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: p.textPrimary,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.35,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: _nextMonth,
                        icon: Icon(
                          Icons.chevron_right_rounded,
                          color: p.textPrimary.withValues(alpha: 0.9),
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      for (final d in _weekdayLabels)
                        Expanded(
                          child: Text(
                            d,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: p.textSecondary,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.6,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: _MonthGrid(
                    visibleMonth: _visibleMonth,
                    selected: _selected,
                    onDayTap: _pickDay,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const _weekdayLabels = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

class _MonthGrid extends StatelessWidget {
  const _MonthGrid({
    required this.visibleMonth,
    required this.selected,
    required this.onDayTap,
  });

  final DateTime visibleMonth;
  final DateTime selected;
  final ValueChanged<int> onDayTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final year = visibleMonth.year;
    final month = visibleMonth.month;
    final first = DateTime(year, month, 1);
    final daysInMonth = _daysInMonth(year, month);
    final leading = first.weekday - 1;
    final totalCells = ((leading + daysInMonth + 6) ~/ 7) * 7;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 4,
        crossAxisSpacing: 2,
        mainAxisExtent: 36,
      ),
      itemCount: totalCells,
      itemBuilder: (context, index) {
        if (index < leading || index >= leading + daysInMonth) {
          return const SizedBox.shrink();
        }
        final day = index - leading + 1;
        final cellDate = DateTime(year, month, day);
        final isSel = isSameCalendarDay(cellDate, selected);

        return GestureDetector(
          onTap: () => onDayTap(day),
          behavior: HitTestBehavior.opaque,
          child: Center(
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    isSel ? p.neonGreen.withValues(alpha: 0.30) : null,
                border: isSel ? Border.all(color: p.neonGreen, width: 2) : null,
              ),
              alignment: Alignment.center,
              child: Text(
                '$day',
                style: TextStyle(
                  color: isSel ? Colors.white : p.textPrimary,
                  fontSize: 15,
                  fontWeight: isSel ? FontWeight.w600 : FontWeight.w500,
                  letterSpacing: -0.3,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
