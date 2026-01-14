# MLops-pipeline <br>
# Built a reproducible RNA-seq pipeline with Snakemake, Conda, Git, and DVC.<br>
production of ready pipline where we perform steps like :<br>
1. We organized our project properly this is called project standarization <br>
```bash
pipeline/
├── data/
│   ├── raw/          # FASTQ files
│   └── reference/    # genome + GTF
├── result/
│   ├── fastqc/
│   ├── align/
│   └── counts/
├── RNASEQ/
│   ├── snakefile
│   └── config.yaml
├── envs/             # conda environments
├── .git/
├── .dvc/
```
<br>
2. We automted RNA-seq pipline steps using snakemake this is called workflow automation.Instead of running commands manually, Snakemake:<br>
1.Detects missing files<br>
2.Runs steps in correct order<br>
3.Re-runs only what changed<br>
<br>

| Step           | Tool           | Purpose              |
|----------------|----------------|----------------------|
| QC             | FastQC         | Check read quality   |
| Alignment      | STAR           | Map reads to genome  |
| Quantification | featureCounts  | Gene-level counts    |

<br>
3. We use conda for reproducibility each tool (STAR, featureCounts, FastQC) is installed in isolated environments this is called software reproducibility<br>
4. We used DVC for large data this is called Data Version Control.
<br>
```bash
dvc add data/raw
dvc add result/align
dvc add result/counts
```
<br>
This means: FASTQ / BAM / counts are NOT stored in Git, Git only tracks .dvc pointer files, Actual data is stored in a DVC remote.<br>
5. We configured a DVC remote this is called separating code from data
<br>
```bash
dvc remote add -d localstore /media/kirti/HD/dvc-store
```
<br>
This means our data lives in external storage & Git repo stays lightweight so we can reproduce the same results anytime.





















# NOTE

## Data Management

This project uses **DVC (Data Version Control)** to manage large datasets and pipeline outputs.

Due to size constraints, raw data and intermediate results are **not stored in GitHub**.

### Tracked with DVC
- `data/raw/` – raw sequencing files (FASTQ)
- `result/align/` – alignment outputs (BAM)
- `result/counts/` – gene count matrices

Only the corresponding `.dvc` metadata files are versioned in Git.

### Reproducing the data locally
After cloning the repository, run:

```bash
dvc pull
