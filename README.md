# Objective
This repository is created to document the step by step process of RNA Sequencing in Linux environment.
# Tools used
* fasterq-dump
* fastqc
* Trimmomatic
* HISAT2
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

On comparing both the Qualities, I have decided to proceed with original sequence as our sequence length have reduced which will create the possibilities to align with genome at multiple sites. Also our Hisat 2 aligner anyway softclip the adapters.

# Hisat2 Alignement



