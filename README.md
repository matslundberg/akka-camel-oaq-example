# akka-camel-oaq-example

**Sample code using Scala/Akka/Camel to enqueue and dequeue messages to/from an Oracle Queue (OAQ).**

Initially based on https://github.com/evbruno/akka-camel-oaq-example

### Required

 - [JDK 8 +](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)
 - [Scala 2.11.7 +](http://www.scala-lang.org/download/)
 - [Sbt 0.13 +](http://www.scala-sbt.org/download.html)
 - oracle artifacts (*aqapi12 and ojdbc5*) aren't found on Maven Central,
 	so you have to put them on your local maven repo

```
# Scala
sudo apt install scala
# Sbt, see http://www.scala-sbt.org/0.13/docs/Installing-sbt-on-Linux.html
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
sudo apt-get update
sudo apt-get install sbt
# oracle artifacts

mvn install:install-file -Dfile=`pwd`/lib/aqapi12.jar -DgroupId=com.oracle -DartifactId=aqapi12 -Dversion=10.1.0.5.0 -Dpackaging=jar
mvn install:install-file -Dfile=`pwd`/lib/ojdbc7.jar -DgroupId=com.oracle -DartifactId=ojdbc7 -Dversion=12.1.0 -Dpackaging=jar
```

### Create and start a queue/table on Oracle

```
BEGIN DBMS_AQADM.CREATE_QUEUE_TABLE(
     Queue_table        => 'MY_QUEUE',
     Queue_payload_type => 'SYS.AQ$_JMS_MESSAGE');
  END;

  BEGIN DBMS_AQADM.CREATE_QUEUE(
     Queue_name          => 'MY_QUEUE',
     Queue_table         => 'MY_QUEUE');
  END;

  BEGIN DBMS_AQADM.START_QUEUE(
     Queue_name          => 'MY_QUEUE');
  END;
```

### Run the project

Review the file **MyConfig** before you run:

```
$ sbt run
```
