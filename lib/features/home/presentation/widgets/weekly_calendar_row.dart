import 'package:flutter/material.dart';

import 'package:evencir_mood_app/core/theme/fitness_theme.dart';

class WeekDayModel {
  const WeekDayModel({
    required this.label,
    required this.date,
    required this.isSelected,
  });

  final String label;
  final int date;
  final bool isSelected;
}

class WeeklyCalendarRow extends StatelessWidget {
  const WeeklyCalendarRow({
    super.key,
    required this.days,
    required this.onDaySelected,
  });

  final List<WeekDayModel> days;
  final ValueChanged<int> onDaySelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var i = 0; i < days.length; i++)
          Expanded(
            child: _DayCell(model: days[i], onTap: () => onDaySelected(i)),
          ),
      ],
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({required this.model, required this.onTap});

  final WeekDayModel model;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return InkWell(
      onTap: onTap,
      splashColor: p.neonGreen.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(32),
      child: Column(
        children: [
          Text(
            model.label,
            style: TextStyle(
              color: model.isSelected
                  ? p.textSecondary
                  : p.textTertiary,
              fontSize: 11,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.25,
            ),
          ),
          const SizedBox(height: 8),
          AnimatedContainer(
            duration: const Duration(milliseconds: 240),
            curve: Curves.easeOutCubic,
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: model.isSelected
                  ? p.neonGreen.withValues(alpha: 0.30)
                  : p.cardElevated,
              border: model.isSelected
                  ? Border.all(color: p.neonGreen, width: 2)
                  : null,
            ),
            alignment: Alignment.center,
            child: Text(
              '${model.date}',
              style: TextStyle(
                color: model.isSelected ? Colors.white : p.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.25,
              ),
            ),
          ),
          const SizedBox(height: 6),
          AnimatedContainer(
            duration: const Duration(milliseconds: 240),
            curve: Curves.easeOutCubic,
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: model.isSelected
                  ? p.neonGreen
                  : Colors.transparent,
              boxShadow: model.isSelected
                  ? [
                      BoxShadow(
                        color: p.neonGreen.withValues(alpha: 0.55),
                        blurRadius: 6,
                        spreadRadius: 0.5,
                      ),
                    ]
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
