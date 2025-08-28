#!/bin/bash
#-----------------------------------------------------------------------------
#       STEP 1: Fetching the file
#-----------------------------------------------------------------------------

fasterq-dump SRR34030217
echo "fetching is done"

#------------------------------------------------------------------------------
#                     STEP 2: Quality Control
#------------------------------------------------------------------------------

fastqc *.fastq
echo "Quality control is done"
#------------------------------------------------------------------------------
#                   STEP 3: Trimming the sequence
#------------------------------------------------------------------------------
Trimmomatic=/usr/share/java/trimmomatic-0.39.jar
read=/home/sne_desh/rna_seq/P1/SRR34030217.fastq
read_trimmed=/home/sne_desh/rna_seq/P1/SRR34030217_trimmed.fastq


java -jar $Trimmomatic SE $read $read_trimmed \
ILLUMINACLIP:TruSeq3-SE.fa:2:30:10 \
LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
echo "Trimming is done"
#-------------------------------------------------------------------------------
#              STEP 4: Post trrimming Quality Check
#-------------------------------------------------------------------------------

fastqc SRR34030217_trimmed.fastq
echo "Quality contol two is done"
#--------------------------------------------------------------------------------
#                    STEP 5: HISAT2 Alignment
#--------------------------------------------------------------------------------

/usr/bin/hisat2 -q -x /home/sne_desh/HISAT2/MTB/mtb_index -U SRR34030217.fastq -S aligned.sam
echo "Alignement is done"
#---------------------------------------------------------------------------------
#               Step 6: Samt to bam conversion & sorting
#---------------------------------------------------------------------------------
samtools view -S -b aligned.sam > aligned_unsorted.bam
samtools sort -o aligned_sorted.bam aligned_unsorted.bam
samtools index aligned_sorted.bam
echo "Conversion and sorting is done"
#---------------------------------------------------------------------------------
#                  STEP 6: Quantification
#---------------------------------------------------------------------------------
featureCounts -T 8 -a /home/sne_desh/HISAT2/MTB/genomic.gtf -o final.txt aligned_sorted.bam
echo "Quantification is done"
#---------------------------------------------------------------------------------
#                STEP 7: Conversion .txt to .csv
#---------------------------------------------------------------------------------

cat final.txt | tr '\t' ',' > read_counts.csv
echo ".txt to .csv conversion is done"
#---------------------------------------------------------------------------------
#        Step 8: Csv file is tmported into R for further analysis
#---------------------------------------------------------------------------------
