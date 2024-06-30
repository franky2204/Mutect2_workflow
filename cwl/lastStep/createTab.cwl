cwlVersion: v1.2
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: fpant/gatk

baseCommand: ["python", "/scripts/first_step.py"]

inputs:
  mutect_tsv:
    type: File
    inputBinding:
      position: 1

outputs:
  daniela:
    type: File
    outputBinding:
      glob: "daniela.tsv"