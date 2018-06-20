# Set working directory
setwd("")

# Load plot summaries
plots <- read.csv("Plots.csv")

# Convert to characters
plots$Plot <- as.character(plots$Plot)

# Peek at plot keywords
head(plots$Plot, 3)

# Load text mining package
library(tm)

# Load SnowballC package
library(SnowballC)

# Convert plots into a corpus
corpus <- Corpus(VectorSource(plots$Plot))

# Inspect first entry in the corpus
corpus[[1]]$content

# Convert terms to lower case
corpus <- tm_map(corpus, content_transformer(tolower))

# Remove punctuation
corpus <- tm_map(corpus, removePunctuation)

# Remove stop words from corpus
corpus <- tm_map(corpus, removeWords, stopwords("english"))

# Reduce terms to stems in corpus
corpus <- tm_map(corpus, stemDocument, "english")

# Strip whitespace from corpus
corpus <- tm_map(corpus, stripWhitespace)

# Convert corpus to text document
corpus <- tm_map(corpus, PlainTextDocument)

# Inspect first entry in the corpus
corpus[[1]]$content

# Load the wordcloud package
library(wordcloud)

corpus <- Corpus(VectorSource(corpus))

# Create a frequency word cloud
wordcloud(
  words = corpus,
  max.words = 50)

wordcloud(corpus, scale=c(5,0.5), max.words=100, random.order=FALSE, rot.per=0.35, use.r.layout=FALSE)

plot(quanteda::corpus(corpus), max.words = 50, random.order = TRUE)