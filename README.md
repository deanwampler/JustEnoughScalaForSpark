# Just Enough Scala for Spark

[![Join the chat at https://gitter.im/deanwampler/JustEnoughScalaForSpark](https://badges.gitter.im/deanwampler/JustEnoughScalaForSpark.svg)](https://gitter.im/deanwampler/JustEnoughScalaForSpark?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Spark Summit San Francisco, June 5, 2017 (Taught by [Chaoran Yu](https://github.com/yuchaoran2011))<br/>
Strata London, May 23, 2017<br/>
Strata San Jose, March 14, 2017<br/>
Strata Singapore, December 6, 2016<br/>
Strata NYC, September 27, 2016<br/>
[Dean Wampler, Ph.D.](mailto:deanwampler@gmail.com)<br/>
[Lightbend, Inc.](http://lightbend.com)

This tutorial covers the most important features and idioms of [Scala](http://scala-lang.org/) you need to use [Apache Spark's](http://spark.apache.org/) Scala APIs. Because Spark is written in Scala, Spark is driving interest in Scala, especially for _data engineers_. _Data scientists_ sometimes use Scala, but most use Python or R.

At  [Lightbend](http://lightbend.com), we're building an open source-based platform for streaming ("fast") data. To find out more, go to [lightbend.com/fast-data-platform](http://lightbend.com/fast-data-platform) or ask me about it.

> **Tips:**
> 1. If you're taking this tutorial at a conference, it's **essential** that you set up the tutorial ahead of time, as there won't be time during the session to work on any problems.
> 2. Use the [Gitter chat room](https://gitter.im/deanwampler/JustEnoughScalaForSpark) to ask for help or post issues to the [GitHub repo](https://github.com/deanwampler/JustEnoughScalaForSpark/issues) if you have trouble installing or running the tutorial.
> 3. If all else fails, there is a PDF of the tutorial in the `notebooks` directory.

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
* [Databricks](https://databricks.com/)
* [IBM Data Science Experience](http://datascience.ibm.com/)

You will need to install and run the Spark Notebook runtime. You can do this either by downloading it and running it "natively" on your computer, or by running it in [Docker](https://docker.com). _Windows users must use Docker._

We'll use Scala Notebook version 0.7.0, built for Spark 2.1.0, Hadoop 2.7.2, and Scala 2.11.8, with Hive and Parquet extensions. (See [spark-notebook.io](http://spark-notebook.io) for other configurations.) The Scala concepts we'll learn apply equally to Spark versions from 1.6.X through 2.X, as well as Scala versions 2.10.X through 2.12.X.

Here's how to get started:

### To Docker or Not to Docker?

Windows users must use Docker, discussed in the [Docker Installation](#docker-installation) section shortly. We've encountered too many issues running Spark Notebook "natively" on Windows. Linux and Mac OSX users can install using Docker or natively.

> While the native installation may work with a "UNIX-on-Windows" option like Cygwin or the optional Ubuntu subsystem for Windows 10, this has not been tested.

### Native Installation

First install the Java Development Kit (JDK), then install the notebook environment.

#### Install Java 7 or 8

You'll need the Java 7 or 8 JDK (Java Development Kit) installed (Java 8 is recommended, preview releases of Java 9 are not supported). You probably already have it installed, but if not, go [here](https://java.com/en/download/help/index_installing.xml) for instructions.

> Not sure if you have Java installed? Open a command/terminal window and type `java -version`. If you get `command not found`, well...

Although this is a tutorial on using Scala, a separate Scala installation is _not_ required. It's bundled with Spark Notebook. However, if you want to download Scala, look at the "Scaladocs", etc., go to [scala-lang.org](http://scala-lang.org/).

#### Install Spark Notebook

To install Spark Notebook natively, visit one of the following download pages and click the link labeled _Download here_:

* [Zip](http://spark-notebook.io/dl/zip/0.7.0/2.11/2.1.0/2.7.2/true/true) file
* [Tgz](http://spark-notebook.io/dl/tgz/0.7.0/2.11/2.1.0/2.7.2/true/true) file

Expand the archive somewhere convenient.

> **Tip:** It's recommended to use a directory path that contains no spaces. For example, `/foo bar/baz` has one space.

#### Verify It's Working

To verify it's working, start Spark Notebook as follows.

Open a terminal/command window and change the working directory to the root directory where you expanded the Spark Notebook archive.

Run the following command:
```
bin/spark-notebook
```

You'll see some log messages in the terminal output that end like this:

```
[info] play - Listening for HTTP on /0:0:0:0:0:0:0:0:9001
```

It might show another port, but 9001 is the current default used by Spark Notebook. Open your browser to [localhost:9001](http://localhost:9001/) or the other port shown, if different. The UI has a **SPARK NOTEBOOK** banner and shows several directories and notebooks for sample applications that come with the application.

> **Troubleshooting:** If you get an error that it fails to start, make sure Java 7 or 8 is installed and on your command `PATH`. (Run `java -version` in the same terminal.) If Java isn't an issue, try moving the Spark Notebook folder to a directory where the full path has **no** whitespace.

If it still doesn't work, see [Getting Help](#getting-help).

Now jump to <a href="#running-tutorial">Running the Tutorial</a>.

<a name="docker-installation"></a>
#### Docker Installation

This the approach required for Windows users, as discussed above. It's also suitable for MacOS and Linux users.

First install Docker, if necessary. Follow the installation instructions at [docker.com](https://www.docker.com/products/overview) (the _community edition_ is sufficient).

Next, open a terminal window and run these two commands to download and run the Spark Notebook environment as a Docker image.

```
docker pull andypetrella/spark-notebook:0.7.0-scala-2.11.8-spark-2.1.0-hadoop-2.7.2-with-hive
docker run -p 9001:9001 andypetrella/spark-notebook:0.7.0-scala-2.11.8-spark-2.1.0-hadoop-2.7.2-with-hive
```

The `-p 9001:9001` argument tells Docker to "tunnel" port 9001 out of the container to your local environment, so you can get to the Spark Notebook UI. You should see the following line at the end of the terminal output:

```
[info] play - Listening for HTTP on /0:0:0:0:0:0:0:0:9001
```

It might show another port, but 9001 is the current default used by Spark Notebook. _If_ you see 9001 shown, then open your browser to [localhost:9001](http://localhost:9001/).

However, if a different port is shown, use control-c to kill the running container and rerun the `docker run` command, replacing both instances of 9001 with the actual port number that was printed to the terminal. Now open http://localhost:<port_number> in a browser.

The UI has a **SPARK NOTEBOOK** banner and shows several directories and notebooks for sample applications that come with the application.

> **NOTE:** When you quit the Docker container at the end of the tutorial, all your changes will be lost. To save them, export the notebook using the _File_ menu that's on the upper left-hand side of each browser page.

<a name="running-tutorial"></a>
## Running the Tutorial

Now we need to load the tutorial into Spark Notebook.

Under the banner and under the tabs ("Files", "Running", ...), the first line of text says "To import a notebook, drag the file onto the listing below or *click here.*"

The *click here* is a link. Click it, then navigate to where you downloaded the tutorial GitHub repository. Find and select `notebooks/JustEnoughScalaForSpark.snb`.

A new line in the UI is added with "JustEnoughScalaForSpark.snb" and an "Upload" button on the right-hand side, as shown in Figure 1:

![Step 1](images/step1.jpg)
<center><b>Figure 1:</b> Before Uploading the Notebook</center>

I've highlighted the "click here" link that you used and the new line that was added for the tutorial notebook.

Click the "Upload" button.

Now the line is moved towards the _bottom_ of the page and the buttons on the right-hand side are different.

![Step 2](images/step2.jpg)
<center><b>Figure 2:</b> After Uploading the Notebook</center>

Click the [JustEnoughScalaForSpark link](http://localhost:9001/notebooks/JustEnoughScalaForSpark.snb) on the left-hand side and the tutorial notebook will open in another browser tab. (It might take a minute to load completely.) The top of the page should look like this:

![Step 3](images/step3.jpg)
<center><b>Figure 3:</b> After Starting the Notebook</center>

> **Troubleshooting:**

> 1. If the new tab fails to open or the notebook fails to load as shown, check the terminal window where you started Spark Notebook. Are there any error messages?
> 2. An alternative is to copy the `JustEnoughScalaForSpark.snb` notebook into the `notebooks` directory of the Spark Notebook distribution. If you aren't using Docker, use any file copy method you like, if you are using Docker, use the command `docker ps` to find the id of the running image (a 12-digit hex number), then use the command `docker cp /path/to/JustEnoughScalaForSpark.snb NNNN:/opt/docker/notebooks`, where you should replace `NNNN` with your actual id.

Finally, you'll notice there is a green box around the first "cell". This cell has one line of source code `println("Hello World!")`. Above this cell is a toolbar with a right-pointing, solid black triangle. Click that button to run this code cell. Or, use the menu item _Cell > Run_.

The output you see in the image above, `Hello World!`, will be erased and a moment later it should reappear. (This can take up to a minute because Spark Notebook will download library dependencies behind the scenes.)

If that worked, you're done setting up the tutorial!

If it didn't work, here are some additional troubleshooting tips:

> **More Troubleshooting:**
> If the notebook cell output shows an error that `globalScope is undefined` or similar, this usually means it failed to download all the dependencies _or_ you are trying to run Spark Notebook natively on Windows and you hit a known bug.
> If you see a message "Kernel starting please wait", that never goes away, trying running the notebook in read-only mode. Close the tab, then on the first browser tab where you uploaded the notebook, click the orange _Shutdown_ button, if the notebook is still running, then click the orange _View (read-only)_ button.
> Other problems might result in different errors. Use the following steps to diagnose the problem.
> 1. In your browser, open the _developer tools_ and look at the JavaScript or Web console output. It may show an error emitted by the Scala or JavaScript compilers.
>   * If there is an error about an invalid backslash (`\`) in a string, you are on Windows and you must run in Docker.
>   * If there is an error that it couldn't download dependencies, make sure you are connected to the Internet and make sure that any network security software on your computer isn't blocking Internet traffic for downloading "maven" dependencies and JavaScript libraries.
> 2. Look for error messages in the terminal window.
> 3. Look for error messages in the Spark Notebook log files. Under the Spark Notebook's root directory is a `logs` directory.

<a name="getting-help"></a>
## Getting Help

If all else fails, use the [Gitter chat room](https://gitter.im/deanwampler/JustEnoughScalaForSpark) to ask for help. If you're reasonably certain you've found a bug, post an issue to the [GitHub repo](https://github.com/deanwampler/JustEnoughScalaForSpark/issues). Recall that the `notebooks` directory also has a PDF of the notebook that you can read when the notebook won't work.

## What's Next?

You are now ready to go through the tutorial.

Don't want to run Spark Notebook to learn the material? A PDF printout of the notebook can also be found in the `notebooks` directory.

Please post any feedback, bugs, or even pull requests to the [project's GitHub page](https://github.com/deanwampler/JustEnoughScalaForSpark). Thanks.

[Dean Wampler](mailto:deanwampler@gmail.com), May 2017
