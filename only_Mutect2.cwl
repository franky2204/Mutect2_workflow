#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}
  ScatterFeatureRequirement: {}

inputs:
  fastq_directory: Directory
  threads: int?
  index:
    type: File
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .fai
      - .pac
      - .sa
  genome: 
    type: File
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
      - .fai
      - ^.dict


outputs:
  mutect_vcf:
    type: File
    outputSource: gatk_run/mutect_vcf
  mutect_vcf_stats:
    type: File
    outputSource: gatk_run/mutect_vcf_stats
  mutect_gz_tbi:
    type: File
    outputSource: gatk_run/mutect_gz_tbi


steps:
  check-input:
    run: cwl/checkInput.cwl
    in:
      fastq_directory: fastq_directory
    out: [read_1, read_2]
  humanmapper:
    run: cwl/humanMapper.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: check-input/read_1
      read_2: check-input/read_2
      index: index
      threads: threads
    out: [mapped_R1, mapped_R2]
  from_fastq_to_sam:
    run: cwl/fromFastqToSam.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: humanmapper/mapped_R1
      read_2: humanmapper/mapped_R2
      genome: genome
      threads: threads
    out: [sam_input]
  pre_mutect2:
    run: cwl/S2PMutect2.cwl
    scatter: [sam_input]
    in:
      sam_input: from_fastq_to_sam/sam_input
      threads: threads
    out: [bam_indexed]
  gatk_run:
    run: cwl/Mutect2v2.cwl
    in:
      bam_index: pre_mutect2/bam_indexed
      genome: genome
      threads: threads
    out: [mutect_vcf, mutect_vcf_stats, mutect_gz_tbi]



