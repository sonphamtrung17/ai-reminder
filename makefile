ifeq ($(OS),Windows_NT)
	BUILD_CMD=.\build_and_run_app.bat
else
	BUILD_CMD=zsh ./build_and_run_app.sh
endif

update_app_icon:
	cd app && dart run flutter_launcher_icons

update_splash:
	cd app && dart run flutter_native_splash:create --path=splash/splash.yaml

remove_splash:
	cd app && dart run flutter_native_splash:remove --path=splash/splash.yaml

l10n:
	@melos run l10n

clean:
	@melos clean

pub_get:
	@melos bootstrap

sync:
	@melos bootstrap
	@melos run l10n
	@melos run build_runner_all

gen_env:
	dart pub get --directory=tools
	dart run tools/lib/main.dart

build_runner_all:
	@melos run build_runner_all

build_runner_app:
	@melos run build_runner_app
build_runner_domain:
	@melos run build_runner_domain
build_runner_network:
	@melos run build_runner_network
build_runner_shared:
	@melos run build_runner_shared

build_staging_apk:
	cd tools && $(BUILD_CMD) staging build apk
build_prod_apk:
	cd tools && $(BUILD_CMD) prod build apk

build_staging_bundle:
	cd tools && $(BUILD_CMD) staging build appbundle
build_prod_bundle:
	cd tools && $(BUILD_CMD) prod build appbundle

build_staging_ipa:
	cd tools && $(BUILD_CMD) staging build ipa --export-options-plist=ios/exportOptions.plist
build_prod_ipa:
	cd tools && $(BUILD_CMD) prod build ipa --export-options-plist=ios/exportOptions.plist

pub_get_app:
	@melos run pub_get_app
pub_get_domain:
	@melos run pub_get_domain
pub_get_network:
	@melos run pub_get_network
pub_get_shared:
	@melos run pub_get_shared