import 'package:flutter/material.dart';


class FilterDialog extends StatefulWidget {
  final String? initialFilter;
  final String initialSortOption;
  final String initialSortDirection; // New variable for sorting direction
  final Function(String?, String, String) onFilterChanged;

  FilterDialog({
    required this.initialFilter,
    required this.initialSortOption,
    required this.initialSortDirection,
    required this.onFilterChanged,
  });

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  late String? selectedFilter;
  late String selectedSortOption;
  late String selectedSortDirection; 

  @override
  void initState() {
    super.initState();
    selectedFilter = widget.initialFilter;
    selectedSortOption = widget.initialSortOption;
    selectedSortDirection = widget.initialSortDirection;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Filter and Sorting'),
      content: Container(
        width: double.maxFinite, 
        height: 300, 
        child: ListView(
          shrinkWrap: true,
          children: [
            // Filter selection
            Text('Category:'),
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedFilter,
                items: [
                  'all',
                  'arts_centre',
                  'cafe',
                  'bar',
                  'pub',
                  'biergarten',
                 
                  'cinema',
                  'coworking_space',
                  'fast_food',
                  'fuel',
                  'ice_cream',
                  'nightclub',
                  'public_bath',
                  'restaurant',
                  'theatre',
                  'other'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedFilter = newValue;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            // Sorting selection
            Text('Sorting by:'),
            DropdownButton<String>(
              value: selectedSortOption,
              items: ['By Name', 'By Distance'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedSortOption = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            // Sorting direction selection
            Text('Sorting Direction:'),
            DropdownButton<String>(
              value: selectedSortDirection,
              items: ['Ascending', 'Descending'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedSortDirection = newValue!;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
            minimumSize: MaterialStateProperty.all<Size>(Size(100, 40)),
          ),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(
            'Close',
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
            minimumSize: MaterialStateProperty.all<Size>(Size(100, 40)),
          ),
          onPressed: () {
            widget.onFilterChanged(
                selectedFilter, selectedSortOption, selectedSortDirection);
            Navigator.of(context).pop(false);
          },
          child: Text(
            'Apply',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
