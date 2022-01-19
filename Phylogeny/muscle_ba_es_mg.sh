##_____________________________________________________________________________________________________##
# 1) Create merge_fasta_files folder

cd /Users/gepolianochaves/Desktop/Gepoliano/UFOB/sequencesfilogeniaData
mkdir ../sequencesfilogeniaData/merge_fasta_files

##_____________________________________________________________________________________________________##
# 2) Copy new sequences from BA, ES, MG into merge_fasta_files folder

cd /Users/gepolianochaves/Desktop/Gepoliano/UFOB/sequencesfilogeniaData
cp gisaid* merge_fasta_files

##_____________________________________________________________________________________________________##
# 3) Merge BA, ES, MG files in ba_es_mg.fasta

cd merge_fasta_files

pwd

# Check types of FASTA files in 
cat gisaid* > ba_es_mg.fasta

grep -c '>' ba_es_mg.fasta

grep -c '>hCoV-19/Brazil/' ba_es_mg.fasta

##_____________________________________________________________________________________________________##
# 4) Send ba_es_mg.fasta to ReComBio Phylogeny

pwd

cp ba_es_mg.fasta /Users/gepolianochaves/Desktop/Gepoliano/ReComBio/English/Phylogeny

## Count number of fasta seqs in destination
grep -c '>' /Users/gepolianochaves/Desktop/Gepoliano/ReComBio/English/Phylogeny/ba_es_mg.fasta

##_____________________________________________________________________________________________________##
# 5) Merge Sequences UFOB

cd ~/Desktop/Gepoliano/UFOB/Sequences_07-21-2021/UFOB_all_sequencesjosi_split_files/

pwd

cat *fasta > ufob_65.fasta

grep -c '>' ufob_65.fasta

##_____________________________________________________________________________________________________##
# 6) Send ufob_65.fasta to ReComBio Phylogeny

cp ufob_65.fasta /Users/gepolianochaves/Desktop/Gepoliano/ReComBio/English/Phylogeny

grep -c '>' /Users/gepolianochaves/Desktop/Gepoliano/ReComBio/English/Phylogeny/ufob_65.fasta

##_____________________________________________________________________________________________________##
# 7) Move to Phylogeny and Merge ufob_65.fasta, ba_es_mg.fasta and sequences from Teixeira de Freitas

cd /Users/gepolianochaves/Desktop/Gepoliano/ReComBio/English/Phylogeny

pwd

grep -c '>' ba_es_mg.fasta
grep -c '>' bahia_combined_30000_muscle.fasta
grep -c '>' ufob_65.fasta

cat ba_es_mg.fasta bahia_combined_30000_muscle.fasta ufob_65.fasta > ba_es_mg_bat.fasta

grep -c '>' ba_es_mg_bat.fasta

#muscle -in ba_es_mg_bat.fasta -out ba_es_mg_bat_muscle.fasta