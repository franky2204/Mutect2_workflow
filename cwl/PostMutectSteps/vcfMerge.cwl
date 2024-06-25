cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}

hints:
  DockerRequirement:
    dockerPull: fpant/gatk 

baseCommand: ["bash", "/scripts/vcfMerge.sh"]

inputs:
  tabix_vfc:  
    type: File[]
    inputBinding:
      position: 1
    secondaryFiles:
      - .tbi

outputs:
  vcf_merged:
    type: File
    outputBinding:
      glob: "fusion.vcf"



