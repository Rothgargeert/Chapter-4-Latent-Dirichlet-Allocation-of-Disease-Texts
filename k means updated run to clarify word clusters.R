set.seed(1234)
library (tm)
importdf = read.csv('dfnlp.csv', header = F, stringsAsFactors = F)

import_corpus = Corpus(VectorSource(importdf))

tdm = TermDocumentMatrix(import_corpus,
                         control = list(weighting = weightTfIdf,
                                        stemming = TRUE, #create root words
                                        stopwords = TRUE, #remove stop words
                                        minWordLength = 3, #cut out small words
                                        removeNumbers = TRUE, #take out the numbers
                                        removePunctuation = TRUE)) #take out

library (cluster)
set.seed(1234)
m <- as.matrix(tdm)
#compute distance between document vectors
d <- dist(m)
#kmeans clustering
#kmeans - run with nstart=100 and k=2,3,5 
kfit <- kmeans(d, 3, nstart=100)
#plot - 
clusplot(as.matrix(d), kfit$cluster, color=T, shade=T, labels=2, lines=0)

kfit <- kmeans(kmeans.data, 3)
kfit$cluster

library(factoextra)
fviz_cluster(kfit, data = d)
