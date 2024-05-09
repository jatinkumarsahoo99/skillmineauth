import 'package:flutter/material.dart';

class SignInOption {
  final String text;
  final IconData? icon; // Optional icon path
  final Color? color; // Optional custom color

  const SignInOption({
    required this.text,
    this.icon,
    this.color,
  });
}



class DynamicSignInGrid extends StatelessWidget {
  final List<SignInOption> signInOptions;
  final Function(SignInOption) onSignInSelected;

  const DynamicSignInGrid({
    Key? key,
    required this.signInOptions,
    required this.onSignInSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.count(
        crossAxisCount: 3, // Adjust column count as needed
        physics: const NeverScrollableScrollPhysics(), // Prevent unnecessary scrolling
        shrinkWrap: true, // Wrap content to avoid excessive space
        childAspectRatio: 2.0, // Adjust aspect ratio for desired button shape
        mainAxisSpacing: 8.0, // Add spacing between buttons
        crossAxisSpacing: 8.0, // Add spacing between columns
        padding: const EdgeInsets.all(3),
        children: signInOptions.map((option) => _buildSignInButton(option, context)).toList(),
      ),
    );
  }

  Widget _buildSignInButton(SignInOption option, BuildContext context) {
    return ElevatedButton(
      onPressed: () => onSignInSelected(option),
      style: ElevatedButton.styleFrom(
        // backgroundColor: option.color ?? Theme.of(context).primaryColor,
        // minimumSize: const Size(100, 40), // Set desired button size
        padding: const EdgeInsets.all(3.0), // Adjust button padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Add rounded corners
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (option.icon != null)
             Padding(
              padding:  const EdgeInsets.all(2.0), // Reduce icon padding
              child: Icon(
                option.icon,
                size: 20, // Adjust icon size
                color: option.color,
              ),
            ),
          Text(
            option.text,
            style: const TextStyle(fontSize: 14.0), // Adjust text size
          ),
        ],
      ),
    );
  }
}

