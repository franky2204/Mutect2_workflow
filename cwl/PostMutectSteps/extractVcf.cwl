cwlVersion: v1.2
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: fpant/gatk

requirements:
  InitialWorkDirRequirement: 
    listing:
      - entry: $(inputs.mutect_vcf)
        writable: True

baseCommand: ["gzip", "-d"]

inputs:
  mutect_vcf:
    type: File
    inputBinding:
      position: 1
      
outputs:
  vcf_uncompressed:
    type: File
    outputBinding:
      glob: "*.vcf"
