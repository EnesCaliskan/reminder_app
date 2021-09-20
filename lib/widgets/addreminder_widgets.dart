import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reminder_app/assets/constants.dart';

class AddDateColumn extends StatefulWidget {
  final String dateText;
  final String date;
  const AddDateColumn({Key? key, required this.dateText, required this.date})
      : super(key: key);

  @override
  _AddDateColumnState createState() => _AddDateColumnState();
}
class _AddDateColumnState extends State<AddDateColumn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: buttonStyle,
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.date_range),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.dateText,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            widget.date,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    );
  }
}

class CreateTextField extends StatefulWidget {
  const CreateTextField({Key? key}) : super(key: key);
  @override
  _CreateTextFieldState createState() => _CreateTextFieldState();
}
class _CreateTextFieldState extends State<CreateTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Container(
        height: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.all(10.0),
        decoration: buttonStyle,
        child: TextField(
          cursorColor: kNeonRed,
          style: TextStyle(
            fontSize: 25.0,
          ),
          decoration: InputDecoration.collapsed(
              hintText: 'Enter your reminder',
          ),
          maxLines: 20,
          maxLength: 140,
        ),
      ),
    );
  }
}

class ReminderTitle extends StatelessWidget {
  const ReminderTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(top: 70.0, bottom: 20.0, left: 25.0),
        child: Text(
          'Let\'s add a reminder',
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
      ),
    );
  }
}

Decoration buttonStyle = BoxDecoration(
  color: Colors.white,
  border: Border.all(color: Colors.black, width: 2),
  boxShadow: const [
    BoxShadow(
      color: Colors.black,
      offset: Offset(10.0, 10.0),
    )
  ],
);

