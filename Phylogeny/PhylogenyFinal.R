#______________________________________________________________________________________#
# Compare SARS-CoV-2 Sequences from Teixeira de Freitas, Brazil, with bat and pangolin viral sequences.
# In total, we have 42/48 Sequences from Teixeira de Freitas, Medeiros Neto (Bahia-Brazil), 
# bat and pangolin SARS-CoV-2 sequences

# The Code below is divided in steps 1-8

#_________________________________________________________________#
# 1) Read multi-fasta using msa

# Load msa

library("msa")

# multi-fasta file was modified to start with the same sequence 
# (this is what defines the idea of the files to be aligned)
# fasta files that had ~ 3000bp long downloaded from GISAID were removed
# This is the reason why we end up with 42/48 sequences in total

dna_sarsCov2_start_30000 <- readDNAStringSet(
  file="bahia_combined_start_30000.fasta"
  )

#_________________________________________________________________#
# 2) Count number and size of sequences in multi-fasta

# Function read.dna is from package ape
# Load library ape

library("ape")

sars <- read.dna(
  "bahia_combined_start_30000.fasta", 
  format="fasta")
# object sars defined above, should let you know what the number of sequences in the multi-fasta is
sars # This object also lets you know the minimum and maximum lengths of the fasta sequences

#_________________________________________________________________#
# 3) Subset the fasta sequences in the Biostrings object

# Now we know the min and max sizes of fasta in the multi-fasta.
# We can then subset these sequences in order for them to have the same size.
# In order to do that, we will use the function subseq(), which is from the package XVector.
# XVector was loaded with package msa.
# We need to tell function subset() to use the shortest length as the maximum in the new object that will be constructed.
# This is the reason why we define the interval 1-27213 as the length for all sequences from this point on.

subset_start_27213 <- subseq(dna_sarsCov2_start_30000, start = 1, end = 27213)

# This command should let you know that subset_start_27213 is of class Biostrings.
class(subset_start_27213)

# Because now all dna strings in object subset_start_27213 have the same length (27213 bp),
# we can expect the phylogenetic tree algorithm to work without problems.
# I spent sometime deciding whether to do this subseting in R or bash. R seems more practical.

#_________________________________________________________________#
# 4) Coerce Biostring to DNA.bin 

# This is necessary so function dist.ml can take the DNA.bin object and 
# process the Distance Matrix.
# Function dist.ml() is from package phangorn

# Load phangorn

library("phangorn")

dm  <- dist.ml(as.DNAbin(subset_start_27213)) # This first converts Biostring to class phyDat or as.DNAbin(?)

#_________________________________________________________________#
# 5) Plot Distance Matrix Teixeira de Freitas

# Function table.paint() needs package adegenet

# Load adegenet

library("adegenet")

temp <- as.data.frame(as.matrix(dm))
table.paint(temp, cleg=0, clabel.row=.5, clabel.col=.5)



#_________________________________________________________________#
# 6) Construct Phylogenetic Trees

treeUPGMA  <- upgma(dm)
treeNJ  <- NJ(dm)

#_________________________________________________________________#
# 7) Plot Phylogenetic Trees Teixeira de Freitas

plot(treeUPGMA, main="UPGMA", col="red")
plot(treeNJ, "unrooted", main="NJ")

#_________________________________________________________________#
# 8) Save Phylogenetic Tree to file

# Create figures directory to save pictures to
dir.create("PhylogenyFigures")

# Save to file

pdf(file = "PhylogenyFigures/Teixeira_Tree_UPGMA.pdf",
    width = 20, 
    height = 7)
plot(treeUPGMA, main="UPGMA", col="red")
dev.off()

pdf(file = "PhylogenyFigures/Teixeira_Tree_NJ_Unrooted.pdf",
    width = 15, 
    height = 7)
plot(treeNJ, "unrooted", main="NJ Unrooted")
dev.off()

pdf(file = "PhylogenyFigures/Teixeira_Tree_NJ.pdf",
    width = 15, 
    height = 7)
plot(treeNJ, main="NJ")
dev.off()
