part of 'auth_shared_widgets.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: <Widget>[
        Expanded(
          child: Divider(
            thickness: 2, // Adjust the thickness of the divider
            color: Colors.grey, // Set color for the divider
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 8.0), // Space around the text
          child: Text(
            "or continue with",
            style: TextStyle(fontSize: 16), // Customize text style
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 2,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
