import 'dart:io';

import 'package:archive/archive.dart';
import 'package:byte_size/byte_size.dart';
import 'package:filesize/filesize.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:disk_space/disk_space.dart';

class DiskUtils {
  static Future<String> getFormatedInternalFreeDiskSpace() async {
    var space = await DiskSpace.getFreeDiskSpace;
    var diskSpace = ByteSize.FromMegaBytes(space!).toString('GB', 2);
    return diskSpace;
  }

  static Future<String> getTotalDiskSpace() async {
    var space = await DiskSpace.getTotalDiskSpace;
    var diskSpace = ByteSize.FromMegaBytes(space!).toString('GB', 2);
    return diskSpace;
  }

  static Future<String> getDiskSpaceUsed() async {
    try {
      Directory dir = await getApplicationDocumentsDirectory();
      var size = await getPathSize(dir.path);
      size = size < 1024 * 1024 ? 0 : size;
      return filesize(size);
    } catch (err) {
      return "-";
    }
  }

  static Future<String> getFormatedExternalFreeDiskSpace() async {
    try {
      Directory? directory = await getExternalStorageDirectory();
      if (directory != null) {
        var space = await DiskSpace.getFreeDiskSpaceForPath(directory.path);
        return ByteSize.FromMegaBytes(space ?? 0.0).toString('GB', 2);
      }

      return "-";
    } catch (err) {
      return "-";
    }
  }

  static Future<double?> getFreeDiskSpace() async {
    var diskSpace = await DiskSpace.getFreeDiskSpace;
    return diskSpace;
  }

  static Future<String> getRootPath({bool isExternal = false}) async {
    var allowedExternalStorage = false;

    if (Platform.isAndroid) {
      allowedExternalStorage = await Permission.storage.request().isGranted;
    }
    if (allowedExternalStorage && isExternal) {
      Directory? externalDirectory = await getExternalStorageDirectory();
      if (externalDirectory != null) return externalDirectory.path;
    }
    Directory internalDirectory = await getApplicationDocumentsDirectory();
    return internalDirectory.path;
  }

  static Future<String> unzip(List<int> file, String rootPath) async {
    final archive = ZipDecoder().decodeBytes(file);
    for (final file in archive) {
      final filename = file.name;
      if (file.isFile) {
        final data = file.content as List<int>;
        File("$rootPath/$filename")
          ..createSync(recursive: true)
          ..writeAsBytesSync(data);
      } else {
        Directory("$rootPath/$filename").create(recursive: true);
      }
    }
    return rootPath;
  }

  static Future deleteFiles(String path) async {
    Directory dir = Directory(path);
    if (dir.existsSync()) {
      await dir.delete(recursive: true);
    }
  }

  static Future<int> getPathSize(String path) async {
    int totalSize = 0;
    var dir = Directory(path);
    try {
      if (dir.existsSync()) {
        dir
            .listSync(recursive: true, followLinks: false)
            .forEach((FileSystemEntity entity) {
          if (entity is File) {
            totalSize += entity.lengthSync();
          }
        });
      }
    } catch (e) {
      rethrow;
    }
    return totalSize;
  }

  static Future<int> getFolderSize(
      {String? path, bool isExternal = false}) async {
    var userClassPath = path ?? await getRootPath(isExternal: isExternal);
    var size = await getPathSize(userClassPath);
    size = size < 1024 * 1024 ? 0 : size;
    return size;
  }

  static Future<String> getFormatedFolderSize() async {
    var size = await getFolderSize();
    return filesize(size);
  }
}
