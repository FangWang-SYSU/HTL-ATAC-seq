#!/bin/bash
echo Prune
InputFastq=$1
OutputFastq=$2
All=$OutputFastq/All
mkdir -p $All

Time=$3
Lane=$4



echo "Step.3 Move unmatch or multimatch fastq out"
Unmatched=$SplitFile/Unmatched
Multimatched=$SplitFile/Multimatched
mkdir $Unmatched
mkdir $Multimatched

cd $SplitFile
for Lane in L001 L002 L003 L004
do
   cd $SplitFile/$Lane
   mkdir $Unmatched/$Lane
   mkdir $Multimatched/$Lane
   for name in `ls  unmatched*`
   do
      mv $name $Unmatched/$Lane/$name
   done
   for name in `ls  multimatched*`
   do
      mv $name $Multimatched/$Lane/$name
   done
   echo "Step.4 pigz fastq to fastq.gz"
   echo "pigz: Parallel Implementation of GZip"
   cd ..
   pigz -r $Lane
   IndexFile=$SplitFile/IndexFile/$Lane
   mkdir -p $IndexFile
   

   echo "Step.5 Change fastq Name to standard format"
   cd $Lane
   for name in `ls *.fastq.gz`
   do 
      cellLine=${name%-read*}
      if [ ! -d $cellLine ]; then
         mkdir $cellLine
      fi
      Read=${name#*-read-}
      if [ $Read = '1.fastq.gz' ]; then
         newFile=sampleName_$Time'_'$Lane'_R1_001.fastq.gz'
         mv $name $cellLine/$newFile
      elif [ $Read = '2.fastq.gz' ]; then
         newFile=sampleName_$Time'_'$Lane'_I2_001.fastq.gz'
         mv $name $cellLine/$newFile
      elif [ $Read = '3.fastq.gz' ]; then
         newFile=sampleName_$Time'_'$Lane'_R2_001.fastq.gz'
         mv $name $cellLine/$newFile
      elif [ $Read = '4.fastq.gz' ] ; then
         newFile=$cellLine'_'$Time'_'$Lane'_Index_001.fastq.gz'
         mv $name $IndexFile/$newFile
      else 
         echo 'warning'
         fi
      done
done


datPath=$SplitFile
FinalFastq=$6
mkdir -p $FinalFastq
fileNameList=$datPath'/L001'
for name in `ls $fileNameList`
do
   filename=$name
   echo $filename
   mkdir -p $FinalFastq/$filename
   for Lane in L001 L002 L003 L004
   do
      ln $datPath/$Lane/$filename/* $FinalFastq/$filename/
   done
done

outputIDpre=$7
CellRangerOutput=$8
mkdir -p $CellRangerOutput
fastqsPath1=$FinalFastq

files=$(ls $fastqsPath1)
for filename in $files
do
   echo $filename
   fastqsPath2=$fastqsPath1/$filename
   outputID=$outputIDpre'_'$filename
   echo $outputID
   echo '##################################################################################################'
   echo "run cellranger"
   cd $CellRangerOutput
   /opt/cellranger-atac_Multi/bin/cellranger-atac count --id=$outputID \
                    --reference=/exdisk/ExprimentData/Reference/cellranger/refdata-cellranger-arc-mm10-2020-A-2.0.0 \
                    --fastqs=$fastqsPath2 \
                    --sample=sampleName \
                    --localcores=32 \
                    --localmem=256 \
                  --disable-ui   
   web_summary=/exdisk/ExprimentData/web_summary/ATAC/
   cp $CellRangerOutput/$outputID/outs/web_summary.html  $web_summary/$outputID'.html'
done
