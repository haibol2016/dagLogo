% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/testDAU.R
\name{testDAU}
\alias{testDAU}
\title{Differential usage test of amino acids or amino acid groups.}
\usage{
testDAU(
  dagPeptides,
  dagBackground,
  groupingScheme = ls(envir = cachedEnv),
  bgNoise = NA
)
}
\arguments{
\item{dagPeptides}{An object of Class \code{\link{dagPeptides-class}}.}

\item{dagBackground}{An object of Class \code{\link{dagBackground-class}}.}

\item{groupingScheme}{A character vector of length 1. Available choices are 
"no","bulkiness_Zimmerman","hydrophobicity_KD", "hydrophobicity_HW", 
"isoelectric_point_Zimmerman", "contact_potential_Maiorov",
"chemistry_property_Mahler", "consensus_similarity_SF", 
"volume_Bigelow", "structure_alignments_Mirny", "polarity_Grantham", 
"sequence_alignment_Dayhoff", "bulkiness_Zimmerman_group", "hydrophobicity_KD_group",
"hydrophobicity_HW_group", "charge_group", "contact_potential_Maiorov_group",
"chemistry_property_Mahler_group", "consensus_similarity_SF_group", 
"volume_Bigelow_group", "structure_alignments_Mirny_group", "polarity_Grantham_group",  
"sequence_alignment_Dayhoff_group", "custom" and "custom_group". If "custom" or
"custom_group" are used, users must define a grouping scheme using a list 
containing sublist named as "color", and "symbol" using the function
addScheme, with group set as "NULL" or a list with same names as those of color 
and symbol. No grouping was applied for the first 12 schemes. It is used to 
color AAs based on similarities or group amino acids into groups of similarities.}

\item{bgNoise}{A numeric vector of length 1 if not NA. It should be in 
the interval of (0, 1) when not NA.}
}
\value{
An object of Class \code{\link{testDAUresults-class}}.
}
\description{
Test differential usage of amino acids with or without grouping between
experimental sets and background sets.
}
\examples{
dat <- unlist(read.delim(system.file(
                                   "extdata", "grB.txt", package = "dagLogo"),
                         header = FALSE, as.is = TRUE))
                         
##prepare an object of Proteome Class from a fasta file
proteome <- prepareProteome(fasta = system.file("extdata",
                                                "HUMAN.fasta",
                                                package = "dagLogo"), 
                            species = "Homo sapiens")
##prepare an object of dagPeptides Class
seq <- formatSequence(seq = dat, proteome = proteome, upstreamOffset = 14,
                     downstreamOffset = 15)
bg_fisher <- buildBackgroundModel(seq, background = "wholeProteome",
                                  proteome = proteome, testType = "fisher")
bg_ztest <- buildBackgroundModel(seq, background = "wholeProteome",
                                   proteome = proteome, testType = "ztest")

## no grouping and distinct coloring scheme
t0 <- testDAU(seq, dagBackground = bg_ztest)

## grouped by polarity index (Granthm, 1974)
t1 <- testDAU(dagPeptides = seq, dagBackground = bg_ztest, 
             groupingScheme = "polarity_Grantham_group")
             
## grouped by charge.
t2 <- testDAU(dagPeptides = seq, dagBackground = bg_ztest, 
              groupingScheme = "charge_group")
              
## grouped on the basis of the chemical property of side chains.
t3 <- testDAU(dagPeptides = seq, dagBackground = bg_ztest, 
              groupingScheme = "chemistry_property_Mahler_group")
              
## grouped on the basis of hydrophobicity (Kyte and Doolittle, 1982)
t4 <- testDAU(dagPeptides = seq, dagBackground = bg_ztest, 
              groupingScheme = "hydrophobicity_KD_group")                                   
}
\author{
Jianhong Ou, Haibo Liu
}
