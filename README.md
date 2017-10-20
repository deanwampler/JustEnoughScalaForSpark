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

Check out [Lightbend Fast Data Platform](http://lightbend.com/fast-data-platform), our new distribution for _Fast Data_ (stream processing), including Spark, Flink, Kafka, Akka Streams, Kafka Streams, HDFS, and our production management and monitoring tools, running on Mesosphere DC/OS.

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

## About Jupyter with Spark

This tutorial uses a [Docker](https://docker.com) image that combines the popular [Jupyter](http://jupyter.org/) notebook environment with all the tools you need to run Spark, including the Scala language, called the [All Spark Notebook](https://hub.docker.com/r/jupyter/all-spark-notebook/).

There are other notebook tools you might investigate for your team's needs:

* [IBM Data Science Experience](http://datascience.ibm.com/)
* [iPython/Jupyter](https://ipython.org/) + [Apache Toree](https://toree.apache.org/) - an alternative to our Jupyter configuration
* [Zeppelin](http://zeppelin-project.org/)
* [Beaker](http://beakernotebook.com/)
* [Databricks](https://databricks.com/)
* [Spark Notebook](http://spark-notebook.io)

## Running the Tutorial

If you need to install Docker, follow the installation instructions at [docker.com](https://www.docker.com/products/overview) (the _community edition_ is sufficient).

Next, open a terminal window and run this command to download and run the image:

```bash
docker run -it --rm -p 8888:8888 jupyter/all-spark-notebook
```

The `-p 8888:8888` argument tells Docker to "tunnel" port 8888 out of the container to your local environment, so you can get to the Jupyter UI. You should see output similar to the following:

```bash
Unable to find image 'jupyter/all-spark-notebook:latest' locally
latest: Pulling from jupyter/all-spark-notebook
e0a742c2abfd: Pull complete
...
ed25ef62a9dd: Pull complete
Digest: sha256:...
Status: Downloaded newer image for jupyter/all-spark-notebook:latest
Execute the command: jupyter notebook
...
[I 19:08:15.017 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[C 19:08:15.019 NotebookApp]

    Copy/paste this URL into your browser when you connect for the first time,
    to login with a token:
        http://localhost:8888/?token=...
```

Now copy and paste the URL shown in a browser window.

> **Warning:** When you quit the Docker container at the end of the tutorial, all your changes will be lost! To save them, export the notebook using the _File_ menu that's on the upper left-hand side of each browser page.

## Running the Tutorial

Now we need to load the tutorial into Jupyter.

* Click the _Upload_ button on the upper right-hand side of the UI.
* Browse to where you downloaded and expanded the tutorial, then to the `notebooks` directory. \
* Open `JustEnoughScalaForSpark`.
* Click the blue _Upload_ button.
* Click the link for the tutorial that is now shown in the list of notebooks.

It opens in a new browser tab. It will take several seconds to load. (It's big!)

>  **Tip:** If the new tab fails to open or the notebook fails to load as shown, check the terminal window where you started Jupyter. Are there any error messages?

Finally, you'll notice there is a box around the first "cell". This cell has one line of source code `println("Hello World!")`. Above this cell is a toolbar with a button that has a right-pointing arrow and the word _run_. Click that button to run this code cell. Or, use the menu item _Cell > Run Cells_.

It will print the output, `Hello World!` just below the input text field.

If that worked, you're done setting up the tutorial!

<a name="getting-help"></a>
## Getting Help

If you're having problems, use the [Gitter chat room](https://gitter.im/deanwampler/JustEnoughScalaForSpark) to ask for help. If you're reasonably certain you've found a bug, post an issue to the [GitHub repo](https://github.com/deanwampler/JustEnoughScalaForSpark/issues). Recall that the `notebooks` directory also has a PDF of the notebook that you can read when the notebook won't work.

## What's Next?

You are now ready to go through the tutorial.

Don't want to run Spark Notebook to learn the material? A PDF printout of the notebook can also be found in the `notebooks` directory.

Please post any feedback, bugs, or even pull requests to the [project's GitHub page](https://github.com/deanwampler/JustEnoughScalaForSpark). Thanks.

Dean Wampler
