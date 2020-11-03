.PHONY: install
install:
	docker-compose up

.PHONY: add-cli-to-path
add-cli-to-path:
	grep -qxF 'export PATH=$PATH:$HOME/tizen-studio/tools/ide/bin' ~/.zshrc || echo 'export PATH=$PATH:$HOME/tizen-studio/tools/ide/bin' >> ~/.zshrc
	grep -qxF 'export PATH=$PATH:$HOME/tizen-studio/tools' ~/.zshrc || echo 'export PATH=$PATH:$HOME/tizen-studio/tools' >> ~/.zshrc

.PHONY: build
build:
	tizen build-web -e ".*" -e gulpfile.js -e README.md -e "node_modules/*" -e "package*.json" -e "yarn.lock"
	tizen package -t wgt -o . -- .buildResult

.PHONY: deploy-to-emulator
deploy-to-emulator:
	tizen install -n Jellyfin.wgt -t T-samsung-5.5-x86

.PHONY: deploy-to-tv
deploy-to-tv:
	read -n 1 -s -r -p "Please turn on the TV, and press any key to continue."
	read -n 1 -s -r -p "Please activate Developer Mode on TV (https://developer.samsung.com/tv/develop/getting-started/using-sdk/tv-device), and press any key to continue."
	read -n 1 -s -r -p "Permit to install applications on your TV with Device Manager from Tizen Studio, and press any key to continue."
	sdb connect 192.168.192.31 && tizen install -n Jellyfin.wgt -t UE40NU7189

.PHONY: list-devices
list-devices:
	sdb devices
