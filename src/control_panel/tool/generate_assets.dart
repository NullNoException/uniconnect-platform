import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:control_panel/tools/logo_creator.dart';

Future<void> main() async {
  // Ensure we're running from the project root
  final scriptDir = path.dirname(Platform.script.toFilePath());
  final projectDir = path.normalize(path.join(scriptDir, '..'));

  print('Generating assets for UniConnect Admin Panel...');

  // Create the assets directory if it doesn't exist
  final assetsDir = path.join(projectDir, 'assets', 'images');
  final directory = Directory(assetsDir);
  if (!await directory.exists()) {
    await directory.create(recursive: true);
    print('Created directory: $assetsDir');
  }

  // Generate the logo
  print('Generating logo...');
  final logoBytes = await LogoCreator.createLogo();

  // Save the logo
  final logoPath = path.join(assetsDir, 'logo.png');
  File(logoPath).writeAsBytesSync(logoBytes);
  print('Logo saved to: $logoPath');

  // Create light and dark variations
  // Note: In a real app, you would create actual variations
  // Here we just copy the same file for simplicity
  final logoLightPath = path.join(assetsDir, 'logo_light.png');
  final logoDarkPath = path.join(assetsDir, 'logo_dark.png');

  File(logoLightPath).writeAsBytesSync(logoBytes);
  print('Light logo saved to: $logoLightPath');

  File(logoDarkPath).writeAsBytesSync(logoBytes);
  print('Dark logo saved to: $logoDarkPath');

  print('Asset generation completed!');
  exit(0);
}
