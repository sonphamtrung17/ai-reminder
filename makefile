ifeq ($(OS),Windows_NT)
	BUILD_CMD=.\build_and_run_app.bat
else
	BUILD_CMD=./build_and_run_app.sh
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

format:
	@melos run format

sync:
	@melos bootstrap
	@melos run l10n
	@melos run build_runner_all

gen_env:
	dart pub get --directory=tools
	dart run tools/lib/main.dart

pub_get:
	@melos bootstrap

build_runner_all:
	@melos run build_runner_all