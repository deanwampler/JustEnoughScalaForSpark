
README For Using Spark Notebook

For conferences and self-study, this tutorial runs with [Spark Notebook](http://spark-notebook.io). You will need to install and run the _Spark Notebook_ runtime. You can do this either by downloading it and running it "natively" on your computer, or by running it in Docker. Using Docker may work better on Windows.

### Downloading Spark Notebook

If you don't want to use Docker, Go to one of the following download pages and click the _Download here_ link:

* [Zip](http://spark-notebook.io/dl/zip/0.6.3/2.11/1.6.2/2.7.2/true/true) file (for all platforms).
* [TGZ](http://spark-notebook.io/dl/tgz/0.6.3/2.11/1.6.2/2.7.2/true/true) file (best for Mac OSX or Linux).

Expand the archive somewhere convenient and change to the root directory that's created for the application. I'll refer to this directory as `SPARK_NOTEBOOK_HOME`.

### Docker


#### Windows

* For Windows 10 or Enterprise 64-bit Windows: https://www.docker.com/products/docker#/windows
* For previous Windows releases: https://www.docker.com/products/docker-toolbox


###


 docker pull andypetrella/spark-notebook:0.6.3-scala-2.11.7-spark-1.6.2-hadoop-2.7.2-with-hive-with-parquet
 docker run -p 9000:9000 andypetrella/spark-notebook:0.6.3-scala-2.11.7-spark-1.6.2-hadoop-2.7.2-with-hive-with-parquet
