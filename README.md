# HTL-ATAC-seq

A collection of analysis scripts for single-cell ATAC-seq data during mouse lung development

## Project Description

This repository contains R and Shell scripts for analyzing single-cell ATAC-seq data during mouse lung (HTL) development (P0-P14). The main research areas include:

- Chromatin accessibility analysis
- Cell type annotation and clustering
- Transcription factor binding site (TFBS) analysis
- Developmental trajectory analysis
- Co-accessibility network analysis

## Directory Structure

```
HTL-ATAC-seq-main/
├── Demultiplexing/          # Data preprocessing scripts
│   ├── pipeline.sh          # Main pipeline script
│   ├── PruneFastq_byLane.sh # Single lane processing script
│   ├── runCellranger.sh     # Cell Ranger execution script
│   └── barcode.txt          # Sample barcode index file
│
├── Function/                # Core function library
│   ├── LoadsingleSample.func.R    # Single sample data loading
│   ├── MergeSampleObj.R           # Multi-sample merging
│   ├── ClusterAndTypeing.func.R   # Clustering and cell type annotation
│   ├── CallPeaks.func.R           # Peak calling
│   ├── MotifAnalysis.func.R      # Transcription factor analysis
│   ├── Trajectory.R               # Developmental trajectory analysis
│   ├── Co_accessibility.R         # Co-accessibility analysis
│   └── ...                        # Other utility functions
│
├── Figure1_3.R              # Visualization scripts for Figure 1 and 3
├── Figure4_5.R              # Visualization scripts for Figure 4 and 5
├── Figure6_AT1.R            # AT1 cell-related analysis
├── Figure6_AT2.R            # AT2 cell-related analysis
├── Figure7.R                # Visualization script for Figure 7
├── Supp4_7_01.R            # Supplementary material analysis script 1
├── Supp4_7_02.R            # Supplementary material analysis script 2 (includes Python code)
│
├── myFun.R                  # Core utility functions and configuration
├── markerlist.R            # Cell type marker gene lists
└── colors.R                # Color definition file
```

## Dependencies

### R Packages
- **Seurat** - Single-cell analysis framework
- **Signac** - Single-cell ATAC-seq analysis
- **ArchR** - Trajectory analysis
- **JASPAR2024** - Transcription factor database
- **EnsDb.Mmusculus.v79** - Mouse genome annotation
- **ggplot2**, **ggsci**, **ComplexHeatmap** - Visualization

### Other Tools
- **Cell Ranger** - 10x Genomics data processing
- **seqtk** - FASTQ file processing
- **barcode_splitter** - Barcode splitting tool

## Usage

### 1. Data Preprocessing

Modify paths and sample information in `Demultiplexing/pipeline.sh`:

```bash
sample_id='YOUR_SAMPLE_ID'
batch='YOUR_BATCH'
# Modify data paths
all_fastq=/path/to/your/fastq/
cellranger_outdir=/path/to/cellranger/output/
```

### 2. Data Analysis

Load function libraries in R:

```r
source('myFun.R')  # Load core functions and configuration
source('Function/LoadsingleSample.func.R')  # Load data loading functions
# ... Load other required functions
```

### 3. Visualization

Run the corresponding Figure scripts (data paths need to be adjusted first):

```r
source('Figure1_3.R')
```

## Important Notes

1. **Path Configuration**: All paths in the scripts are placeholders and need to be modified according to your actual environment
2. **Data Format**: Scripts assume input data is in Cell Ranger standard output format
3. **Parameter Adjustment**: Clustering resolution, dimensionality reduction parameters, etc. need to be adjusted based on actual data
4. **Dependency Installation**: Ensure all R packages and system tools are properly installed

## Research Content

- **Time Points**: P0 (birth) to P14 (14 days post-birth)
- **Main Cell Types**:
  - Epithelium: AT1, AT2
  - Immune cells
  - Stromal cells
  - Endothelial cells
