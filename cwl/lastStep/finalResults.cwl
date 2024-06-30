cwlVersion: v1.2
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: fpant/gatk

baseCommand: ["python", "/scripts/exodia.py"]

inputs:
  daniela:
    type: File
    inputBinding:
      position: 1
  human_grch38:
    type: File
    inputBinding:
      position: 2

outputs:
  results:
    type: File
    outputBinding:
      glob: "results.tsv"
  results_trascript:
    type: File
    outputBinding: 
      glob: "results_transcript.tsv"