#Rentrez Package provides an interface to the NCBI's 'EUtils' API
#This allows users to search databases such as PubMed and NCBI
install.packages("rentrez")
library(rentrez)

#Accession numbers of various sequences found within NCBI
ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1")

#entrez_fetch() function allows for downloading data from NCBI databases to repository
#Unique identifiers: database = nuccore, id is those of the created object above, and FASTA is the character format
Bburg<-entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta")

#strsplit() function allows for the splitting of elements of a character vector (such as the Bburg sequence data)
Sequences <- strsplit(Bburg,"\n\n")
Sequences<-unlist(Sequences)

#Using regex to remove the headers from each of the sequences
header<-gsub("(^>.*sequence)\\n[ATCG].*","\\1",Sequences)
seq<-gsub("^>.*sequence\\n([ATCG].*)","\\1",Sequences)
Sequences<-data.frame(Name=header,Sequences=seq)

#Removing all Newline characters and creating a new Data.Frame
A <- gsub("[\r\n]", "", seq)
Sequences<-data.frame(Name=header,Sequences=A)

#Generating a CSV file containing 2 columns and 3 rows
write.csv(Sequences, file="Sequences.csv")




