#! /bin/bash
#
# 
# TODOs
# TODO: SSL port?
# TODO: There is admin port, how to deal with it? How do they deal with tomcat admin port
# TODO: add md5 verify to glassfish download

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
	jar cvf $(build_dir)/glassfish3-plugin.zip control setup glassfish3

clean:
	rm -rf $(build_dir)
	rm -rf glassfish3

