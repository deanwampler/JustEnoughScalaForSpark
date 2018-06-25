# Just Enough Scala for Spark

[![Join the chat at https://gitter.im/deanwampler/JustEnoughScalaForSpark](https://badges.gitter.im/deanwampler/JustEnoughScalaForSpark.svg)](https://gitter.im/deanwampler/JustEnoughScalaForSpark?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

* Spark Summit San Francisco, June 5, 2017
* Strata London, May 23, 2017
* Strata San Jose, March 14, 2017
* Strata Singapore, December 6, 2016
* Strata NYC, September 27, 2016

[Dean Wampler, Ph.D.](mailto:deanwampler@gmail.com) and [Chaoran Yu](https://github.com/yuchaoran2011)<br/>
[Lightbend, Inc.](http://lightbend.com)

> **NEW:** This tutorial now uses a Docker image with Jupyter and Spark, for a much more robust, easy to use, and "industry standard" experience.

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

This tutorial uses a [Docker](https://docker.com) image that combines the popular [Jupyter](http://jupyter.org/) notebook environment with all the tools you need to run Spark, including the Scala language, called the [All Spark Notebook](https://hub.docker.com/r/jupyter/all-spark-notebook/). It bundles [Apache Toree](https://toree.apache.org/) to provide Spark and Scala access. The [webpage](https://hub.docker.com/r/jupyter/all-spark-notebook/) for this Docker image discusses useful information like using Python as well as Scala, user authentication topics, running your Spark jobs on clusters, rather than local mode, etc.

There are other notebook options you might investigate for your needs:

**Open source:**

* [Jupyter](https://ipython.org/) + [BeakerX](http://beakerx.com/) - a powerful set of extensions for Jupyter
* [Zeppelin](http://zeppelin-project.org/) - a popular tool in big data environments
* [Spark Notebook](http://spark-notebook.io) - a powerful tool, but not as polished or well maintained

**Commercial:**

* [Databricks](https://databricks.com/) - a feature-rich, commercial, cloud-based service
* [IBM Data Science Experience](http://datascience.ibm.com/) - IBM's full-featured environment for data science

## Running the Tutorial

If you need to install Docker, follow the installation instructions at [docker.com](https://www.docker.com/products/overview) (the _community edition_ is sufficient).

Now we'll run the docker image. It's important to follow the next steps carefully. We're going to mount the working directory in the running container so it's accessible inside the running container. We'll need it for our notebook, our data, etc.

* Open a terminal or command window
* Change to the directory where you expanded the tutorial project or cloned the repo
* To download and run the Docker image, run the following command: `run.sh` (MacOS and Linux) or `run.bat` (Windows)

The MacOS and Linux `run.sh` command executes this command:

```bash
docker run -it --rm \
  -p 8888:8888 -p 4040:4040 \
  --cpus=2.0 --memory=2000M \
  -v "$PWD":/home/jovyan/work \
  "$@" \
  jupyter/all-spark-notebook
```

The Windows `run.bat` command is similar, but uses Windows conventions.

The `--cpus=... --memory=...` arguments were added because the notebook "kernel" is prone to crashing with the default values. Edit to taste. Also, it will help to keep only one notebook (other than the Introduction) open at a time.

The `-v $PWD:/home/jovyan/work` tells Docker to mount the current working directory inside the container as `/home/jovyan/work`. _This is essential to provide access to the tutorial data and notebooks_. When you open the notebook UI (discussed shortly), you'll see this folder listed.

> **Note:** On Windows, you may get the following error: _C:\Program Files\Docker\Docker\Resources\bin\docker.exe: Error response from daemon: D: drive is not shared. Please share it in Docker for Windows Settings."_ If so, do the following. On your tray, next to your clock, right-click on Docker, then click on Settings. You'll see the _Shared Drives_. Mark your drive and hit apply. See [this Docker forum thread](https://forums.docker.com/t/cannot-share-drive-in-windows-10/28798/5) for more tips.

The `-p 8888:8888 -p 4040:4040` arguments tells Docker to "tunnel" ports 8888 and 4040 out of the container to your local environment, so you can get to the Jupyter UI at port 8888 and the Spark driver UI at 4040.

> **Note:** Here we use just one notebook, but if we used several notebooks concurrently, the _second_ notebook's Spark instance would use port 4041, the third would use 4042, etc.. Keep this in mind if you adapt this project for your own needs.

You should see output similar to the following:

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

> **Tip:** If you're using _iTerm_ on a Mac, just click the URL while holding the command key.

> **Warning:** When you quit the Docker container at the end of the tutorial, all your changes will be lost, unless they are in or under the current working directory that we mounted! To save notebooks you defined in other locations, export them using the _File > Download as > Notebook_ menu item in toolbar.

## Running the Tutorial

Now we can load the tutorial. Once you open the Jupyter UI, you'll see the `work` listed. Click once to open it, then open `notebooks`, then click on the tutorial notebook, `JustEnoughScalaForSpark.ipynb`. It will open in a new tab. (The PDF is a print out of the notebook, in case you have trouble running the notebook itself.)

You'll notice there is a box around the first "cell". This cell has one line of source code `println("Hello World!")`. Above this cell is a toolbar with a button that has a right-pointing arrow and the word _run_. Click that button to run this code cell. Or, use the menu item _Cell > Run Cells_.

After many seconds, once initialization has completed, it will print the output, `Hello World!` just below the input text field.

Do the same thing for the next box. It should print `[merrywivesofwindsor, twelfthnight, midsummersnightsdream, loveslabourslost, asyoulikeit, comedyoferrors, muchadoaboutnothing, tamingoftheshrew]`, the contents of the `/home/jovyan/work/data/shakespeare` folder, the texts for several of Shakespeare's plays. We'll use these files as data.

> **Warning:** If instead you see `[]` or `null` printed, the mounting of the current working directory did not work correctly when the container was started. In the terminal window, use `control-c` to exit from the Docker container, make sure you are in the root directory of the project (`data` and `notebooks` should be subdirectories), restart the docker image, and make sure you enter the command exactly as shown.

If these steps worked, you're done setting up the tutorial!

<a name="getting-help"></a>
## Getting Help

If you're having problems, use the [Gitter chat room](https://gitter.im/deanwampler/JustEnoughScalaForSpark) to ask for help. If you're reasonably certain you've found a bug, post an issue to the [GitHub repo](https://github.com/deanwampler/JustEnoughScalaForSpark/issues). Recall that the `notebooks` directory also has a PDF of the notebook that you can read when the notebook won't work.

## What's Next?

You are now ready to go through the tutorial.

Don't want to run Spark Notebook to learn the material? A PDF printout of the notebook can also be found in the `notebooks` directory.

Please post any feedback, bugs, or even pull requests to the [project's GitHub page](https://github.com/deanwampler/JustEnoughScalaForSpark). Thanks.

Dean Wampler
