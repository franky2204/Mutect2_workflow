#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing: [ $(inputs.genome)]

hints:
  ResourceRequirement:
    coresMax: $(inputs.threads)
  DockerRequirement:
    dockerPull: fpant/gatk 

baseCommand: ["bash", "/scripts/Mutect2.sh"]

inputs:
  bam_index:
    type: File []
    inputBinding:
      position: 3
    secondaryFiles:
      - .bai
  genome:
    doc: "genome in use"
    type: File
    inputBinding:
      position: 1
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
      - .fai
      - ^.dict
  threads:
    doc: "Max number of threads in use"
    type: int?
    default: 1
    inputBinding:
      position: 2
 

outputs:
  mutect_vcf:
    type: File
    outputBinding:
      glob: "Muteq_final_resoult.vcf.gz"
  mutect_vcf_stats:
    type: File
    outputBinding:
      glob: "Muteq_final_resoult.vcf.gz.stats"
  mutect_gz_tbi:
    type: File
    outputBinding:
      glob: "Muteq_final_resoult.vcf.gz.tbi"