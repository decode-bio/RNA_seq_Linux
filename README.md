# Objective
This repository is created to document the step by step process of RNA Sequencing in Linux environment.
# Tools used
* fasterq-dump
* fastqc
* Trimmomatic
* Hisat2
* Samtools
* featurecount
* DESeq2

# About Data



# Downloading the Data
```
fasterq-dump SRR34030217
```
<img width="457" height="101" alt="image" src="https://github.com/user-attachments/assets/92666ef2-3f20-4d4a-a8d7-9ac63312c08a" />

# Quanlity check
```
fastqc *.fastq
```
<img width="757" height="555" alt="image" src="https://github.com/user-attachments/assets/ff6128c1-7f5b-4e47-8353-ad5828fcefad" />

# Trimming sequence using Trimmomatic
```

```
<img width="1919" height="274" alt="image" src="https://github.com/user-attachments/assets/08111ebd-4713-4799-9eaf-d46d3a0dad63" />

# Comparing the before and after trimminf Quality
Before Trimming
<img width="1919" height="962" alt="image" src="https://github.com/user-attachments/assets/f27664f5-465b-45c9-98be-3fbc728185b0" />
After Trimming
<img width="1919" height="973" alt="image" src="https://github.com/user-attachments/assets/f2e70411-d107-4a87-a7fe-5af677259808" />

On comparing both the Qualities, I have decided to proceed with original sequence as our sequence length have reduced which will create the possibilities to align with genome at multiple sites. Also our aligner anyway softclip the adapters.

# HISAT2 Alignement
The MTB (Mycobacterium Tuberculosis) genome is downloaded and indexed beforehand to align the sequence.
```
/usr/bin/hisat2 -q -x /home/sne_desh/HISAT2/MTB/mtb_index -U SRR34030217.fastq -S aligned.sam
```
<img width="1225" height="171" alt="image" src="https://github.com/user-attachments/assets/35deae10-04dc-4f1e-8cb8-573b96f745eb" />
96.68 % is our overall alignment rate.

# .Sam to .bam conversion and sorting
* sam to bam conversion
```
samtools view -b -S aligned.sam > aligned_unsorted.bam
```
* sorting
```
samtools sort -o aligned_sorted.bam aligned_unsorted.bam
```
* Indexing
```
samtools index aligned_sorted.bam
```

# Quantification using featureCounts
```
featureCounts -T 8 -a /home/sne_desh/HISAT2/MTB/genomic.gtf -o final.txt aligned_sorted.bam
```
<img width="980" height="254" alt="image" src="https://github.com/user-attachments/assets/34b45bd8-2d31-4063-9db9-432e4eb9a9e7" />

<img width="1125" height="970" alt="image" src="https://github.com/user-attachments/assets/e29c8398-e1e4-4992-b14a-933448380a33" />

So we have 37.5 % aligned reads.

Lets check our final.txt file
```
cat final.txt | less
```
<img width="880" height="940" alt="image" src="https://github.com/user-attachments/assets/ff3099f8-9d4b-467a-9514-3fc9917d4288" />

Lets see our final.txt.summary file
```
cat final.txt.summary
```
<img width="824" height="389" alt="image" src="https://github.com/user-attachments/assets/f8faabdb-b267-4002-8b2f-7cbf444f6a23" />

# conversion from txt to .csv
We can also install pandas to convert the .txt file into .csv but here I am using the following in-built command.
```
cat final.txt | tr '\t' ',' > read_counts.csv
```
<img width="693" height="586" alt="image" src="https://github.com/user-attachments/assets/023ada06-435f-4024-974f-1ea100a0dd52" />

# DEseq




