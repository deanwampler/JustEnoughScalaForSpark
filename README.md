# JustEnoughScalaForSpark

This tutorial covers the most important features and idioms of Scala you need to use Spark's Scala APIs. Because Spark is written in Scala, Spark is driving interest in Scala, especially for _data engineers_. _Data scientists_ sometimes use Scala, but most use Python or R.

Begin by cloning or downloading the tutorial GitHub project [github.com/deanwampler/JustEnoughScalaForSpark](https://github.com/deanwampler/JustEnoughScalaForSpark).

In what follows, I'll use the name `JESS_HOME` to refer to the root directory for the (the same directory where this file is found).

## Using Spark Notebook

This tutorial uses a _notebook_ format, which is popular with data scientists, but also useful for data engineers. While most of the popular notebooks, like [iPython/Jupyter](https://ipython.org/), [Zeppelin](http://zeppelin-project.org/), and [Databricks](https://databricks.com/) support Scala, we'll use a Scala-centric notebook environment, called [Spark Notebook](http://spark-notebook.io). 

You will need to install and run the Spark Notebook runtime. You can do this either by downloading it and running it "natively" on your computer, or by running it in Docker. Using Docker may work better on Windows.

### Downloading Spark Notebook

If you don't want to use Docker, Go to one of the following download pages and click the _Download here_ link:

* [Zip](http://spark-notebook.io/dl/zip/0.6.3/2.11/1.6.2/2.7.2/true/true) file (for all platforms).
* [TGZ](http://spark-notebook.io/dl/tgz/0.6.3/2.11/1.6.2/2.7.2/true/true) file (best for Mac OSX or Linux).

> We're using notebook version 0.6.3 built for Spark 1.6.2, Hadoop 2.7.2, and Scala 2.11, with Hive and Parquet extensions. (See [spark-notebook.io](http://spark-notebook.io) for other configurations.) We aren't using Spark 2.0.0, because support for it is still experimental, but the actual Spark version is less important for our purposes, since we're here to learn Scala.

Expand the archive somewhere convenient.

### Running Spark Notebook

Finally, start Spark Notebook as follows.

Open a command window and change the working directory to the root directory for Spark Notebook. I'll refer to this directory as `SPARK_NOTEBOOK_HOME`.

### Docker

If you wish to use Docker instead, first go to this [docker.com](https://www.docker.com/products/overview) page and follow the instructions to install Docker on your machine.

Once Docker is installed and running, open a command window and run these two commands to download and run the same Spark Notebook build as a Docker image.


```
docker pull andypetrella/spark-notebook:0.6.3-scala-2.11.7-spark-1.6.2-hadoop-2.7.2-with-hive-with-parquet
docker run -p 9000:9000 andypetrella/spark-notebook:0.6.3-scala-2.11.7-spark-1.6.2-hadoop-2.7.2-with-hive-with-parquet
```
