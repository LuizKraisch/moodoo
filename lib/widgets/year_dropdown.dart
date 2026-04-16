import 'package:flutter/material.dart';

class YearDropdown extends StatelessWidget {
  const YearDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final bgColor = Theme.of(context).colorScheme.primary;
        final textColor = Theme.of(context).colorScheme.surface;
        final currentYear = DateTime.now().year.toString();

        return Container(
          width: 110,
          height: 40,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              dropdownColor: bgColor,
              iconEnabledColor: textColor,
              borderRadius: BorderRadius.circular(16),
              value: currentYear,
              isDense: true,
              alignment: Alignment.center,
              onChanged: (String? value) {},
              items: <String>['2026', '2027'].map<DropdownMenuItem<String>>((
                String value,
              ) {
                return DropdownMenuItem<String>(
                  value: value,
                  alignment: Alignment.center,
                  child: Text(
                    value,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
