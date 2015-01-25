# install.packages("twitteR")
# install.packages("ROAuth")
# library("twitteR")
# library("ROAuth")
library ("plyr")

# Download "cacert.pem" file
download.file(url="http://curl.haxx.se/ca/cacert.pem",destfile="cacert.pem")

#create an object "cred" that will save the authenticated object that we can use for later sessions
cred <- OAuthFactory$new(consumerKey='XXXXX',
                         consumerSecret='XXXX',
                         requestURL='https://api.twitter.com/oauth/request_token',
                         accessURL='https://api.twitter.com/oauth/access_token',
                         authURL='https://api.twitter.com/oauth/authorize')

# Executing the next step generates an output --> To enable the connection, please direct your web browser to: <hyperlink> . Note:  You only need to do this part once
cred$handshake(cainfo="cacert.pem")

#save for later use for Windows
save(cred, file="twitter authentication.Rdata")

load("twitter authentication.Rdata")
registerTwitterOAuth(cred)


# Test download data

search.string <- "#nba"
no.of.tweets <- 10
#geocode='51.9852770,5.6636560,50km'
griep2.tweets <- searchTwitter(search.string, n=no.of.tweets, geocode='37.781157,-122.39720,50km', cainfo="cacert.pem", lang="en")

tweets.df = ldply(griep.tweets, function(t) t$toDataFrame() ) 
tweets.df
griep.tweets

