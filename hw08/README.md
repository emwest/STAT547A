This week's homework can be accessed here[]

To keep my ui.R and server.R files as concise as possible, I have chosen to make my usual copius notes here in my ReadMe.
I opted to 
>because server accesses your app folder, only files associate with the app should be included
>create www folder to hold figures/graphics
A quick and simple way to download a file:
url_kitten<- "url here"
download.file(url_kitten, "www/kitten.jpg")