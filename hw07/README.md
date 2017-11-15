README (please)
================
Emily West

**Here is a link to my rendered [homwork07](https://github.com/emwest/STAT547A/tree/master/hw07)

My pipeline is three parted:
 
:zap: *Part I: download the [data](https://github.com/emwest/STAT547A/blob/master/hw07/gapminder_download.R)
 
:zap: *Part II: explore the data with some [exploratory analysis](https://github.com/emwest/STAT547A/blob/master/hw07/gapminder_exploratory.R)
 
:zap: *Part III: run statistics and generate some [figures](https://github.com/emwest/STAT547A/blob/master/hw07/gapminder_statistics.R)


:confetti_ball: The final part of this exercise was to automate the process using this [document](https://github.com/emwest/STAT547A/blob/master/hw07/Makefile.R)

Reflection: The automation process is fascinating, however cumbersome at times. I drew out the path of dependencies I was aiming for before starting yet most of the trouble came down to the nitty gritty of actually getting code to run. I opted for an all R approach because I am not comfortable working in the shell and this seemed a little more user friendly on the front end.

Still being relatively new to R, and not proficient, there are major inefficencies in my code. For instance, the way I chose to parse out the "best" and "worst" countries. Originally, I chose to write a function to iterate the process for each continent, however this lumped all of my all the data for a given continent which meant I could leave the data grouped, or split it by arranging based on mean life expectancy and subsetting the first 3 and last three entries respectively. Instead, I could have taken a different path altogether, the best and worst seperately for each continent seperately, which by using the rbind() would get me to my earlier output.

From a deliverable perspective I could have ended up with a "graphics" only line of code, however the way I chose to parse out the best and worst countries made this an inefficient process and I opted to keep my graphics with their statistics making it easy to modify by simply changing a couple of lines of code.

Overall this was a really interesting exercise. In my own analyses I have several csv's that need to be processed before they can used for analysis. Developing a stepwise approach now, early in my analysis would mean if I need to return to my data late in my thesis I could run large parts of my code unsupervised, saving time and frustration.

 
 