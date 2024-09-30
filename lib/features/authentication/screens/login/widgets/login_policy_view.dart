import 'package:flutter/material.dart';

class PolicyView extends StatelessWidget {
  const PolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Privacy Policy")),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Privacy Policy",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              "Effective date: [Insert Date]",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              "1. Introduction\n"
              "We value your privacy and are committed to protecting your personal data. "
              "This Privacy Policy explains how we collect, use, and share information about you when you use our application.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              "2. Information We Collect\n"
              "We may collect the following types of information:\n"
              "- Personal Information: Such as your name, email address, and any other information you provide.\n"
              "- Usage Data: Information about how you use our application, including your IP address, device type, and operating system.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text("3. How We Use Your Information\n"
                "We may use your information for the following purposes:\n"
                "- To provide and maintain our service.\n"
                "- To notify you about changes to our service.\n"
                "- To allow you to participate in interactive features of our service when you choose to do so.\n"
                "- To provide customer support.\n"
                "- To gather analysis or valuable information so that we can improve our service.\n"
                "- To"),
          ],
        ),
      ),
    );
  }
}
