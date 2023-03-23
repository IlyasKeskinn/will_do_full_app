import 'package:will_do_full_app/product/utility/exception/custom_exception.dart';

class VersionManager {
  VersionManager({required this.deviceVersion, required this.databaseVersion});
  final String deviceVersion;
  final String databaseVersion;

  bool isNeedUpdate() {
    final deviceVersionSplited = deviceVersion.split('.').join();
    final databaseVersionSplited = databaseVersion.split('.').join();

    final deviceVersionNumber = int.tryParse(deviceVersionSplited);
    final databaseVersionNumber = int.tryParse(databaseVersionSplited);

    if (deviceVersionNumber == null || databaseVersionNumber == null) {
      throw CustomVersionException(
        '$deviceVersionNumber or $databaseVersionNumber is not valid for parse',
      );
    }
    return deviceVersionNumber < databaseVersionNumber;
  }
}
