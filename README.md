# HTL-ATAC-seq

A collection of analysis scripts for single-cell ATAC-seq data during mouse lung development

## Project Description

This repository contains R and Shell scripts for analyzing single-cell ATAC-seq data during mouse lung development (P0-P14). The main research areas include:

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
├── Supp4_7_02.R            # Supplementary material analysis script 2
│
├── myFun.R                  # Core utility functions and configuration
├── markerlist.R            # Cell type marker gene lists
└── colors.R                # Color definition file
```

## Dependencies

### R Packages
- **Seurat** - Single-cell analysis framework
- **Signac**, **SnapATAC2**, **Scanpy** - Single-cell ATAC-seq analysis
- **JASPAR2024** - Transcription factor database
- **EnsDb.Mmusculus.v79** - Mouse genome annotation
- **ggplot2**, **ggsci**, **ComplexHeatmap** , **ComplexHeatmap** - Visualization

### Other Tools
- **Cell Ranger** - 10x Genomics data processing
- **seqtk** - FASTQ file processing
- **barcode_splitter** - Barcode splitting tool
  
R v4.2.1, Python v3.10, Cell Ranger ARC v2.1.0, SnapATAC2 v2.8.0, Seurat v4.4.0, Signac v1.15.0, Hotspot v0.9.1,  clusterProfiler v4.14.0, MACS3 v3.0.3, HOMER v3.12, rGREAT v2.8.0, chromVAR v1.30.1, Scanpy v1.11.4, Cytoscape v3.10.3, Cicero v1.3.9, Monocle3 v1.4.26, DOSE v4.0.0
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

## Notes

1. **Path Configuration**: All paths in the scripts are placeholders and need to be modified according to your actual environment
2. **Data Format**: Scripts assume input data is in Cell Ranger standard output format
3. **Parameter Adjustment**: Clustering resolution, dimensionality reduction parameters, etc. need to be adjusted based on actual data
4. **Dependency Installation**: Ensure all R packages and system tools are properly installed
5. **Test Data**: https://zenodo.org/records/17606479

