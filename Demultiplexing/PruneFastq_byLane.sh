#!/bin/bash
echo Prune
InputFastq=$1
OutputFastq=$2
All=$OutputFastq/All
mkdir -p $All

Time=$3
Lane=$4


echo 'Step.1: Prune'
seqtk trimfq $InputFastq/sampleName_$Time'_'$Lane'_R2_001.fastq.gz' -b 0 -e 144 | gzip -f > $OutputFastq/sampleName_$Time'_'$Lane'_Index_001.fastq.gz'
seqtk trimfq $InputFastq/sampleName_$Time'_'$Lane'_R2_001.fastq.gz' -b 25 -e 0 | gzip -f > $OutputFastq/All/sampleName_$Time'_'$Lane'_R2_001.fastq.gz'
ln $InputFastq/sampleName_$Time'_'$Lane'_R1_001.fastq.gz'  $OutputFastq/All/sampleName_$Time'_'$Lane'_R1_001.fastq.gz'
ln $InputFastq/sampleName_$Time'_'$Lane'_I2_001.fastq.gz'  $OutputFastq/All/sampleName_$Time'_'$Lane'_I2_001.fastq.gz' 
echo $Lane

echo 'Step.2: Split fastq base on Barcode'
BarcodeFile=$5
SplitFile=$OutputFastq/SplitFile/
mkdir -p $SplitFile
outPath=$SplitFile/$Lane
mkdir $outPath
cd $outPath
barcode_splitter --bcfile $BarcodeFile \
                          $OutputFastq/All/sampleName_$Time'_'$Lane'_R1_001.fastq.gz' \
                          $OutputFastq/All/sampleName_$Time'_'$Lane'_I2_001.fastq.gz' \
                             $OutputFastq/All/sampleName_$Time'_'$Lane'_R2_001.fastq.gz' \
                             $OutputFastq/sampleName_$Time'_'$Lane'_Index_001.fastq.gz'  \
                --split_all \
                --mismatches 1 \
                --idxread 4 \
                --suffix .fastq