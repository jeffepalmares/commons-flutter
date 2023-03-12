import 'dart:io';

import 'package:archive/archive.dart';
import 'package:byte_size/byte_size.dart';
import 'package:commons_flutter/http/dio_generic_http_client.dart';
import 'package:commons_flutter/utils/dependency_injector.dart';
import 'package:dio/dio.dart';
import 'package:filesize/filesize.dart';
import 'package:path_provider/path_provider.dart';
import 'package:disk_space/disk_space.dart';
import 'package:storage_info/storage_info.dart';

import '../exceptions/app_error.dart';

class DiskUtils {
  static Future<double> getInternalFreeDiskSpace() async {
    var space = await DiskSpace.getFreeDiskSpace;
    return space ?? 0.0;
  }

  static handleError(err, String method) {
    try {
      DependencyInjector.get<DioHttpClient>()
          .errorInterceptor
          ?.handleCustomError(AppError("Erro: $method ",
              data: RequestOptions(
                path: method,
                data: err.toString(),
              )));
    } catch (err) {
      print(err);
    }
  }

  static Future<String> getFormatedInternalFreeDiskSpace() async {
    var space = await getInternalFreeDiskSpace();
    var diskSpace = ByteSize.FromMegaBytes(space).toString('GB', 2);
    return diskSpace;
  }

  static Future<double> getTotalInternalDiskSpace() async {
    var space = await DiskSpace.getTotalDiskSpace;
    return space ?? 0.0;
  }

  static Future<String> getFormatedTotalInternalDiskSpace() async {
    var space = await DiskSpace.getTotalDiskSpace;
    var diskSpace = ByteSize.FromMegaBytes(space!).toString('GB', 2);
    return diskSpace;
  }

  static Future<double> getExternalFreeDiskSpace() async {
    var space = await StorageInfo.getExternalStorageFreeSpace;
    return space / 1024 / 1024;
  }

  static Future<String> getFormatedExternalFreeDiskSpace() async {
    var space = await getExternalFreeDiskSpace();
    var diskSpace = ByteSize.FromMegaBytes(space).toString('GB', 2);
    return diskSpace;
  }

  static Future<double> getTotalExternalDiskSpace() async {
    var space = await StorageInfo.getExternalStorageTotalSpace;
    return space / 1024 / 1024;
  }

  static Future<String> getFormatedTotalExternalDiskSpace() async {
    var space = await getTotalExternalDiskSpace();
    var diskSpace = ByteSize.FromMegaBytes(space).toString('GB', 2);
    return diskSpace;
  }

  static Future<String> getDiskSpaceUsedByPath(String path) async {
    try {
      var size = await getPathSize(path);
      size = size < 1024 * 1024 ? 0 : size;
      return filesize(size);
    } catch (err) {
      return "-";
    }
  }

  static Future<String?> getExternalPath() async {
    try {
      final paths = await getExternalStorageDirectories();
      var path = "";
      if (((paths?.length ?? 0)) >= 2) {
        path = paths![1].path;
        return path;
      }
      return null;
    } catch (err) {
      handleError(err, "getExternalPath");
      return null;
    }
  }

  static Future<String> getRootPath({bool isExternal = false}) async {
    Directory internalDirectory = await getApplicationDocumentsDirectory();

    if (isExternal) {
      String? externalPath = await getExternalPath();
      if (externalPath != null) return externalPath;
    }

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

  static bool existPath(String path) {
    try {
      var dir = Directory(path);
      var resut = dir.existsSync();
      return resut;
    } catch (err) {
      return false;
    }
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

  static Future<bool> hasExternalDisk() async {
    if (Platform.isIOS) return false;
    var extPath = await getExternalPath();
    return extPath != null;
  }
}
