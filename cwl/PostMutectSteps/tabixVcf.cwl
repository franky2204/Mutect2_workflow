cwlVersion: v1.2
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: fpant/gatk
requirements:
  InitialWorkDirRequirement: 
    listing:
      - entry: $(inputs.bgzip_vcf)
        writable: True

baseCommand: ["tabix", "-p", "vcf"]

inputs:
  bgzip_vcf:
    type: File
    inputBinding:
      position: 1

outputs:
  tabix_vfc:
    type: File
    outputBinding:
      glob: "*.gz"
    secondaryFiles:
      - .tbi