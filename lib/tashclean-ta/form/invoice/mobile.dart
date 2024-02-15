import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  final List<Directory>? directories = await getExternalStorageDirectories();

  if (directories != null && directories.isNotEmpty) {
    final String path = directories[0].path;

    final File file = File('$path/$fileName');

    await file.writeAsBytes(bytes, flush: true);

    OpenFile.open('$path/$fileName');
  } else {
    print('Error: Unable to get external storage directory');
  }
}
