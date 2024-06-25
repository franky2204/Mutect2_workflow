cwlVersion: v1.2
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: fpant/gatk
requirements:
  InitialWorkDirRequirement: 
    listing:
      - entry: $(inputs.vcf_uncompressed)
        writable: True

baseCommand: ["bgzip"]

inputs:
  vcf_uncompressed:
    type: File
    inputBinding:
      position: 1

outputs:
  bgzip_vcf:
    type: File
    outputBinding:
      glob: "*.vcf.gz"
