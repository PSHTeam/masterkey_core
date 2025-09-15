// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:io' as _i497;

import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:masterkey_core/dependency_injection.dart' as _i1005;
import 'package:masterkey_core/src/features/auth/data/datasources/auth_local_datasource.dart'
    as _i165;
import 'package:masterkey_core/src/features/auth/data/repositories/auth_repository_impl.dart'
    as _i1049;
import 'package:masterkey_core/src/features/auth/domain/usecases/login_usecase.dart'
    as _i1020;
import 'package:masterkey_core/src/features/auth/domain/usecases/register_usecase.dart'
    as _i923;
import 'package:masterkey_core/src/features/auth/domain/usecases/update_password_hint_usecase.dart'
    as _i572;
import 'package:masterkey_core/src/features/auth/domain/usecases/update_user_usecase.dart'
    as _i763;
import 'package:masterkey_core/src/features/cards/data/datasource/card_local_datasource.dart'
    as _i493;
import 'package:masterkey_core/src/features/cards/data/repositories/card_repository_impl.dart'
    as _i399;
import 'package:masterkey_core/src/features/cards/domain/usecases/create_card_usecase.dart'
    as _i82;
import 'package:masterkey_core/src/features/cards/domain/usecases/delete_card_usecase.dart'
    as _i423;
import 'package:masterkey_core/src/features/cards/domain/usecases/get_cards_usecase.dart'
    as _i149;
import 'package:masterkey_core/src/features/cards/domain/usecases/toggle_archive_card_status_usecase.dart'
    as _i369;
import 'package:masterkey_core/src/features/cards/domain/usecases/update_card_usecase.dart'
    as _i525;
import 'package:masterkey_core/src/features/general/data/datasource/manage_local_datasource.dart'
    as _i74;
import 'package:masterkey_core/src/features/general/data/repositories/manage_data_repository_impl.dart'
    as _i455;
import 'package:masterkey_core/src/features/general/domain/usecases/backup_database_usecase.dart'
    as _i672;
import 'package:masterkey_core/src/features/general/domain/usecases/delete_database_usecase.dart'
    as _i833;
import 'package:masterkey_core/src/features/general/domain/usecases/reset_the_app_usecase.dart'
    as _i564;
import 'package:masterkey_core/src/features/general/domain/usecases/restore_backup_usecase.dart'
    as _i692;
import 'package:masterkey_core/src/features/passwords/data/datasource/collection_local_datasource.dart'
    as _i305;
import 'package:masterkey_core/src/features/passwords/data/datasource/password_local_datasource.dart'
    as _i786;
import 'package:masterkey_core/src/features/passwords/data/repositories/collection_repository_impl.dart'
    as _i595;
import 'package:masterkey_core/src/features/passwords/data/repositories/password_repository_impl.dart'
    as _i19;
import 'package:masterkey_core/src/features/passwords/domain/usecases/collection_usecases/add_collection_usecase.dart'
    as _i249;
import 'package:masterkey_core/src/features/passwords/domain/usecases/collection_usecases/delete_collection_usecase.dart'
    as _i366;
import 'package:masterkey_core/src/features/passwords/domain/usecases/collection_usecases/get_all_collections_usecase.dart'
    as _i484;
import 'package:masterkey_core/src/features/passwords/domain/usecases/collection_usecases/update_collection_usecase.dart'
    as _i795;
import 'package:masterkey_core/src/features/passwords/domain/usecases/password_usecases/add_password_usecase.dart'
    as _i299;
import 'package:masterkey_core/src/features/passwords/domain/usecases/password_usecases/delete_password_usecase.dart'
    as _i429;
import 'package:masterkey_core/src/features/passwords/domain/usecases/password_usecases/delete_passwords_usecase.dart'
    as _i668;
import 'package:masterkey_core/src/features/passwords/domain/usecases/password_usecases/enable_2fa_usecase.dart'
    as _i355;
import 'package:masterkey_core/src/features/passwords/domain/usecases/password_usecases/get_all_passwords_usecase.dart'
    as _i396;
import 'package:masterkey_core/src/features/passwords/domain/usecases/password_usecases/toggle_password_archive_status_usecase.dart'
    as _i140;
import 'package:masterkey_core/src/features/passwords/domain/usecases/password_usecases/update_password_usecase.dart'
    as _i671;
import 'package:masterkey_core/src/features/wallets/data/datasource/wallet_local_datasource.dart'
    as _i790;
import 'package:masterkey_core/src/features/wallets/data/repositories/wallet_repository_impl.dart'
    as _i370;
import 'package:masterkey_core/src/features/wallets/domain/usecases/create_wallet_usecase.dart'
    as _i821;
import 'package:masterkey_core/src/features/wallets/domain/usecases/delete_wallet_usecase.dart'
    as _i952;
import 'package:masterkey_core/src/features/wallets/domain/usecases/get_all_wallets_usecase.dart'
    as _i852;
import 'package:masterkey_core/src/features/wallets/domain/usecases/toggle_wallet_archive_status_usecase.dart'
    as _i485;
import 'package:masterkey_core/src/features/wallets/domain/usecases/update_wallet_usecase.dart'
    as _i1008;
import 'package:masterkey_core/src/src.dart' as _i1064;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i493.CardLocalDataSource>(
      () => _i493.CardLocalDataSourceImpl(gh<_i1064.AppDatabaseWrapper>()),
    );
    gh.lazySingleton<_i74.ManageLocalDatasource>(
      () => _i74.ManageLocalDatasourceImpl(
        gh<_i1064.AppDatabaseWrapper>(),
        gh<_i460.SharedPreferences>(),
        gh<_i497.Directory>(),
      ),
    );
    gh.lazySingleton<_i165.AuthLocalDatasource>(
      () => _i165.AuthLocalDatasourceImpl(
        gh<_i1064.AppDatabaseWrapper>(),
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.lazySingleton<_i1064.AuthRepository>(
      () => _i1049.AuthRepositoryImpl(gh<_i1064.AuthLocalDatasource>()),
    );
    gh.lazySingleton<_i1020.LoginUsecase>(
      () => _i1020.LoginUsecase(gh<_i1064.AuthRepository>()),
    );
    gh.lazySingleton<_i923.RegisterUsecase>(
      () => _i923.RegisterUsecase(gh<_i1064.AuthRepository>()),
    );
    gh.lazySingleton<_i572.UpdatePasswordHintUsecase>(
      () => _i572.UpdatePasswordHintUsecase(gh<_i1064.AuthRepository>()),
    );
    gh.lazySingleton<_i763.UpdateUserUsecase>(
      () => _i763.UpdateUserUsecase(gh<_i1064.AuthRepository>()),
    );
    gh.lazySingleton<_i790.WalletLocalDatasource>(
      () => _i790.WalletLocalDatasourceImpl(gh<_i1064.AppDatabaseWrapper>()),
    );
    gh.lazySingleton<_i305.CollectionLocalDatasource>(
      () => _i305.CollectionLocalDatasourceImpl(
        gh<_i1064.AppDatabaseWrapper>(),
        gh<_i497.Directory>(),
      ),
    );
    gh.lazySingleton<_i1064.ManageDataRepository>(
      () => _i455.ManageDataRepositoryImpl(gh<_i1064.ManageLocalDatasource>()),
    );
    gh.lazySingleton<_i1064.WalletRepository>(
      () => _i370.WalletRepositoryImpl(gh<_i1064.WalletLocalDatasource>()),
    );
    gh.lazySingleton<_i1064.CardRepository>(
      () => _i399.CardRepositoryImpl(gh<_i1064.CardLocalDataSource>()),
    );
    gh.lazySingleton<_i821.CreateWalletUsecase>(
      () => _i821.CreateWalletUsecase(gh<_i1064.WalletRepository>()),
    );
    gh.lazySingleton<_i952.DeleteWalletUsecase>(
      () => _i952.DeleteWalletUsecase(gh<_i1064.WalletRepository>()),
    );
    gh.lazySingleton<_i852.GetAllWalletsUsecase>(
      () => _i852.GetAllWalletsUsecase(gh<_i1064.WalletRepository>()),
    );
    gh.lazySingleton<_i485.ToggleWalletArchiveStatusUsecase>(
      () =>
          _i485.ToggleWalletArchiveStatusUsecase(gh<_i1064.WalletRepository>()),
    );
    gh.lazySingleton<_i1008.UpdateWalletUsecase>(
      () => _i1008.UpdateWalletUsecase(gh<_i1064.WalletRepository>()),
    );
    gh.lazySingleton<_i786.PasswordLocalDatasource>(
      () => _i786.PasswordLocalDatasourceImpl(
        gh<_i1064.AppDatabaseWrapper>(),
        gh<_i497.Directory>(),
      ),
    );
    gh.lazySingleton<_i82.CreateCardUsecase>(
      () => _i82.CreateCardUsecase(gh<_i1064.CardRepository>()),
    );
    gh.lazySingleton<_i423.DeleteCardUsecase>(
      () => _i423.DeleteCardUsecase(gh<_i1064.CardRepository>()),
    );
    gh.lazySingleton<_i149.GetCardsUsecase>(
      () => _i149.GetCardsUsecase(gh<_i1064.CardRepository>()),
    );
    gh.lazySingleton<_i525.UpdateCardUsecase>(
      () => _i525.UpdateCardUsecase(gh<_i1064.CardRepository>()),
    );
    gh.lazySingleton<_i369.ToggleArchiveCardStatusUsecase>(
      () => _i369.ToggleArchiveCardStatusUsecase(gh<_i1064.CardRepository>()),
    );
    gh.lazySingleton<_i672.BackupDatabaseUsecase>(
      () => _i672.BackupDatabaseUsecase(gh<_i1064.ManageDataRepository>()),
    );
    gh.lazySingleton<_i833.DeleteDatabaseUsecase>(
      () => _i833.DeleteDatabaseUsecase(gh<_i1064.ManageDataRepository>()),
    );
    gh.lazySingleton<_i564.ResetTheAppUsecase>(
      () => _i564.ResetTheAppUsecase(gh<_i1064.ManageDataRepository>()),
    );
    gh.lazySingleton<_i692.RestoreBackupUsecase>(
      () => _i692.RestoreBackupUsecase(gh<_i1064.ManageDataRepository>()),
    );
    gh.lazySingleton<_i1064.CollectionRepository>(
      () => _i595.CollectionRepositoryImpl(
        gh<_i1064.CollectionLocalDatasource>(),
      ),
    );
    gh.lazySingleton<_i249.AddCollectionUsecase>(
      () => _i249.AddCollectionUsecase(gh<_i1064.CollectionRepository>()),
    );
    gh.lazySingleton<_i366.DeleteCollectionUsecase>(
      () => _i366.DeleteCollectionUsecase(gh<_i1064.CollectionRepository>()),
    );
    gh.lazySingleton<_i484.GetAllCollectionsUsecase>(
      () => _i484.GetAllCollectionsUsecase(gh<_i1064.CollectionRepository>()),
    );
    gh.lazySingleton<_i795.UpdateCollectionUsecase>(
      () => _i795.UpdateCollectionUsecase(gh<_i1064.CollectionRepository>()),
    );
    gh.lazySingleton<_i1064.PasswordRepository>(
      () => _i19.PasswordRepositoryImpl(gh<_i1064.PasswordLocalDatasource>()),
    );
    gh.lazySingleton<_i299.AddPasswordUsecase>(
      () => _i299.AddPasswordUsecase(gh<_i1064.PasswordRepository>()),
    );
    gh.lazySingleton<_i668.DeletePasswordsUsecase>(
      () => _i668.DeletePasswordsUsecase(gh<_i1064.PasswordRepository>()),
    );
    gh.lazySingleton<_i429.DeletePasswordUsecase>(
      () => _i429.DeletePasswordUsecase(gh<_i1064.PasswordRepository>()),
    );
    gh.lazySingleton<_i355.Toggle2FAUsecase>(
      () => _i355.Toggle2FAUsecase(gh<_i1064.PasswordRepository>()),
    );
    gh.lazySingleton<_i396.GetAllPasswordsUsecase>(
      () => _i396.GetAllPasswordsUsecase(gh<_i1064.PasswordRepository>()),
    );
    gh.lazySingleton<_i140.TogglePasswordArchiveStatusUsecase>(
      () => _i140.TogglePasswordArchiveStatusUsecase(
        gh<_i1064.PasswordRepository>(),
      ),
    );
    gh.lazySingleton<_i671.UpdatePasswordUsecase>(
      () => _i671.UpdatePasswordUsecase(gh<_i1064.PasswordRepository>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i1005.RegisterModule {}
