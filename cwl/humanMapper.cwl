#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing: [ $(inputs.index)]
hints:
  ResourceRequirement:
    coresMax: $(inputs.threads)
  DockerRequirement:
    dockerPull: fpant/humanmapper 

baseCommand: ["bash", "/scripts/humanMapperKeep.sh"]

inputs: 
  read_1:
    type: File
    inputBinding:
      position: 1
  read_2:
    type: File
    inputBinding:
      position: 2
  index:
    doc: "Index used as reference"
    type: File
    inputBinding: 
      position: 3 
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
  threads:
    doc: "Maximum number of compute threads"
    type: int?
    default: 1
    inputBinding:
      position: 4


outputs:
  mapped_R1:
    type: File
    outputBinding:
      glob: "*_mapped_R1.fastq.gz"
  mapped_R2:
    type: File
    outputBinding:
      glob: "*_mapped_R2.fastq.gz"
