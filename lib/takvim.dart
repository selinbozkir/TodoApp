import 'package:udemy_proje001/widgets/toolbar.dart';
import 'package:flutter/material.dart';

class TakvimSayfasi extends StatelessWidget {
  DateTime? selectedDate;
  void _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      selectedDate = pickedDate;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ToolBar(selectedDate: pickedDate),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 2, 165, 119),
              onPrimary: Color.fromARGB(255, 255, 255, 255),
            ),
            onPressed: () => _selectDate(context),
            child: Text('Takvimi Aç'),
          ),
          SizedBox(height: 16),
          selectedDate != null ? Text('') : Text('Henüz bir tarih seçilmedi.'),
        ],
      ),
    );
  }
}
