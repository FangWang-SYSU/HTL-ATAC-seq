# AS240722

sample_id='AS240722'
batch='S1'

scripts_dir=/ATACseq/scripts
index_file=${scripts_dir}/barcode.txt

all_fastq=/ATACseq/fastq/
fastq_dir=${all_fastq}/${sample_id}/${sample_id}_${batch}/Original/
split_dir=${all_fastq}/${sample_id}/${sample_id}_${batch}/Split/

output_res=${all_fastq}/${sample_id}/${sample_id}

cellranger_outdir=/ATACseq/CellRangerOutput/${sample_id}


if [ ! -d $fastq_dir ]; then
   mkdir -p $fastq_dir
   echo create file $fastq_dir > log
fi

ln ${all_fastq}/${sample_id}/Sample_AS240722_combined_R1.fastq.gz ${fastq_dir}/sampleName_S1_L001_R1_001.fastq.gz
ln ${all_fastq}/${sample_id}/Sample_AS240722_combined_R2.fastq.gz ${fastq_dir}/sampleName_S1_L001_I2_001.fastq.gz
ln ${all_fastq}/${sample_id}/Sample_AS240722_combined_R3.fastq.gz ${fastq_dir}/sampleName_S1_L001_R2_001.fastq.gz
ln ${all_fastq}/${sample_id}/Sample_AS240722_combined_R1.fastq.gz ${fastq_dir}/sampleName_S1_L002_R1_001.fastq.gz
ln ${all_fastq}/${sample_id}/Sample_AS240722_combined_R2.fastq.gz ${fastq_dir}/sampleName_S1_L002_I2_001.fastq.gz
ln ${all_fastq}/${sample_id}/Sample_AS240722_combined_R3.fastq.gz ${fastq_dir}/sampleName_S1_L002_R2_001.fastq.gz
ln ${all_fastq}/${sample_id}/Sample_AS240722_combined_R1.fastq.gz ${fastq_dir}/sampleName_S1_L003_R1_001.fastq.gz
ln ${all_fastq}/${sample_id}/Sample_AS240722_combined_R2.fastq.gz ${fastq_dir}/sampleName_S1_L003_I2_001.fastq.gz
ln ${all_fastq}/${sample_id}/Sample_AS240722_combined_R3.fastq.gz ${fastq_dir}/sampleName_S1_L003_R2_001.fastq.gz
ln ${all_fastq}/${sample_id}/Sample_AS240722_combined_R1.fastq.gz ${fastq_dir}/sampleName_S1_L004_R1_001.fastq.gz
ln ${all_fastq}/${sample_id}/Sample_AS240722_combined_R2.fastq.gz ${fastq_dir}/sampleName_S1_L004_I2_001.fastq.gz
ln ${all_fastq}/${sample_id}/Sample_AS240722_combined_R3.fastq.gz ${fastq_dir}/sampleName_S1_L004_R2_001.fastq.gz
# 
echo 'run l001' > log
nohup bash ${scripts_dir}/PruneFastq_byLane.sh \
	${fastq_dir} \
	${split_dir} \
	${batch} \
	L001 \
	${index_file}  > L001_${batch}.txt &

echo 'run l002' >> log
nohup bash ${scripts_dir}/PruneFastq_byLane.sh \
	${fastq_dir} \
	${split_dir} \
	${batch}  \
	L002 \
	${index_file}  > L002_${batch}.txt &

echo 'run l003' >> log
nohup bash ${scripts_dir}/PruneFastq_byLane.sh \
	${fastq_dir} \
	${split_dir} \
	${batch}  \
	L003 \
	${index_file}  > L003_${batch}.txt &

sleep 60m

echo 'run cellranger' >> log
nohup bash ${scripts_dir}/runCellranger.sh \
	${fastq_dir} \
	${split_dir} \
	${batch} \
	L004 \
	${index_file} \
	${output_res} \
	${sample_id}_${batch} \
	${cellranger_outdir}/${batch} > L004_${batch}.txt &



ps -def | grep 'run'

