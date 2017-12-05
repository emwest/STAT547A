---
title: "HW10 README"
author: "Emily West"
date: "12/5/2017"
---

Brief description of my adventure: 

I chose to do this homework in two parts. [Part I]() provides an example of using httr() to aquire multiple sources of data from the Star Wars API (Swapi) and merging them into a single data set. This portion of the homework is provided in an html. [Part II]() provides an example of calling data from an API that requires a key. To preserve the security of the authorization key, reviewers will need to [request a key](https://developer.nytimes.com/signup) in order to run the code. 


REFLECTION: Homework 10 was an excellent opportunity to pull together several topics covered in STAT547. I started by calling data from the internet by hand, using the httr() family of operations. Branching out from the prompts, I decided to use the Star Wars API to pull multiple sources of data (planets, people, starships) from the web. Building a function to pull data from the web was achieved by using the glue function, streamlining the process of calling multiple datasets. In my greatest triumph of this course, I was able to create a function that identified the starwars character and used the embedded link to pull the homeplanet data from the web and populate a new "homeworld" column that contains the actual name of the planet, not just the link as before.  In addition, I made use of the NYTimes API to explore using a key and integrating more purrr functions. In doing so I was able to "edit" text within columns of a dataframe and select specific types of articles and develop a novel dataframe from those queries.