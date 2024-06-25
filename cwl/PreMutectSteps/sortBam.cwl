cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
  
hints:
  DockerRequirement:
    dockerPull: fpant/gatk
  ResourceRequirement:
    coresMax: $(inputs.threads)

baseCommand: ["samtools", "sort"]


inputs:  
  threads: 
    type: int?
    default: 2
    inputBinding:
      position: 1
      prefix: '-@'
  bam_output:
    type: File
    inputBinding:
      position: 2
  output: 
    type: string?
    default: "file_add_sort.bam"
    inputBinding:
      position: 3
      prefix: -o

     
outputs:
  bam_sorted:
    type: File
    outputBinding:
      glob: "file_add_sort.bam"
      outputEval: ${
        self[0].basename = inputs.bam_output.nameroot + "_sort.bam";
        return self; }  
