% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fetchSequence.R
\name{fetchSequence}
\alias{fetchSequence}
\title{Fetch protein/peptide sequences and create a \code{\link{dagPeptides-class}} object.}
\usage{
fetchSequence(
  IDs,
  type = "entrezgene",
  anchorAA = NULL,
  anchorPos,
  mart,
  proteome,
  upstreamOffset,
  downstreamOffset
)
}
\arguments{
\item{IDs}{A character vector containing protein/peptide IDs used to fetch 
sequences from a Biomart database or a \code{\link{Proteome-class}} object.}

\item{type}{A character vector of length 1. The available options are 
"entrezgene" and "uniprotswissprot" if parameter \code{mart} is missing;
otherwise it can be any type of IDs available in Biomart databases.}

\item{anchorAA}{A character vector of length 1 or the same length as that of
anchorPos, each element of which is a single letter symbol of amino acids, 
for example, "K" for lysine.}

\item{anchorPos}{A character or numeric vector. Each element of which is (1) a 
single-letter symbol of amino acid followed by the position of the anchoring 
amino acid in the target peptide/protein sequence, for example, "K123" for lysine 
at position 123 or the position of the anchoring amino acid in the target 
peptide/protein sequence, for example, "123" for an amino acid at position 123; 
or (2) a vector of subsequences containing the anchoring AAs.}

\item{mart}{A Biomart database name you want to connect to. Either of parameters 
\code{mart} or \code{proteome} should be provided.}

\item{proteome}{An object of \code{\link{Proteome-class}}. Either of parameters 
\code{mart} or \code{\link{Proteome-class}} should be provided.}

\item{upstreamOffset}{An integer, the upstream offset relative to
the anchoring position.}

\item{downstreamOffset}{An integer, the downstream offset relative
to the anchoring position.}
}
\value{
An object of class \code{\link{dagPeptides-class}}
}
\description{
This function fetches protein/peptide sequences from a Biomart database or 
from a \code{\link{Proteome-class}} object based on protein/peptide IDs and create 
a \code{\link{dagPeptides-class}} object following restriction as specified by 
parameters: anchorAA or anchorPos, upstreamOffset and downstreamOffset.
}
\examples{
## Case 1: You have both positions of the anchoring AAs and the identifiers 
## of their enclosing peptide/protein sequences for fetching sequences using 
## the fetchSequence function via the Biomart.

if (interactive())
{
    try({
    mart <- useMart("ensembl")
    fly_mart <-
       useDataset(mart = mart, dataset = "dmelanogaster_gene_ensembl")
    dat <- read.csv(system.file("extdata", "dagLogoTestData.csv",
                           package = "dagLogo"))
    seq <- fetchSequence(
       IDs = as.character(dat$entrez_geneid),
       anchorPos = as.character(dat$NCBI_site),
       mart = fly_mart,
       upstreamOffset = 7,
       downstreamOffset = 7)
   head(seq@peptides)
   })
}


## Case 2: You don't have the exactly postion information, but You have the 
## interesting peptide subsequences and the identifiers of their enclosing 
## peptide/protein sequences for fetching sequences using the fetchSequence
## function via the Biomart. In the following examples, the anchoring AAs 
## are marked by asterisks. 
if (interactive())
{
    try({
        mart <- useMart("ensembl")
        fly_mart <-
            useDataset(mart = mart, dataset = "dmelanogaster_gene_ensembl")
        dat <- read.csv(system.file("extdata", "dagLogoTestData.csv",
                                    package = "dagLogo"))
        seq <- fetchSequence(
            IDs = as.character(dat$entrez_geneid),
            anchorAA = "*",
            anchorPos = as.character(dat$peptide),
            mart = fly_mart,
            upstreamOffset = 7,
            downstreamOffset = 7
        )
        head(seq@peptides)
    })
}

## In following example, the anchoring AAs are lower-case "s" for amino acid 
## serine.
if(interactive())
{
   try({
       dat <- read.csv(system.file("extdata", "peptides4dagLogo.csv",
                                   package = "dagLogo"))
        mart <- useMart("ensembl")
        human_mart <-
            useDataset(mart = mart, dataset = "hsapiens_gene_ensembl")
        seq <- fetchSequence(IDs = toupper(as.character(dat$symbol)),
                             type = "hgnc_symbol",
                             anchorAA = "s",
                             anchorPos = as.character(dat$peptides),
                             mart = human_mart,
                             upstreamOffset = 7,
                             downstreamOffset = 7)
        head(seq@peptides)
    })
}


}
