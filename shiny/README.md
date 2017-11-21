Code for this week's homework can be accessed [here]https://github.com/emwest/STAT547A/tree/master/hw08 , and my very own shiny app can be found [here]https://emwest.shinyapps.io/Sample_for_STAT547_emwest_2017/
Please note that my data is originally sourced from OpenDataBC and the code used here has been informed and adapted from the examples provided by Dean Attali.


#Here are the features I added to the app:
:pencil2: An inspiring image to the sidebar
:pencil2: A interactive data table using renderDataTable()
:pencil2: Designated tabs for my table and graph
:pencil2: An interactive message to inform the user the number of results
:pencil2: A download button so the user can download their results

A few notes to myself about using shiny:
A shiny app operates based on two primary features, a user interface (ui) that the user interacts with and can manipulate and a server, that houses all of the code and takes the manipulations of the user to generate outputs. In this way there is "reactivity" between the server and the ui. It is a little challenging to wrap ones head around at first. I found it important to keep in mind that you write the ui first, this includes all the things the user will see and interact with. Once you have drawn that out, you build the server.

A few odd notes:

because the server accesses your app folder, only files associate with the app should be included

create www folder to hold figures/graphics
A quick and simple way to download a file:
url_kitten<- "url here"
download.file(url_kitten, "www/kitten.jpg")