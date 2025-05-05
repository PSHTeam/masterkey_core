// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:masterkey_core/dependency_injection.dart' as _i623;
import 'package:masterkey_core/src/core/core.dart' as _i402;
import 'package:masterkey_core/src/features/auth/data/datasources/auth_local_datasource.dart'
    as _i1062;
import 'package:masterkey_core/src/features/auth/data/repositories/auth_repository_impl.dart'
    as _i896;
import 'package:masterkey_core/src/features/auth/domain/usecases/login_usecase.dart'
    as _i954;
import 'package:masterkey_core/src/features/auth/domain/usecases/register_usecase.dart'
    as _i322;
import 'package:masterkey_core/src/features/auth/domain/usecases/update_user_usecase.dart'
    as _i662;
import 'package:masterkey_core/src/features/cards/data/datasource/card_local_datasource.dart'
    as _i918;
import 'package:masterkey_core/src/features/cards/data/repositories/card_repository_impl.dart'
    as _i247;
import 'package:masterkey_core/src/features/cards/domain/usecases/create_card_usecase.dart'
    as _i566;
import 'package:masterkey_core/src/features/cards/domain/usecases/delete_card_usecase.dart'
    as _i904;
import 'package:masterkey_core/src/features/cards/domain/usecases/get_cards_usecase.dart'
    as _i748;
import 'package:masterkey_core/src/features/cards/domain/usecases/get_card_usecase.dart'
    as _i843;
import 'package:masterkey_core/src/features/cards/domain/usecases/search_card_usecase.dart'
    as _i655;
import 'package:masterkey_core/src/features/cards/domain/usecases/toggle_archive_card_status_usecase.dart'
    as _i1035;
import 'package:masterkey_core/src/features/cards/domain/usecases/update_card_usecase.dart'
    as _i39;
import 'package:masterkey_core/src/features/passwords/data/datasource/collection_local_datasource.dart'
    as _i382;
import 'package:masterkey_core/src/features/passwords/data/datasource/password_local_datasource.dart'
    as _i556;
import 'package:masterkey_core/src/features/passwords/data/repositories/collection_repository_impl.dart'
    as _i354;
import 'package:masterkey_core/src/features/passwords/data/repositories/password_repository_impl.dart'
    as _i282;
import 'package:masterkey_core/src/features/passwords/domain/usecases/collection_usecases/add_collection_usecase.dart'
    as _i798;
import 'package:masterkey_core/src/features/passwords/domain/usecases/collection_usecases/delete_collection_usecase.dart'
    as _i275;
import 'package:masterkey_core/src/features/passwords/domain/usecases/collection_usecases/get_all_collections_usecase.dart'
    as _i607;
import 'package:masterkey_core/src/features/passwords/domain/usecases/collection_usecases/get_collection_usecase.dart'
    as _i1029;
import 'package:masterkey_core/src/features/passwords/domain/usecases/collection_usecases/update_category_usecase.dart'
    as _i947;
import 'package:masterkey_core/src/features/passwords/domain/usecases/password_usecases/add_password_usecase.dart'
    as _i711;
import 'package:masterkey_core/src/features/passwords/domain/usecases/password_usecases/delete_password_usecase.dart'
    as _i907;
import 'package:masterkey_core/src/features/passwords/domain/usecases/password_usecases/delete_passwords_usecase.dart'
    as _i859;
import 'package:masterkey_core/src/features/passwords/domain/usecases/password_usecases/enable_2fa_usecase.dart'
    as _i27;
import 'package:masterkey_core/src/features/passwords/domain/usecases/password_usecases/get_all_passwords_usecase.dart'
    as _i592;
import 'package:masterkey_core/src/features/passwords/domain/usecases/password_usecases/get_password_usecase.dart'
    as _i428;
import 'package:masterkey_core/src/features/passwords/domain/usecases/password_usecases/toggle_password_archive_status_usecase.dart'
    as _i915;
import 'package:masterkey_core/src/features/passwords/domain/usecases/password_usecases/update_password_usecase.dart'
    as _i529;
import 'package:masterkey_core/src/features/general/data/datasource/manage_local_datasource.dart'
    as _i437;
import 'package:masterkey_core/src/features/general/data/repositories/manage_data_repository_impl.dart'
    as _i918;
import 'package:masterkey_core/src/features/general/domain/usecases/backup_database_usecase.dart'
    as _i52;
import 'package:masterkey_core/src/features/general/domain/usecases/delete_database_usecase.dart'
    as _i422;
import 'package:masterkey_core/src/features/general/domain/usecases/reset_the_app_usecase.dart'
    as _i957;
import 'package:masterkey_core/src/features/general/domain/usecases/restore_backup_usecase.dart'
    as _i242;
import 'package:masterkey_core/src/features/wallets/data/datasource/wallet_local_datasource.dart'
    as _i297;
import 'package:masterkey_core/src/features/wallets/data/repositories/wallet_repository_impl.dart'
    as _i93;
import 'package:masterkey_core/src/features/wallets/domain/usecases/create_wallet_usecase.dart'
    as _i119;
import 'package:masterkey_core/src/features/wallets/domain/usecases/delete_wallet_usecase.dart'
    as _i119;
import 'package:masterkey_core/src/features/wallets/domain/usecases/get_all_wallets_usecase.dart'
    as _i714;
import 'package:masterkey_core/src/features/wallets/domain/usecases/get_wallet_usecase.dart'
    as _i1062;
import 'package:masterkey_core/src/features/wallets/domain/usecases/search_wallet_usecase.dart'
    as _i782;
import 'package:masterkey_core/src/features/wallets/domain/usecases/toggle_wallet_archive_status_usecase.dart'
    as _i92;
import 'package:masterkey_core/src/features/wallets/domain/usecases/update_wallet_usecase.dart'
    as _i936;
import 'package:masterkey_core/src/src.dart' as _i972;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'dart:io' as _i9700;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i402.AppDatabase>(() => registerModule.database);
    await gh.singletonAsync<_i9700.Directory>(await registerModule.cacheDir);
    
    gh.lazySingleton<_i918.CardLocalDataSource>(
      () => _i918.CardLocalDataSourceImpl(gh<_i972.AppDatabase>()),
    );
    gh.lazySingleton<_i556.PasswordLocalDatasource>(
      () => _i556.PasswordLocalDatasourceImpl(
        gh<_i972.AppDatabase>(),
        gh<_i9700.Directory>(),
      ),
    );
    gh.lazySingleton<_i297.WalletLocalDatasource>(
      () => _i297.WalletLocalDatasourceImpl(gh<_i972.AppDatabase>()),
    );
    gh.lazySingleton<_i972.PasswordRepository>(
      () => _i282.PasswordRepositoryImpl(gh<_i972.PasswordLocalDatasource>()),
    );
    gh.lazySingleton<_i382.CollectionLocalDatasource>(
      () => _i382.CollectionLocalDatasourceImpl(
        gh<_i972.AppDatabase>(),
        gh<_i9700.Directory>(),
      ),
    );
    gh.lazySingleton<_i972.CardRepository>(
      () => _i247.CardRepositoryImpl(gh<_i972.CardLocalDataSource>()),
    );
    gh.lazySingleton<_i1062.AuthLocalDatasource>(
      () => _i1062.AuthLocalDatasourceImpl(
        gh<_i972.AppDatabase>(),
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.lazySingleton<_i972.CollectionRepository>(
      () =>
          _i354.CollectionRepositoryImpl(gh<_i972.CollectionLocalDatasource>()),
    );
    gh.lazySingleton<_i798.AddCollectionUsecase>(
      () => _i798.AddCollectionUsecase(gh<_i972.CollectionRepository>()),
    );
    gh.lazySingleton<_i275.DeleteCollectionUsecase>(
      () => _i275.DeleteCollectionUsecase(gh<_i972.CollectionRepository>()),
    );
    gh.lazySingleton<_i607.GetAllCollectionsUsecase>(
      () => _i607.GetAllCollectionsUsecase(gh<_i972.CollectionRepository>()),
    );
    gh.lazySingleton<_i1029.GetCollectionUsecase>(
      () => _i1029.GetCollectionUsecase(gh<_i972.CollectionRepository>()),
    );
    gh.lazySingleton<_i947.UpdateCollectionUsecase>(
      () => _i947.UpdateCollectionUsecase(gh<_i972.CollectionRepository>()),
    );
    gh.lazySingleton<_i437.ManageLocalDatasource>(
      () => _i437.ManageLocalDatasourceImpl(
        gh<_i972.AppDatabase>(),
        gh<_i460.SharedPreferences>(),
        gh<_i9700.Directory>(),
      ),
    );
    gh.lazySingleton<_i566.CreateCardUsecase>(
      () => _i566.CreateCardUsecase(gh<_i972.CardRepository>()),
    );
    gh.lazySingleton<_i904.DeleteCardUsecase>(
      () => _i904.DeleteCardUsecase(gh<_i972.CardRepository>()),
    );
    gh.lazySingleton<_i748.GetCardsUsecase>(
      () => _i748.GetCardsUsecase(gh<_i972.CardRepository>()),
    );
    gh.lazySingleton<_i843.GetCardUsecase>(
      () => _i843.GetCardUsecase(gh<_i972.CardRepository>()),
    );
    gh.lazySingleton<_i655.SearchCardUsecase>(
      () => _i655.SearchCardUsecase(gh<_i972.CardRepository>()),
    );
    gh.lazySingleton<_i39.UpdateCardUsecase>(
      () => _i39.UpdateCardUsecase(gh<_i972.CardRepository>()),
    );
    gh.lazySingleton<_i711.AddPasswordUsecase>(
      () => _i711.AddPasswordUsecase(gh<_i972.PasswordRepository>()),
    );
    gh.lazySingleton<_i859.DeletePasswordsUsecase>(
      () => _i859.DeletePasswordsUsecase(gh<_i972.PasswordRepository>()),
    );
    gh.lazySingleton<_i907.DeletePasswordUsecase>(
      () => _i907.DeletePasswordUsecase(gh<_i972.PasswordRepository>()),
    );
    gh.lazySingleton<_i27.Toggle2FAUsecase>(
      () => _i27.Toggle2FAUsecase(gh<_i972.PasswordRepository>()),
    );
    gh.lazySingleton<_i592.GetAllPasswordsUsecase>(
      () => _i592.GetAllPasswordsUsecase(gh<_i972.PasswordRepository>()),
    );
    gh.lazySingleton<_i428.GetPasswordUsecase>(
      () => _i428.GetPasswordUsecase(gh<_i972.PasswordRepository>()),
    );
    gh.lazySingleton<_i915.TogglePasswordArchiveStatusUsecase>(
      () => _i915.TogglePasswordArchiveStatusUsecase(
        gh<_i972.PasswordRepository>(),
      ),
    );
    gh.lazySingleton<_i529.UpdatePasswordUsecase>(
      () => _i529.UpdatePasswordUsecase(gh<_i972.PasswordRepository>()),
    );
    gh.lazySingleton<_i1035.ToggleArchiveCardStatusUsecase>(
      () => _i1035.ToggleArchiveCardStatusUsecase(gh<_i972.CardRepository>()),
    );
    gh.lazySingleton<_i972.ManageDataRepository>(
      () => _i918.ManageDataRepositoryImpl(gh<_i972.ManageLocalDatasource>()),
    );
    gh.lazySingleton<_i52.BackupDatabaseUsecase>(
      () => _i52.BackupDatabaseUsecase(gh<_i972.ManageDataRepository>()),
    );
    gh.lazySingleton<_i422.DeleteDatabaseUsecase>(
      () => _i422.DeleteDatabaseUsecase(gh<_i972.ManageDataRepository>()),
    );
    gh.lazySingleton<_i957.ResetTheAppUsecase>(
      () => _i957.ResetTheAppUsecase(gh<_i972.ManageDataRepository>()),
    );
    gh.lazySingleton<_i242.RestoreBackupUsecase>(
      () => _i242.RestoreBackupUsecase(gh<_i972.ManageDataRepository>()),
    );
    gh.lazySingleton<_i972.AuthRepository>(
      () => _i896.AuthRepositoryImpl(gh<_i972.AuthLocalDatasource>()),
    );
    gh.lazySingleton<_i972.WalletRepository>(
      () => _i93.WalletRepositoryImpl(gh<_i972.WalletLocalDatasource>()),
    );
    gh.lazySingleton<_i119.CreateWalletUsecase>(
      () => _i119.CreateWalletUsecase(gh<_i972.WalletRepository>()),
    );
    gh.lazySingleton<_i119.DeleteWalletUsecase>(
      () => _i119.DeleteWalletUsecase(gh<_i972.WalletRepository>()),
    );
    gh.lazySingleton<_i714.GetAllWalletsUsecase>(
      () => _i714.GetAllWalletsUsecase(gh<_i972.WalletRepository>()),
    );
    gh.lazySingleton<_i1062.GetWalletUsecase>(
      () => _i1062.GetWalletUsecase(gh<_i972.WalletRepository>()),
    );
    gh.lazySingleton<_i782.SearchWalletUsecase>(
      () => _i782.SearchWalletUsecase(gh<_i972.WalletRepository>()),
    );
    gh.lazySingleton<_i92.ToggleWalletArchiveStatusUsecase>(
      () => _i92.ToggleWalletArchiveStatusUsecase(gh<_i972.WalletRepository>()),
    );
    gh.lazySingleton<_i936.UpdateWalletUsecase>(
      () => _i936.UpdateWalletUsecase(gh<_i972.WalletRepository>()),
    );
    gh.lazySingleton<_i954.LoginUsecase>(
      () => _i954.LoginUsecase(gh<_i972.AuthRepository>()),
    );
    gh.lazySingleton<_i322.RegisterUsecase>(
      () => _i322.RegisterUsecase(gh<_i972.AuthRepository>()),
    );
    gh.lazySingleton<_i662.UpdateUserUsecase>(
      () => _i662.UpdateUserUsecase(gh<_i972.AuthRepository>()),
    );
    gh.lazySingleton<_i972.UpdatePasswordHintUsecase>(
      () => _i972.UpdatePasswordHintUsecase(gh<_i972.AuthRepository>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i623.RegisterModule {}
