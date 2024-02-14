import 'dart:io';

Future<void> createKeyFile() async {
// TODO: Get storePassword, keyPassword, keyAlias and storeFile.
  File keyProperties = File('android/key.properties');

  await keyProperties.writeAsString('''
storePassword=<password-from-previous-step>
keyPassword=<password-from-previous-step>
keyAlias=upload
storeFile=<keystore-file-location>
''');
}
