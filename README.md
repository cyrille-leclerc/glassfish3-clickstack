# GlassFish v3 ClickStack

Glassfish v3 ClickStack for CloudBees PaaS. Deploy any Servlet2.x/3.x/JSP/JAX-RS app on GlassFish v3. 

# Pre-requisite

* OpenJDK 6
* Bash shell

# Build 

    $ make clean pkg

This produces a glassfish3-plugin.zip file that can be uploaded by CloudBees engineers to be used with the glassfish3 alias.

# JMX-Invoker

See [RUN@cloud >> CloudBees JMX Invoker](https://developer.cloudbees.com/bin/view/RUN/CloudBees_JMX_Invoker)

# TODOs

* Clustering, session store
* Lot more testing...