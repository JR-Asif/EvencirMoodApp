import 'package:flutter/material.dart';

import 'package:evencir_mood_app/core/theme/fitness_theme.dart';

class FitnessNavItem {
  const FitnessNavItem({required this.label, required this.assetPath});

  final String label;
  final String assetPath;
}

class FitnessBottomNavigation extends StatelessWidget {
  const FitnessBottomNavigation({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  final List<FitnessNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final topEdge = p.textPrimary.withValues(alpha: 0.08);
    return Material(
      color: p.background,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: p.background,
          border: Border(
            top: BorderSide(
              color: topEdge,
              width: 0.5,
            ),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 6, 8, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (var i = 0; i < items.length; i++)
                  _NavSlot(
                    item: items[i],
                    selected: i == currentIndex,
                    onTap: () => onTap(i),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavSlot extends StatelessWidget {
  const _NavSlot({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final FitnessNavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final color = selected
        ? p.textPrimary
        : p.navItemUnselected;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        splashColor: p.neonGreen.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(FitnessRadii.sheet),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 22,
                height: 22,
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    color,
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    item.assetPath,
                    width: 22,
                    height: 22,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                item.label,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: selected ? FontWeight.w500 : FontWeight.w400,
                  letterSpacing: 0.12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
