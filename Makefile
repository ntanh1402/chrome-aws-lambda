%.zip:
	curl https://noto-website-2.storage.googleapis.com/pkgs/NotoSansCJK.ttc.zip -o NotoSansCJK.ttc.zip
	unzip -d NotoSansCJK NotoSansCJK.ttc.zip
	mkdir fonts
	cp fonts.conf fonts/
	cp NotoSansCJK/NotoSansCJK.ttc fonts/
	rm -r NotoSansCJK NotoSansCJK.ttc.zip

	mkdir -p nodejs/node_modules/chrome-aws-lambda/
	cd nodejs/ && npm install lambdafs@~1.3.0 puppeteer-core@~1.20.0 --no-bin-links --no-optional --no-package-lock --no-save --no-shrinkwrap && cd -
	npm pack
	tar --directory nodejs/node_modules/chrome-aws-lambda/ --extract --file chrome-aws-lambda-*.tgz --strip-components=1
	rm chrome-aws-lambda-*.tgz
	mkdir -p $(dir $@)
	zip -9 --filesync --move --recurse-paths $@ nodejs/ fonts/
