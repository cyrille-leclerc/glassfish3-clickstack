# GlassFish v3 ClickStack

Glassfish v3 ClickStack for CloudBees PaaS. Deploy any Servlet2.x/3.x/JSP/JAX-RS app on GlassFish v3. 

# Pre-requisite

* OpenJDK 6
* Bash shell

# Build 

    $ make clean pkg

This produces a glassfish3-plugin.zip file that can be uploaded by CloudBees engineers to be used with the glassfish3 alias.

# JMX-Invoker

### Read attribute: List Logback Loggers

#### Invocation

```
$ bees app:instance:invoke -v \
    -i cyrille-leclerc/fb3bee0a-c2d32a80 \
    --script jmx_invoker \
    --args "--object-name ch.qos.logback.classic:Name=cocktail-app,Type=ch.qos.logback.classic.jmx.JMXConfigurator --attribute LoggerList"
```

#### Result

```
Exit code: 0
[main] INFO com.cloudbees.jmx.JmxInvoker - get attribute value ch.qos.logback.classic:Name=cocktail-app,Type=ch.qos.logback.classic.jmx.JMXConfigurator:LoggerList:[ROOT, audit, org, org.jmxtrans, ..., org.jmxtrans.embedded.samples, org.springframework, ...]
[main] INFO com.cloudbees.jmx.JmxInvoker - INVOCATION RESULT
[main] INFO com.cloudbees.jmx.JmxInvoker - #################
[main] INFO com.cloudbees.jmx.JmxInvoker - pid: 10105
[main] INFO com.cloudbees.jmx.JmxInvoker - object-name: ch.qos.logback.classic:Name=cocktail-app,Type=ch.qos.logback.classic.jmx.JMXConfigurator
[main] INFO com.cloudbees.jmx.JmxInvoker - get attribute LoggerList
[main] INFO com.cloudbees.jmx.JmxInvoker - ch.qos.logback.classic:Name=cocktail-app,Type=ch.qos.logback.classic.jmx.JMXConfigurator
[main] INFO com.cloudbees.jmx.JmxInvoker - 	[ROOT, audit, org, org.jmxtrans, ..., org.jmxtrans.embedded.samples, org.springframework, ...]
```



### Invoke Operation: Set LogBack Logger Level

Set Logger `org.jmxtrans.embedded.samples` to level `TRACE`.

```
$ bees app:instance:invoke  \
    -i cyrille-leclerc/fb3bee0a-c2d32a80 \
    --script jmx_invoker \
    --args "--object-name ch.qos.logback.classic:Name=cocktail-app,Type=ch.qos.logback.classic.jmx.JMXConfigurator --operation setLoggerLevel org.jmxtrans.embedded.samples TRACE"
```

#### Result

```
  Exit code: 0
  [main] INFO com.cloudbees.jmx.JmxInvoker - Invoke ch.qos.logback.classic:Name=cocktail-app,Type=ch.qos.logback.classic.jmx.JMXConfigurator:setLoggerLevel([org.jmxtrans.embedded.samples, TRACE]): null
  [main] INFO com.cloudbees.jmx.JmxInvoker - INVOCATION RESULT
  [main] INFO com.cloudbees.jmx.JmxInvoker - #################
  [main] INFO com.cloudbees.jmx.JmxInvoker - pid: 10105
  [main] INFO com.cloudbees.jmx.JmxInvoker - object-name: ch.qos.logback.classic:Name=cocktail-app,Type=ch.qos.logback.classic.jmx.JMXConfigurator
  [main] INFO com.cloudbees.jmx.JmxInvoker - invoke operation setLoggerLevel[org.jmxtrans.embedded.samples, TRACE]
  [main] INFO com.cloudbees.jmx.JmxInvoker - ch.qos.logback.classic:Name=cocktail-app,Type=ch.qos.logback.classic.jmx.JMXConfigurator
  [main] INFO com.cloudbees.jmx.JmxInvoker - 	null```
```

### Invoke Operation: Get LogBack Logger Level

#### Invocation

```
$ bees app:instance:invoke  \
    -i cyrille-leclerc/fb3bee0a-c2d32a80 \
    --script jmx_invoker \
    --args "--object-name ch.qos.logback.classic:Name=cocktail-app,Type=ch.qos.logback.classic.jmx.JMXConfigurator --operation getLoggerLevel org.jmxtrans.embedded.samples"
```

#### Result

```
Exit code: 0
[main] INFO com.cloudbees.jmx.JmxInvoker - Invoke ch.qos.logback.classic:Name=cocktail-app,Type=ch.qos.logback.classic.jmx.JMXConfigurator:getLoggerLevel([org.jmxtrans.embedded.samples]): TRACE
[main] INFO com.cloudbees.jmx.JmxInvoker - INVOCATION RESULT
[main] INFO com.cloudbees.jmx.JmxInvoker - #################
[main] INFO com.cloudbees.jmx.JmxInvoker - pid: 10105
[main] INFO com.cloudbees.jmx.JmxInvoker - object-name: ch.qos.logback.classic:Name=cocktail-app,Type=ch.qos.logback.classic.jmx.JMXConfigurator
[main] INFO com.cloudbees.jmx.JmxInvoker - invoke operation getLoggerLevel[org.jmxtrans.embedded.samples]
[main] INFO com.cloudbees.jmx.JmxInvoker - ch.qos.logback.classic:Name=cocktail-app,Type=ch.qos.logback.classic.jmx.JMXConfigurator
[main] INFO com.cloudbees.jmx.JmxInvoker - 	TRACE
```

# TODOs

* Clustering, session store
* Lot more testing...