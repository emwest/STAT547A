library(httr)
library(jsonlite)
library(xml2)
install.packages("rvest")
library(rvest)
x<-GET('https://google.com/') #GET() retrieves what is specified by the URL
str(x)
x$status_code
x$headers
x$times

y<-GET('https://google.com/', query = list(a=2))
str(y)
View(y)

z<-GET('https://google.com/', add_headers(wave = "1"))
str(z)
View(z)

res<- GET("http://httpbin.org/get")
code<- res$status_code
http_status(code)
res$request$headers[[1]]
res$headers$'content-type'

#change accept content type
res<- GET("http://httpbin.org/get", accept_json())
View(res)

res <- GET("http://httpbin.org/status/400")
res

fromJSON('{"foo":"bar"}')
fromJSON('[{"foo":"bar", "hello":"world"}]')

res<- read_xml('<foo>bar</foo>')
xml_name(res)          

j1<-GET("http://www.omdbapi.com/?t=iron%20man%202&r=json")
content(j1, as = "text")

#try using rvest
frozen<-read_html("http://www.imdb.com/title/tt2294629")
html_structure(frozen)
as_list(frozen)
xml_children(frozen)
xml_children(frozen)[[2]]
xml_contents(frozen)
xml_contents(xml_children(frozen)[[2]])
itals<-html_nodes(frozen, "em")
View(itals)
html_text(itals)
html_name(itals)
cast<-html_nodes(frozen, "span.itemprop")
cast
html_text(cast)

#Use the selector gadget to do the heavy lifting
cast2<-html_nodes(frozen, ".itemprop .itemprop")
html_text(cast2)

#best places
morris<-read_html("http://www.bestplaces.net/zip-code/vermont/morrisville/05661")
col<-html_nodes(morris, "#navigation li:nth-child(3) a")
html_text(col)

tables<- html_nodes(morris, css = "table")
html_table(tables, header = TRUE)
