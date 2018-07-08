# Just Enough Scala for Spark

[![Join the chat at https://gitter.im/deanwampler/JustEnoughScalaForSpark](https://badges.gitter.im/deanwampler/JustEnoughScalaForSpark.svg)](https://gitter.im/deanwampler/JustEnoughScalaForSpark?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

* Spark Summit San Francisco, June 5, 2017
* Strata London, May 23, 2017
* Strata San Jose, March 14, 2017
* Strata Singapore, December 6, 2016
* Strata NYC, September 27, 2016

[Dean Wampler, Ph.D.](mailto:deanwampler@gmail.com) and [Chaoran Yu](https://github.com/yuchaoran2011)<br/>
[Lightbend, Inc.](http://lightbend.com)

> **NEW:** This tutorial now uses a Docker image with Jupyter and Spark, for a much more robust, easy to use, and "industry standard" experience. There is also an option to use a BeakerX image (http://beakerx.com).

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

## Quick Start for the Impatient

Step #3 assumes that Docker is installed.

1. Open a terminal or command window
2. Change to the directory where you expanded the tutorial project or cloned the repo, e.g., `JustEnoughScalaForSpark`
3. Run the notebook environment Docker image: `run.sh` (MacOS and Linux) or `run.bat` (Windows)
4. Open the URL printed
5. In the web page, click `JustEnoughScalaForSpark`
6. Click `notebooks`
7. Click `JustEnoughScalaForSpark.ipynb`
8. Profit!!

The rest of this README provides more details.

## About Jupyter with Spark and BeakerX

This tutorial uses a [Docker](https://docker.com) image that combines the popular [Jupyter](http://jupyter.org/) notebook environment with all the tools you need to run Spark, including the Scala language, called the [All Spark Notebook](https://hub.docker.com/r/jupyter/all-spark-notebook/). It bundles [Apache Toree](https://toree.apache.org/) to provide Spark and Scala access. The [webpage](https://hub.docker.com/r/jupyter/all-spark-notebook/) for this Docker image discusses useful information like using Python as well as Scala, user authentication topics, running your Spark jobs on clusters, rather than local mode, etc.

As an alternative, you can also use [BeakerX](http://beakerx.com), which is also based on Jupyter and includes a number of useful tools for using different programming languages, plotting data, etc.

### Beaker Configuration

> **WARNING:** If you use BeakerX, you have to do one of two additional configuration steps.

First option: After starting BeakerX as described below, click the _BeakerX_ tab in the home page and set the JVM heap space to 0.5 GB or greater, before opening the tutorial notebook.

Second option: Set your laptop's Docker environment to have at least 2.5GB of memory. For Macs, the default setting is 2GB and for Windows it may be 1GB. Find the _Preferences_ in your Docker environment and set the memory to 2.5GB.

### Other Notebook Environments

There are other notebook options you might investigate for your needs:

**Open source:**

* [Zeppelin](http://zeppelin-project.org/) - a popular tool in big data environments
* [Spark Notebook](http://spark-notebook.io) - a powerful tool, but not as polished or well maintained

**Commercial:**

* [Databricks](https://databricks.com/) - a feature-rich, commercial, cloud-based service
* [IBM Data Science Experience](http://datascience.ibm.com/) - IBM's full-featured environment for data science

## Running the Tutorial

If you need to install Docker, follow the installation instructions at [docker.com](https://www.docker.com/products/overview) (the _community edition_ is sufficient).

Now we'll run the docker image. It's important to follow the next steps carefully. We're going to mount the working directory in the running container so it's accessible inside the running container. We'll need it for our notebook, our data, etc.

1. Open a terminal or command window
2. Change to the directory where you expanded the tutorial project or cloned the repo, e.g., `JustEnoughScalaForSpark`.
   a. **You must be in this directory for the commands to work correctly.**
3. Run the notebook environment Docker image using the following script: `run.sh` (MacOS and Linux) or `run.bat` (Windows)
   a. If you want to try BeakerX, use `run.sh --beakerx` (MacOS and Linux) or `run_beakerx.bat` (Windows)

> **Note:** The bash `run.sh` script has a `--help` option that explains all the options.

The MacOS and Linux `run.sh` script executes a command very similar to the following (wrapped for easier reading):

```bash
docker run -it --rm -p 8888:8888 -p 4040:4040 --cpus=2.0 --memory=2000M \
  -v "$PWD":/home/jovyan/JustEnoughScalaForSpark jupyter/all-spark-notebook
```

The Windows `run.bat` command is similar, but uses Windows conventions. If you use BeakerX, `/home/beakerx` is used for the directory and `beakerx/beakerx` is used for the Docker image.

The `--cpus=... --memory=...` arguments were added because the notebook "kernel" is prone to crashing with the default values. Edit to taste. Also, it will help to shut down notebooks after you've finished with them.

The `-v $PWD:/home/jovyan/JustEnoughScalaForSpark` tells Docker to mount the current working directory inside the container as `/home/jovyan/JustEnoughScalaForSpark`, where `/home/jovyan` is the "home" directory for the environment inside the running container. (The home directory for BeakerX is `/home/beakerx`.)

**Mounting the directory is essential to provide access to the tutorial data and notebooks.** When you open the notebook UI (discussed shortly), you'll see this directory listed.

> **Note:** On Windows, you may get the following error: _C:\Program Files\Docker\Docker\Resources\bin\docker.exe: Error response from daemon: D: drive is not shared. Please share it in Docker for Windows Settings."_ If so, do the following. On your tray, next to your clock, right-click on Docker, then click on Settings. You'll see the _Shared Drives_. Mark your drive and hit apply. See [this Docker forum thread](https://forums.docker.com/t/cannot-share-drive-in-windows-10/28798/5) for more tips.

The `-p 8888:8888 -p 4040:4040` arguments tells Docker to "tunnel" ports 8888 and 4040 out of the container to your local environment, so you can get to the Jupyter UI at port 8888 and the Spark driver UI at 4040, respectively.

> **Note:** Here we use just one notebook, but if we used several notebooks concurrently, the _second_ notebook's Spark instance would use port 4041, the third would use 4042, etc.. Keep this in mind if you adapt this project for your own needs.

You should see output like the following for Jupyter and similar output for BeakerX:

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

> **Tips:**
>
> 1. In some terminal apps, like _iTerm_ on the Mac, you can open the URL by clicking it while holding the command key.
> 2. If using BeakerX, for some reason the Docker container id, e.g., `7572a7b3b3ca` is shown instead of `localhost`. Use `localhost` when opening the web page.

> **Warning:** When you quit the Docker container at the end of the tutorial, all your changes will be lost, unless they are in the `JustEnoughScalaForSpark` directory that we mounted. Export notebooks in other locations using _File > Download as > Notebook_ in the toolbar.

## Working through the Tutorial

Now we can load the tutorial. Once you open the URL, you'll see the `JustEnoughScalaForSpark` listed. Click once to open it, then open `notebooks`, then click one of the tutorial notebooks:

* `JustEnoughScalaForSpark.ipynb` if using Jupyter
* `JustEnoughScalaForSpark-BeakerX.ipynb` if using BeakerX

It will open in a new tab. (The reason a separate BeakerX notebook is required is because we have to start Spark explicitly in BeakerX notebooks, while it's started for us automatically in the Jupyter Docker image.)

> **Tip:** The `notebooks` directory also contains [PDF](notebooks/JustEnoughScalaForSpark.pdf) and [HTML](notebooks/JustEnoughScalaForSpark.html) print outs of the notebook, in case you have trouble running the notebook itself.

You'll notice there is a box around the first "cell". This cell has one line of source code `println("Hello World!")`. Above this cell is a toolbar with a button that has a right-pointing arrow and the word _run_. Click that button to run this code cell. Or, use the menu item _Cell > Run Cells_.

After many seconds, once initialization has completed, it will print the output, `Hello World!` just below the input text field.

This is how you'll run the code cells throughout the tutorial.

Do the same thing for the next box. It should print `[merrywivesofwindsor, twelfthnight, midsummersnightsdream, loveslabourslost, asyoulikeit, comedyoferrors, muchadoaboutnothing, tamingoftheshrew]`, the contents of the `./JustEnoughScalaForSpark/data/shakespeare` folder, the texts for several of Shakespeare's plays. We'll use these files as data.

> **Warning:** If instead you see `[]` or `null` printed, mounting the project directory did not work correctly when the container was started. In the terminal window, hit `control-c` twice to exit from the Docker container. Make sure you are in the root directory of the project, where `data` and `notebooks` should be subdirectories. If not, change to that directory, then restart the environment, open the notebook as before, and try evaluating this cell again.

If these steps worked, you're done setting up the tutorial!

<a name="getting-help"></a>
## Getting Help

If you're having problems, use the [Gitter chat room](https://gitter.im/deanwampler/JustEnoughScalaForSpark) to ask for help. If you're reasonably certain you've found a bug, post an issue to the [GitHub repo](https://github.com/deanwampler/JustEnoughScalaForSpark/issues). Recall that the `notebooks` directory also has PDF and HTML listings of the notebook that you can read when the notebook environment won't work.

## What's Next?

You are now ready to go through the tutorial.

Please post any feedback, bugs, or even pull requests to the [project's GitHub page](https://github.com/deanwampler/JustEnoughScalaForSpark). Thanks.

Dean Wampler
