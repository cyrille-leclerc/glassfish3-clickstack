 # Glassfish3 ClickStack plugin
#
# TODO: SSL port?

plugin_name = glassfish3-plugin
publish_bucket = cloudbees-clickstack
publish_repo = testing
publish_url = s3://$(publish_bucket)/$(publish_repo)/

deps = lib/glassfish.zip lib/jmxtrans-agent.jar lib/cloudbees-jmx-invoker.jar lib/mysql-connector-java.jar

pkg_files = README.md LICENSE setup functions control server lib java

include plugin.mk

lib:
	mkdir -p lib

deps:
	cd java; make deps

clean:
	rm -rf lib
	cd java; make clean

glassfish_ver = 3.1.2.2
glassfish_src = "http://download.java.net/glassfish/$(glassfish_ver)/release/glassfish-$(glassfish_ver)-web.zip"
glassfish_src_md5 = 271f1c0d1f7481ebf34ca6b71e8c4e0f

lib/glassfish.zip: lib/genapp-setup-glassfish3.jar
	curl -fLo lib/glassfish.zip "$(glassfish_src)"
	$(call check-md5,lib/glassfish.zip,$(glassfish_src_md5))

JAVA_SOURCES := $(shell find genapp-setup-glassfish3/src -name "*.java")
JAVA_JARS = $(shell find genapp-setup-glassfish3/target -name "*.jar")

lib/genapp-setup-glassfish3.jar: $(JAVA_SOURCES) $(JAVA_JARS) lib
	cd genapp-setup-glassfish3; \
	mvn -q clean test assembly:single; \
	cd target; \
	cp genapp-setup-glassfish3-*-jar-with-dependencies.jar \
	$(CURDIR)/lib/genapp-setup-glassfish3.jar

jmxtrans_agent_ver = 1.0.4
jmxtrans_agent_url = http://repo1.maven.org/maven2/org/jmxtrans/agent/jmxtrans-agent/$(jmxtrans_agent_ver)/jmxtrans-agent-$(jmxtrans_agent_ver).jar
jmxtrans_agent_md5 = 3e6f619d2c07841812704627ed96a991

lib/jmxtrans-agent.jar: lib
	curl -fLo lib/jmxtrans-agent.jar "$(jmxtrans_agent_url)"
	$(call check-md5,lib/jmxtrans-agent.jar,$(jmxtrans_agent_md5))


jmx_invoker_ver = 1.0.2
jmx_invoker_src = http://repo1.maven.org/maven2/com/cloudbees/cloudbees-jmx-invoker/$(jmx_invoker_ver)/cloudbees-jmx-invoker-$(jmx_invoker_ver)-jar-with-dependencies.jar
jmx_invoker_md5 = c880f7545775529cfce6ea6b67277453

lib/cloudbees-jmx-invoker.jar: lib
	mkdir -p lib
	curl -fLo lib/cloudbees-jmx-invoker-jar-with-dependencies.jar "$(jmx_invoker_src)"
	# $(call check-md5,lib/cloudbees-jmx-invoker-jar-with-dependencies.jar,$(jmx_invoker_md5))

mysql_connector_ver = 5.1.25
mysql_connector_url = http://repo1.maven.org/maven2/mysql/mysql-connector-java/$(mysql_connector_ver)/mysql-connector-java-$(mysql_connector_ver).jar
mysql_connector_md5 = 46696baf8207192077ab420e5bfdc096

lib/mysql-connector-java.jar: lib
	curl -fLo lib/mysql-connector-java.jar "$(mysql_connector_url)"
	$(call check-md5,lib/mysql-connector-java.jar,$(mysql_connector_md5))
