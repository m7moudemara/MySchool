// data/repositories/user_repository_impl.dart

import 'package:MySchool/features/school/data/data_sources/user_remote_data_source.dart';

import 'package:MySchool/features/school/domain/entities/user_type.dart';


import '../../domain/repositories/user_repository.dart';


class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<IUser>> getAllParents() async {
    return await remoteDataSource.fetchAllParents();
  }

  @override
  Future<List<IUser>> getAllStudents() async {
    
    return await remoteDataSource.fetchAllStudents();
  }

 @override
  Future<List<IUser>> getAllTeachers() async {
    return await remoteDataSource.fetchAllTeachers();
  
  }
}
