// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'application/weather_bloc.dart' as _i6;
import 'dio_provider.dart' as _i7;
import 'domain/repositories/implementations/weather_repository.dart' as _i5;
import 'domain/repositories/interfaces/i_weather_repository.dart' as _i4;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioProvider = _$DioProvider();
    gh.factory<_i3.Dio>(() => dioProvider.dio());
    gh.lazySingleton<_i4.IWeatherRepository>(
        () => _i5.WeatherRepository(gh<_i3.Dio>()));
    gh.factory<_i6.WeatherBloc>(
        () => _i6.WeatherBloc(gh<_i4.IWeatherRepository>()));
    return this;
  }
}

class _$DioProvider extends _i7.DioProvider {}
