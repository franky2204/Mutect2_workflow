#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}

inputs:
  bam_index:  
    type:
      type: array
      items: File
    secondaryFiles:
        - .bai
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
  threads: int?
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
 gatk_run:
    run: cwl/Mutect2.cwl
    in:
        bam_index: bam_index
        genome: genome
        threads: threads
    out: [mutect_vcf, mutect_vcf_stats, mutect_gz_tbi]