// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:teacher/core/network/network.dart';
import 'package:teacher/features/tasmi3/data/data_sourse/local/local_tasmi3group_local.dart';
import 'package:teacher/features/tasmi3/data/data_sourse/remote/remote_tasmi3group_remote.dart';
import 'package:teacher/features/tasmi3/domain/repository/repositry_tasmi3group.dart';

class Tasmi3groupRepoImpl implements RepositryTasmi3group {
  RemoteTasmi3groupDataSource remoteTasmi3groupDataSource;
  LocalTasmi3groupDataSource locaTasmi3groupDataSource;
  NetworkConnection networkConnection;
  Tasmi3groupRepoImpl(
      {required this.locaTasmi3groupDataSource,
      required this.networkConnection,
      required this.remoteTasmi3groupDataSource});
}
