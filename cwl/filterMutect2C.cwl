cwlVersion: v1.2
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: fpant/gatk

baseCommand: ["bcftools", "view", "-i", "DP>20"]

inputs:
  mutect_vcf:
    type: File
    inputBinding:
      position: 1

outputs:
  vcf_filtered:
    type: File
    outputBinding:
      glob: filtered_res.vcf

stdout: filtered_res.vcf
