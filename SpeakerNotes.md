# Speaker Notes

[![Join the chat at https://gitter.im/deanwampler/JustEnoughScalaForSpark](https://badges.gitter.im/deanwampler/JustEnoughScalaForSpark.svg)](https://gitter.im/deanwampler/JustEnoughScalaForSpark?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[Dean Wampler, Ph.D.](mailto:deanwampler@gmail.com)<br/>
[Lightbend, Inc.](http://lightbend.com)

If you're brave enough to try teaching this tutorial yourself, these notes are for you.

Because this tutorial is Apache 2.0 licensed, it's free to use as you see fit, but I do ask that you credit the original GitHub project [github.com/deanwampler/JustEnoughScalaForSpark](https://github.com/deanwampler/JustEnoughScalaForSpark).

The first time you teach this tutorial, you might find it useful to print these notes for each reference.

## About the Tutorial

I've mostly taught this as a 1/2 day (~3 hour) tutorial. _There is way too much material for a half day, perhaps even for a full day._ Therefore, the content is designed to cover the "Scala 101" essentials, then offer "Scala 102" additions. I even organized the material into 101 and 102 major sections.

You won't finish the 101 material in a 1/2 day, especially if you give the class plenty of time to play with the code. That's okay. Also, feel free to skip or expand sections, as you see fit. I welcome feedback on what works and what doesn't work. I try to get to the section _Our Final Version: Supporting SQL Queries_, although not necessarily through the part about filtering for "stop" words.

The student will drink from a fire hose, but hopefully get the "gist" of the important points, then have the material to review later for better understanding.

I don't read the text cells (too boring!), but just summarize what they say. I tell the students that they shouldn't read everything either, but come back to the text later. I'll even skip some cells completely that provide details that aren't that important. Use your judgment.

There's a tension between a tutorial designed for live teaching and one designed for self-study. I've written the tutorial content for the latter case, which makes it accessible to more people, but the classroom experience can be a little overwhelming with all the text in front of you.

## Before Class

If you're in a time-boxed setting, like a 1/2 day conference tutorial, it's **essential** that the students setup the tutorial materials ahead of time. Here's an email that I've had conferences send to perspective students:

> Hello!
>
> Welcome to my tutorial, "Just Enough Scala for Spark." It's VERY important that you set up the tutorial material before our session. Unfortunately, with just half a day and a large crowd, I won't be able to help anyone with problems during the session.
>
> Please clone or download the following GitHub repo:
>
> https://github.com/deanwampler/JustEnoughScalaForSpark
>
> Then, follow the setup instructions in the README.md file (https://github.com/deanwampler/JustEnoughScalaForSpark/blob/master/README.md).
>
> If you have problems, post an issue to the GitHub repo (https://github.com/deanwampler/JustEnoughScalaForSpark/issues) or ask for help on the project's Gitter channel (https://gitter.im/deanwampler/JustEnoughScalaForSpark). I'll try to help.
>
> See you soon!
>
> Dean Wampler

Edit to taste...

## Getting Started

I begin with a show of hands:

* How many have some Scala experience?
* How many have some Spark experience, in any language?

The answer for a large group with a spectrum from beginner to expert. I teach to the least experienced student, but occasionally mention more advanced concepts to keep the more experienced person engaged. Hopefully the expert isn't too bored; at least he or she has exercises to play with.

## Getting the Tutorial to Work

I added the [Gitter channel](https://gitter.im/deanwampler/JustEnoughScalaForSpark?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge) to encourage people to ask for help in advance of the tutorial sessions I've done. The sessions are too large and too short to offer help during them.

One reason I recently switched to a Docker image is to remove almost all possible problems, assuming the user can run Docker on his or her workstation. Worst case, if someone can't get things working, encourage them to pair with a neighbor or follow along using the PDF of the tutorial notebook that's also in the `notebooks` directory.

## Loading the Tutorial Notebook

Assuming a successful installation of the Jupyter image, the end of the README describes how to load the tutorial notebook into the environment. This process is not as user-friendly as it could be, so I always walk through it in class.

From now on in these notes, I'll assume that we're in the tutorial notebook itself. Section titles in "quotes" refer to sections in the tutorial itself.

## "For More on Scala"

Tell them to click the two Scaladocs links, especially the one for Spark. They'll find it useful.

I also demonstrate the tip for searching for information using the Spark Scaladocs.

## "About Notebooks"

This is a good place to demonstrate how to use the notebooks:

* Navigate the cells using up and down arrow keys or clicking.
* Evaluate cells using `shift+return` or menu items. Do this for the first Scala cell that prints "Hello World!" and for a Markdown cell.
* Point out the toolbar menu item that shows the type of cell.
* Bring up the _Help > Keyboard Shortcuts_.
* Show the sidebar (_View > Toggle Sidebar_), then hide it again.
* In general, point out how useful notebooks are for learning and mixing documentation, code, and graphs of data.

## "Let's Load Some Data ..."

I emphasize again that we'll go through a lot of details, but the student should focus on the general concepts and refer back to the notebook cells for details later. We have to cover a lot of particulars to get to the "interesting stuff".

I rely on the fact that they can intuitively figure out a lot of details as they read them. The comment convention is a good example, especially for people with Java experience.

Note that the sizes of the data files are not very big, so it should work reasonable well even for a big class using a conference WiFi.

## "Setup the Files"

Discuss how the `if` example demonstrates that conditionals are expressions:

```scala
val success = if (shakespeare.exists == false) {   // doesn't exist already?
...
```

For the `for` comprehension, I describe the "gist" of what it's doing in the Scala cell, then let the subsequent Markdown cells explain how `for` comprehensions work. Again, emphasize that these are expressions.

We explain the `failures.foreach(println)` in subsequent cells, so in this cell, just tell them we'll come back to it.

## "Passing Functions as Arguments"

Now we explain the concept of _functions_ and return to `collection.foreach(println)` as an example (using `plays` as the collection).

Explain each example, noting that passing `println` vs. `str => println(str)` are **not** the same thing! In the first case, we're using `println` as the function. In the second case, we're passing an anonymous function that _calls_ `println`.


## "Inverted Index - When You're Tired of Counting Words..."

It's more interested than _Word Count_.

The way this section works is we show the whole thing, then break it down piece by piece.

I mention here that this is quite a lot of computation defined in few lines of code!

### Tuple Exercise

Give them a minute or two to try different tuples.

### Exercise After the Code Walkthrough

Give them a few minutes to try this depending on time. A subsequent refinement of the code will include the two additions they are asked to write.

Remind them that exercise solutions are at the end of the notebook.

## "Pattern Matching"

Make sure you have enough time to get to this section. It will be near the end of the 1/2 day session. Pattern matching is one of Scala's most powerful features, especially for Spark, so you should be sure to cover this section, even if you need to hurry through earlier sections and skip the two small exercises.

In particular, talk about the cell which begins "My favorite improvement..." The clarity of the pattern matching code, where it's immediately obvious what's happening, vs. the previous more obscure code is a strong argument for the value of pattern matching to both ease understanding and accelerate productivity. When I wrote this code the first time, I thought about the transformation I needed to make _and just wrote it down exactly as I pictured it!_

## "Final Implementation and Using DataFrames"

Skim through this quickly if you're running out of time, to get to the final version's output.

We could use a `Dataset`, but `DataFrames` are good enough for our purposes, especially for those students still using 1.6 "at home".

### "Our Final Version: Supporting SQL Queries"

This section reformats the output into a form more useful for SQL queries. Briefly describe what `zip` does and why we are using it, to create two columns with counts and locations separated, but in the same order, so they can be selected in a SQL statement.

## "More on Pattern Matching Syntax"

You may not make it this far in a 1/2 day course, but if you do, discuss how the examples demonstrate that pattern matching is quite flexible and powerful, including the ability to exploit it with case classes.

## "Scala for Spark 102"

You'll get to this material if you do a full-day tutorial. Even in a 1/2 day session, I encourage the students to work through this material on their own, because there is a lot they should know here.

## "Conclusions"

I thank them again for attending and encourage them to provide feedback directly to me or through the the project's Gitter channel or GitHub Issues.

I also remind them that most of the exercises have solutions at the end of the notebook.




