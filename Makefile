# Glassfish3 ClickStack plugin
#
# TODO: SSL port?

plugin_name = glassfish3-plugin
publish_bucket = cloudbees-clickstack
publish_repo = test
publish_url = s3://$(publish_bucket)/$(publish_repo)/

deps = lib/glassfish.zip java

pkg_files = README LICENSE setup functions control lib java

include plugin.mk

glassfish_ver = 3.1.2.2
glassfish_src = "http://download.java.net/glassfish/$(glassfish_ver)/release/glassfish-$(glassfish_ver)-web.zip"
glassfish_src_md5 = 271f1c0d1f7481ebf34ca6b71e8c4e0f

lib/glassfish.zip:
	mkdir -p lib
	curl -fLo lib/glassfish.zip "$(glassfish_src)"
	echo "$(glassfish_src_md5)  lib/glassfish.zip" | md5sum --check

java_plugin_gitrepo = git://github.com/CloudBees-community/java-clickstack.git

java:
	git clone $(java_plugin_gitrepo) java
	rm -rf java/.git
	cd java; make clean; make deps
