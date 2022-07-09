# Just Enough Scala for Spark

[![Join the chat at https://gitter.im/deanwampler/JustEnoughScalaForSpark](https://badges.gitter.im/deanwampler/JustEnoughScalaForSpark.svg)](https://gitter.im/deanwampler/JustEnoughScalaForSpark?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

* Added instructions for using Podman, fixed image version, Spark 3.2.1, July, 2022
* Minor updates and bug fixes, April, 2021
* Spark Summit San Francisco, June 5, 2017
* Strata London, May 23, 2017
* Strata San Jose, March 14, 2017
* Strata Singapore, December 6, 2016
* Strata NYC, September 27, 2016

[Dean Wampler, Ph.D.](mailto:deanwampler@gmail.com)<br/>
[Chaoran Yu](https://github.com/yuchaoran2011) taught this tutorial at a few conferences, too.

> **NOTE:** It appears the `jupyter/all-spark-notebook` images are no longer built with Scala support, as of July 2022. These instructions use the last image released with Scala support, also supporting Spark 3.2.1.

François Sarradin (@fsarradin) and colleagues translated this tutorial to French. You can find it [here](https://github.com/univalence/CeQuilFautDeScalaPourSpark).

This tutorial now uses a Docker image with Jupyter and Spark, for a much more robust, easy to use, and "industry standard" experience.

This tutorial covers the most important features and idioms of [Scala](http://scala-lang.org/) you need to use [Apache Spark's](http://spark.apache.org/) Scala APIs. Because Spark is written in Scala, Spark is driving interest in Scala, especially for _data engineers_. _Data scientists_ sometimes use Scala, but most use Python or R.

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

* [Polynote](https://polynote.org/) - A cross-language notebook environment with built-in Scala support. Developed by Netflix.
* [Jupyter](https://ipython.org/) + [BeakerX](http://beakerx.com/) - a powerful set of extensions for Jupyter.
* [Zeppelin](http://zeppelin-project.org/) - a popular tool in big data environments

**Commercial:**

* [Databricks](https://databricks.com/) - a feature-rich, commercial, cloud-based service from the creators of Spark

## Running the Tutorial

If you need to install Docker _or_ the popular replacement, [Podman](https://podman.io/).

### Using Docker

Follow the [Docker installation instructions](https://www.docker.com/products/overview). The _community edition_ is sufficient. Then start the docker daemon on your machine, as instructed.

### Using Podman

Follow the [Podman installation instructions](https://podman.io/getting-started/installation).

> **NOTE:** I don't have access to a Windows machine so I have not tested using Podman on Windows with this tutorial. _Caveat emptor_.

A few other steps are recommended or required.

First, it's convenient to alias the `docker` commands to corresponding `podman` commands:

```shell
alias docker=podman
alias docker-compose=podman-compose
```

If you choose not to do this, just substitute `podman` for `docker` in the commands, shell scripts, and bat scripts discussed below.

Also, you'll need to initialize a Podman virtual machine. First, see if the default machine was already created by the installer. If so, we'll replace it with a "beefier" one.

```shell
podman system connection list     # List the VMs defined
```

Do you see the following output?

```
Name                         URI                                                         Identity                                        Default
podman-machine-default       ssh://core@localhost:53933/run/user/501/podman/podman.sock  /Users/.../.ssh/podman-machine-default  true
podman-machine-default-root  ssh://root@localhost:53933/run/podman/podman.sock           /Users/.../.ssh/podman-machine-default  false
```

In this case, run this `rm` command to delete it:

```shell
podman machine rm podman-machine-default
```

Now use the following commands to create the `podman-machine-default` with more resources and then start it running:

```shell
podman machine init --memory=4000 --cpus=4 -v $HOME:$HOME
podman machine start
```

> **Tip:** Run `podman machine stop` when you are finished with the tutorial.

On my MacOS machine, I had trouble saving changes to notebooks due to permissions issues. When you start the machine, you might see the following output:

```
$ podman machine start
Starting machine "podman-machine-default"
Waiting for VM ...
Mounting volume... /Users/...:/Users/...

This machine is currently configured in rootless mode. If your containers
require root permissions (e.g. ports < 1024), or if you run into compatibility
issues with non-podman clients, you can switch using the following command:

    podman machine set --rootful

API forwarding listening on: /Users/.../.local/share/containers/podman/machine/podman-machine-default/podman.sock

The system helper service is not installed; the default Docker API socket
address can't be used by podman. If you would like to install it run the
following commands:

    sudo /opt/homebrew/Cellar/podman/4.1.1/bin/podman-mac-helper install
    podman machine stop; podman machine start

You can still connect Docker API clients by setting DOCKER_HOST using the
following command in your terminal session:

    export DOCKER_HOST='unix:///Users/.../.local/share/containers/podman/machine/podman-machine-default/podman.sock'

Machine "podman-machine-default" started successfully
```

Following these instructions fixed the issue. More concisely, run these commands:

```shell
podman machine stop
podman machine set --rootful
sudo /opt/homebrew/Cellar/podman/4.1.1/bin/podman-mac-helper install
podman machine start
```

Setting `DOCKER_HOST` is done for you in the `run.sh` script discussed next.

## Running the Docker Image

Use these steps for both `docker` and `podman`.

It's important to follow the next steps carefully. We're going to mount the working directory in the running container so it's accessible inside the running container in a convenient place. We'll need it for our notebook, our data, etc.

* In the same terminal window, change to the directory where you expanded the tutorial project or cloned the repo.
* Run the following command to download and run the Docker image: 
    * `run.sh` (MacOS and Linux)
    * `run.bat` (Windows)

The MacOS and Linux `run.sh` command executes these commands:

```shell
which -s podman > /dev/null && \
  export DOCKER_HOST="unix:///$HOME/.local/share/containers/podman/machine/podman-machine-default/podman.sock"
docker run -it --rm \
  -p 8888:8888 -p 4040:4040 \
  --cpus=3.0 --memory=3500M \
  -v "$PWD":/home/jovyan/work \
  "$@" \
  jupyter/all-spark-notebook:spark-3.2.0
```

The first command (note the line continuation...) checks if you are using podman and sets the `DOCKER_HOST` environment variable, which I found to be necessary. You might try just running the `docker run` command to see if you really need this.

The Windows `run.bat` command is similar, but uses Windows conventions and does _not_ attempt to set `DOCKER_HOST`.

The `--cpus=... --memory=...` arguments were added because the notebook "kernel" is prone to crashing with the default values. Edit to taste to see what works best for you. For example, previously this `README` used `--cpus=2.0 --memory=2000M`, but machines are bigger now :) Also, it will help conserve resources to keep only one notebook open at a time, other than the _Introduction_, which is lightweight.

The `-v $PWD:/home/jovyan/work` tells Docker to mount the current working directory inside the container as `/home/jovyan/work`. When you open the notebook UI (discussed shortly), you'll see this folder listed.

Finally, we are using the image tagged `spark-3.2.0`, which actually supports Spark 3.2.1. Unfortunately, the `jupyter/all-spark-notebook` image builds dropped Spark support in July 2022.  :(

> **Notes:**
>
> 1. On Windows, when using Docker, you may get the following error: _C:\Program Files\Docker\Docker\Resources\bin\docker.exe: Error response from daemon: D: drive is not shared. Please share it in Docker for Windows Settings."_ If so, do the following. On your tray, next to your clock, right-click on Docker, then click on Settings. You'll see the _Shared Drives_. Mark your drive and hit apply. See [this Docker forum thread](https://forums.docker.com/t/cannot-share-drive-in-windows-10/28798/5) for more tips.
> 2. I don't have access to a Windows machine so I have not tested using Podman on Windows.
s
The `-p 8888:8888 -p 4040:4040` arguments tells Docker to "tunnel" ports 8888 and 4040 out of the container to your local environment, so you can get to the Jupyter UI at port 8888 and the Spark driver UI at 4040.

> **Note:** Here we use just one notebook, but if we used several notebooks concurrently, the _second_ notebook's Spark instance would use port 4041, the third would use 4042, etc.. Keep this in mind if you adapt this project for your own needs.

You should see output similar to the following:

```shell
Unable to find image 'jupyter/all-spark-notebook:spark-3.2.0' locally
latest: Pulling from jupyter/all-spark-notebook
...
    Copy/paste this URL into your browser when you connect for the first time,
    to login with a token:
        http://localhost:8888/?token=...
```

Now copy and paste the `localhost:8888` URL shown in a browser window.

> **Tip:** Your terminal might let you ⌘-click or CTRL-click the URL to open it in a browser.

> **Warning:** When you quit the container at the end of the tutorial, all your changes will be lost, unless they are in or under the current working directory that we mounted. To save notebooks you defined in other locations, export them using the _File > Download as > Notebook_ menu item in toolbar.

## Running the Tutorial

> **Warning:** It appears that the Jupyter _magics_ in the notebook no longer work. I have added comments and workarounds.

Now we can load the tutorial. Once you open the Jupyter UI, you'll see the `work` listed. Click once to open it, then open `notebooks`, then click on the tutorial notebook, `JustEnoughScalaForSpark.ipynb`. It will open in a new tab. (The PDF is a print out of the notebook, in case you have trouble running the notebook itself.)

You'll notice there is a box around the first "cell". This cell has one line of source code `println("Hello World!")`. Above this cell is a toolbar with a button that has a right-pointing arrow and the word _run_. Click that button to run this code cell. Or, use the menu item _Cell > Run Cells_.

After many seconds, once initialization has completed, it will print the output, `Hello World!` just below the input text field.

Do the same thing for the next box. It should print `[merrywivesofwindsor, twelfthnight, midsummersnightsdream, loveslabourslost, asyoulikeit, comedyoferrors, muchadoaboutnothing, tamingoftheshrew]`, the contents of the `/home/jovyan/work/data/shakespeare` folder, the texts for several of Shakespeare's plays. We'll use these files as data.

> **Warning:** If you see `[]` or `null` printed instead, the mounting of the current working directory did not work correctly when the container was started. In the terminal window, use `control-c` to exit from the Docker container, make sure you are in the root directory of the project (`data` and `notebooks` should be subdirectories), restart the docker image, and make sure you enter the command exactly as shown.

If these steps worked, you're done setting up the tutorial!

<a name="getting-help"></a>
## Getting Help

If you're having problems, use the [Gitter chat room](https://gitter.im/deanwampler/JustEnoughScalaForSpark) to ask for help. If you're reasonably certain you've found a bug, post an issue to the [GitHub repo](https://github.com/deanwampler/JustEnoughScalaForSpark/issues). Recall that the `notebooks` directory also has a PDF of the notebook that you can read when the notebook won't work.

## What's Next?

You are now ready to go through the tutorial.

Don't want to run Spark Notebook to learn the material? A PDF printout of the notebook can also be found in the `notebooks` directory.

Please post any feedback, bugs, or even pull requests to the [project's GitHub page](https://github.com/deanwampler/JustEnoughScalaForSpark). Thanks.

Dean Wampler
