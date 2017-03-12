# Just Enough Scala for Spark

[![Join the chat at https://gitter.im/deanwampler/JustEnoughScalaForSpark](https://badges.gitter.im/deanwampler/JustEnoughScalaForSpark.svg)](https://gitter.im/deanwampler/JustEnoughScalaForSpark?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Strata San Jose, March 14, 2017<br/>
Strata Singapore, December 6, 2016<br/>
Strata NYC, September 27, 2016<br/>
[Dean Wampler, Ph.D.](mailto:deanwampler@gmail.com)<br/>
[Lightbend, Inc.](http://lightbend.com)

This tutorial covers the most important features and idioms of [Scala](http://scala-lang.org/) you need to use [Apache Spark's](http://spark.apache.org/) Scala APIs. Because Spark is written in Scala, Spark is driving interest in Scala, especially for _data engineers_. _Data scientists_ sometimes use Scala, but most use Python or R.

At Strata San Jose? Come to my [Office Hour](https://conferences.oreilly.com/strata/strata-ca/public/schedule/detail/59077), 11:50am–12:30pm Wednesday, March 15, 2017 (at Table B).

At  [Lightbend](http://lightbend.com), we're building an open source-based platform for streaming ("fast") data. To find out more, go to [lightbend.com/fast-data-platform](http://lightbend.com/fast-data-platform) or ask me about it. We're also [hiring](http://www.lightbend.com/company/careers)!

## Prerequisites

I'll assume you have prior programming experience, in any language. Some familiarity with Java is assumed, but if you don't know Java, you should be able to search for explanations for anything unfamiliar.

This isn't an introduction to Spark itself. Some prior exposure to Spark is helpful, but I'll briefly explain most Spark concepts we'll encounter, too.

Throughout, you'll find links to more information on important topics.

## Download the Tutorial

Begin by cloning or downloading the tutorial GitHub project [github.com/deanwampler/JustEnoughScalaForSpark](https://github.com/deanwampler/JustEnoughScalaForSpark).

## Using Spark Notebook

This tutorial uses a _notebook_ format, which is popular with data scientists, but also useful for data engineers. We'll use a Scala-centric notebook environment called [Spark Notebook](http://spark-notebook.io). Here is a list of some other popular notebook environments that also support Scala and Spark (with appropriate plugins):

* [iPython/Jupyter](https://ipython.org/) + [Apache Toree](https://toree.apache.org/)
* [Zeppelin](http://zeppelin-project.org/)
* [Beaker](http://beakernotebook.com/)
* [Databricks](https://databricks.com/) (commercial)

You will need to install and run the Spark Notebook runtime. You can do this either by downloading it and running it "natively" on your computer, or by running it in [Docker](https://docker.com). (Using Docker may work better on Windows.)

Here's how to get started:

### Install Java 7 or 8

You'll need the Java 7 or 8 (preferred) JRE (Java Runtime Environment) installed. You probably already have it installed, but if not, go [here](https://java.com/en/download/help/index_installing.xml) for instructions.

> Not sure if you have Java installed? Open a command/terminal window and type `java -version`. If you get `command not found`, well...

A separate Scala installation is _not_ required. It's bundled with Spark Notebook. However, if you want to download Scala, look at the "Scaladocs", etc., go to [scala-lang.org](http://scala-lang.org/).

### Install Spark Notebook

If you want to run it "natively" (i.e., not use Docker), visit one of the following download pages and click the _Download here_ link:

* [Zip](http://spark-notebook.io/dl/zip/0.7.0/2.11/2.0.2/2.7.2/true/true) file (for all platforms).
* [Tgz](http://spark-notebook.io/dl/tgz/0.7.0/2.11/2.0.2/2.7.2/true/true) file (best for Mac OSX or Linux).

> We're using notebook version 0.7.0 built for Spark 2.0.2, Hadoop 2.7.2, and Scala 2.11, with Hive and Parquet extensions. (See [spark-notebook.io](http://spark-notebook.io) for other configurations.) What we'll learn applies equally to Spark 1.6.X and 2.1.X releases, as well as Scala 2.10.X and 2.12.X releases.

Expand the archive somewhere convenient.

> **Tip:** I recommend using a directory path without spaces. I.e., This example has one space: `c:\foo bar\baz`.

Start Spark Notebook as follows. Open a terminal/command window and change the working directory to the root directory where you expanded the Spark Notebook archive. Run the following command:
```
bin/spark-notebook
```

You'll see some log messages, then it will wait...

> If you get an error that it fails to start, make sure Java is installed and on your path. (Run `java -version` in the same terminal.) If Java isn't an issue, try moving the Spark Notebook folder to a directory where the full path has **no** whitespace.

Now jump to <a href="#RunningTutorial">Running the Tutorial</a>.

### Docker

If you wish to use Docker instead, first install Docker if necessary; go to this [docker.com](https://www.docker.com/products/overview) page and follow the installation instructions.

Next, open a terminal window and run these two commands to download and run the same Spark Notebook build as a Docker image.


```
docker pull andypetrella/spark-notebook:0.7.0-scala-2.11.8-spark-2.0.2-hadoop-2.7.2-with-hive
docker run -p 9001:9001 andypetrella/spark-notebook:0.7.0-scala-2.11.8-spark-2.0.2-hadoop-2.7.2-with-hive
```

<a name="RunningTutorial"></a>
## Running the Tutorial

However you started Spark Notebook, you'll see a line in the terminal output like this:

```
[info] play - Listening for HTTP on /0:0:0:0:0:0:0:0:9001
```

It might show another port, but 9001 is the current default used by Spark Notebook. Open your browser to [localhost:9001](http://localhost:9001/) or the port shown at the end, if different. The UI has a **SPARK NOTEBOOK** banner and shows several directories and notebooks for sample applications that come with the application.

> **NOTES:**
> If you are using Docker with the `-p 9001:9001` option, but the `[info]` line shows a _different_ port, e.g., `9001`, then `control-c` to kill the process and restart, replacing `9001` with the actual port used.

Now we need to load the tutorial in Spark Notebook.

Under the banner and under the tabs ("Files", "Running", ...), the first line of text says "To import a notebook, drag the file onto the listing below or *click here.*"

The *click here* is a link. Click it, then navigate to where you downloaded the tutorial GitHub repository. Find and select `notebooks/JustEnoughScalaForSpark.snb`.

A new line in the UI is added with "JustEnoughScalaForSpark.snb" and an "Upload" button on the right-hand side, as shown in Figure 1:

![Step 1](images/step1.jpg)
<center><b>Figure 1:</b> Before Uploading the Notebook</center>

I've highlighted the "click here" link and the new line for the notebook.

Click the "Upload" button.

Now the line is moved towards the _bottom_ of the page and the buttons on the right-hand side are different.

![Step 2](images/step2.jpg)
<center><b>Figure 2:</b> After Uploading the Notebook</center>

Click the [JustEnoughScalaForSpark link](http://localhost:9001/notebooks/JustEnoughScalaForSpark.snb) (on the left) and the tutorial notebook will open in another browser tab. (It might take a minute to load completely.) The top of the page should look like this:

![Step 3](images/step3.jpg)
<center><b>Figure 3:</b> After Starting the Notebook</center>


> **NOTE:** If the new tab fails to open or the notebook fails to load as shown, check the terminal window where you started Spark Notebook. Are there any error messages?
>
> An alternative is to copy the `JustEnoughScalaForSpark.snb` notebook into the `notebooks` directory of the Spark Notebook distribution. If you aren't using docker, use any file copy method you like, if you are using docker, use the command `docker ps` to find the id of the running image (a 12-digit hex number), then use the command `docker cp /path/to/JustEnoughScalaForSpark.snb NNNN:/opt/docker/notebooks`, where you should replace `NNNN` with your actual id.
>
> If you can't debug the issue, post questions to the [Gitter channel](https://gitter.im/deanwampler/JustEnoughScalaForSpark) or post issues to the [GitHub repo](https://github.com/deanwampler/JustEnoughScalaForSpark/issues).

## What's Next?

Congratulations! You are now ready to go through the tutorial.

Please post any feedback, bugs, or even pull requests to the [project's GitHub page](https://github.com/deanwampler/JustEnoughScalaForSpark). Thanks.

[Dean Wampler](mailto:deanwampler@gmail.com), March 2017
