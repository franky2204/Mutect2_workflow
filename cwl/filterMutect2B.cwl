cwlVersion: v1.2
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: fpant/gatk

baseCommand: ["bash", "/scripts/filterMutect.sh"]

inputs:
  mutect_vcf:
    type: File
    inputBinding:
      position: 1
outputs:
  vcf_filtered:
    type: File
    outputBinding:
      glob: "*_filtered.vcf"