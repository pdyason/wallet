import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:wallet/app/styles.dart';
import 'package:wallet/data/repositories/asset_data.dart';

class ReadmePage extends StatelessWidget {
  const ReadmePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.listBackgroundColor,
      appBar: AppBar(
        backgroundColor: Styles.listBackgroundColor,
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Center(child: ReadmeView()),
      ),
    );
  }
}

class ReadmeView extends StatelessWidget {
  const ReadmeView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: AssetData.getReadme(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error fetching data');
          }
          if (snapshot.hasData) {
            return Markdown(data: snapshot.data ?? '');
          }
          return const CircularProgressIndicator();
        });
  }
}
