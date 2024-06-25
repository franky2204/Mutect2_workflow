#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}

hints:
  DockerRequirement:
    dockerPull: fpant/gatk 

baseCommand: ["bash", "/scripts/addOrReplace.sh"]

inputs:
  sam_input:
    type: File
    inputBinding:
      position: 1

outputs:
  sam_add:
    type: File
    outputBinding:
      glob: "*_add.sam"

    

 