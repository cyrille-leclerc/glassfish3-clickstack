# GlassFish v3 ClickStack

Glassfish v3 ClickStack for CloudBees PaaS. Deploy any Servlet2.x/3.x/JSP/JAX-RS app on GlassFish v3. 

# Pre-requisite

* OpenJDK 6
* Bash shell

# Build 

$ make package

After successful build upload glassfish3-plugin.zip to HTTP(S) accessible location


# Package and Deploy Sample App

## Create application zip file

$ zip -r build/hello.zip example/hello/ 

## Deploy 

$ bees app:deploy -a APP_ID -t glassfish3 -RPLUGIN.SRC.glassfish3=HTTP_LOCATION_OF_GLASSFISH_CLICKSTACK build/hello.zip


## Deploy sample app using already uploaded GlassFish v3 ClickStack

$ bees app:deploy -a APP_ID -t glassfish3 -RPLUGIN.SRC.glassfish3=http://glassfish-clickstack.s3.amazonaws.com/glassfish3-plugin.zip hello.zip



