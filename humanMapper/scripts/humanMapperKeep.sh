file=$1
index=$3
threads=$4
file_fullname=$(basename $file)
file_name=$(echo ${file_fullname} | cut -d'.' -f1) #file name without extension
patient=$(echo ${file_name} | cut -d'_' -f1)
index_fullname=$(basename $index)
name_index="_${index_fullname%.*}"
output_file="$patient$name_index"

time {
	bwa mem -t $threads $index $1 $2 > ${output_file}_pe.sam
    samtools fastq -F 4 -f 8 -@ $threads ${output_file}_pe.sam > ${output_file}_mapped.fastq
	python3 /scripts/divide_fastq.py ${output_file}_mapped.fastq ${output_file}_mapped_R1.fastq ${output_file}_mapped_R2.fastq

	pigz -p $threads ${output_file}_mapped_R1.fastq

	pigz -p $threads ${output_file}_mapped_R2.fastq
}