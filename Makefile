#! /bin/bash
#
# Build the GlassFish v3 plugin
# 
# TODOs
# TODO: SSL port?
# TODO: add md5 verify to glassfish download?
#

build_dir = ./build
pkg_dir = ./build/plugin
glassfish_url="http://download.java.net/glassfish/3.1.2.2/release/glassfish-3.1.2.2-web.zip"

compile:
	mkdir -p $(build_dir)
	@if [ -e $(build_dir)/glassfish.zip ]; then \
	   echo "Skipping GlassFish download"; \
	else \
	   echo "Downloading GlassFish..."; \
	   curl -v -L $(glassfish_url) > $(build_dir)/glassfish.zip; \
	fi

package: compile
	unzip -d . $(build_dir)/glassfish.zip
	cp server/conf/domain.xml glassfish3/glassfish/domains/domain1/config/domain.xml
	chmod 755 glassfish3/glassfish/domains/domain1/config
	chmod 644 glassfish3/glassfish/domains/domain1/config/*
	zip -9 -r  "$(build_dir)/glassfish3-plugin.zip" control setup functions java glassfish3

clean:
	rm -f $(build_dir)/glassfish3-plugin.zip
	rm -rf glassfish3

clean-all: clean
	rm -rf $(build_dir)