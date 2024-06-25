cwlVersion: v1.2
class: CommandLineTool

requirements:
  InitialWorkDirRequirement:
    listing: [ $(inputs.bam_sorted) ]

hints:
  DockerRequirement:
    dockerPull: fpant/gatk
  ResourceRequirement:
    coresMax: $(inputs.threads)

baseCommand: ["samtools", "index"]

inputs:
  bam_sorted:
    type: File
    inputBinding:
      position: 1
      prefix: "-b" 
  threads:
    type: int?
    inputBinding:
      position: 2
      prefix: "-@"   
outputs:
  bam_indexed:
    type: File
    outputBinding:
      glob: "*.bam"
    secondaryFiles:
      - .bai


