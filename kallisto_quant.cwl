{
  "arguments": [
    {
      "position": 1, 
      "prefix": "-o", 
      "separate": true, 
      "valueFrom": "."
    }, 
    {
      "position": 99, 
      "separate": false, 
      "valueFrom": {
        "class": "Expression", 
        "engine": "#cwl-js-engine", 
        "script": "\"&& rename 's/^/\" + ($job.inputs.output_prefix || $job.inputs.fastq1.path.split('/').pop().split('.')[0]) + \"_/' abundance* && rename 's/^/\" + ($job.inputs.output_prefix || $job.inputs.fastq1.path.split('/').pop().split('.')[0]) + \"_/' run_info*\"\n"
      }
    }
  ], 
  "baseCommand": [
    "kallisto", 
    "quant"
  ], 
  "class": "CommandLineTool", 
  "description": "kallisto quant for kallisto v0.43.0", 
  "hints": [
    {
      "class": "sbg:CPURequirement", 
      "value": {
        "class": "Expression", 
        "engine": "#cwl-js-engine", 
        "script": "$job.inputs.threads"
      }
    }, 
    {
      "class": "sbg:MemRequirement", 
      "value": 1000
    }, 
    {
      "class": "DockerRequirement", 
      "dockerImageId": "", 
      "dockerPull": "cgc-images.sbgenomics.com/gauravcgc/kallisto:latest"
    }
  ], 
  "id": "-", 
  "inputs": [
    {
      "description": "Input index file made from a transcripts fasta by kallisto quant", 
      "id": "#index", 
      "inputBinding": {
        "position": 0, 
        "prefix": "-i", 
        "sbg:cmdInclude": true, 
        "separate": true
      }, 
      "label": "Index File", 
      "sbg:category": "Input", 
      "sbg:fileTypes": "TXT, INDEX", 
      "type": [
        "File"
      ]
    }, 
    {
      "description": "Perform sequence based bias correction", 
      "id": "#bias", 
      "inputBinding": {
        "position": 2, 
        "prefix": "--bias", 
        "sbg:cmdInclude": true, 
        "separate": false
      }, 
      "label": "Bias", 
      "sbg:category": "Optional", 
      "sbg:toolDefaultValue": "False", 
      "type": [
        "null", 
        "boolean"
      ]
    }, 
    {
      "description": "Number of bootstrap samples", 
      "id": "#bootstrap", 
      "inputBinding": {
        "position": 2, 
        "prefix": "-b", 
        "sbg:cmdInclude": true, 
        "separate": true
      }, 
      "label": "Bootstrap Samples", 
      "sbg:category": "Optional", 
      "sbg:toolDefaultValue": "0", 
      "type": [
        "null", 
        "int"
      ]
    }, 
    {
      "description": "Seed for the bootstrap sampling", 
      "id": "#seed", 
      "inputBinding": {
        "position": 2, 
        "prefix": "--seed=", 
        "sbg:cmdInclude": true, 
        "separate": false
      }, 
      "label": "Seed", 
      "sbg:category": "Optional", 
      "sbg:toolDefaultValue": "42", 
      "type": [
        "null", 
        "int"
      ]
    }, 
    {
      "description": "Output plaintext only (no H5)", 
      "id": "#plaintext", 
      "inputBinding": {
        "position": 2, 
        "prefix": "--plaintext", 
        "sbg:cmdInclude": true, 
        "separate": false
      }, 
      "label": "Plaintext Output", 
      "sbg:category": "Optional", 
      "sbg:toolDefaultValue": "False", 
      "type": [
        "null", 
        "boolean"
      ]
    }, 
    {
      "description": "Quantify single-end reads", 
      "id": "#single", 
      "inputBinding": {
        "position": 2, 
        "prefix": "--single", 
        "sbg:cmdInclude": true, 
        "separate": false
      }, 
      "label": "Singe-End Reads", 
      "sbg:category": "Single", 
      "sbg:toolDefaultValue": "False", 
      "type": [
        "null", 
        "boolean"
      ]
    }, 
    {
      "description": "Strand specific reads, first read forward", 
      "id": "#fr_stranded", 
      "inputBinding": {
        "position": 2, 
        "prefix": "--fr-stranded", 
        "sbg:cmdInclude": true, 
        "separate": false
      }, 
      "label": "First Read Forward", 
      "sbg:category": "Optional", 
      "sbg:toolDefaultValue": "False", 
      "type": [
        "null", 
        "boolean"
      ]
    }, 
    {
      "description": "Strand specific reads, first read reverse", 
      "id": "#rf_stranded", 
      "inputBinding": {
        "position": 2, 
        "prefix": "--rf-stranded", 
        "sbg:cmdInclude": true, 
        "separate": false
      }, 
      "label": "First Read Reverse", 
      "sbg:category": "Optional", 
      "sbg:toolDefaultValue": "False", 
      "type": [
        "null", 
        "boolean"
      ]
    }, 
    {
      "description": "Estimated average fragment length (required if Single)", 
      "id": "#fraglength_mean", 
      "inputBinding": {
        "position": 2, 
        "sbg:cmdInclude": true, 
        "separate": false, 
        "valueFrom": {
          "class": "Expression", 
          "engine": "#cwl-js-engine", 
          "script": "if ($job.inputs.single) {'-l ' + $job.inputs.fraglength_mean}"
        }
      }, 
      "label": "Fragment Length", 
      "sbg:category": "Single", 
      "sbg:toolDefaultValue": "None", 
      "type": [
        "null", 
        "float"
      ]
    }, 
    {
      "description": "Estimated standard deviation of fragment length (Required if Single)", 
      "id": "#fraglength_std", 
      "inputBinding": {
        "position": 2, 
        "sbg:cmdInclude": true, 
        "separate": false, 
        "valueFrom": {
          "class": "Expression", 
          "engine": "#cwl-js-engine", 
          "script": "if ($job.inputs.single) {'-s ' + $job.inputs.fraglength_std}"
        }
      }, 
      "label": "Fragment Length Stdev", 
      "sbg:category": "Single", 
      "sbg:toolDefaultValue": "None", 
      "type": [
        "null", 
        "float"
      ]
    }, 
    {
      "description": "Numbers of threads (Note: if using pseudobam, this will be overriden to equal 1)", 
      "id": "#threads", 
      "inputBinding": {
        "position": 2, 
        "prefix": "-t", 
        "sbg:cmdInclude": true, 
        "separate": true, 
        "valueFrom": {
          "class": "Expression", 
          "engine": "#cwl-js-engine", 
          "script": "if ($job.inputs.pseudobam) {\n  1\n} else {\n  $job.inputs.threads\n}"
        }
      }, 
      "label": "Threads", 
      "sbg:category": "Optional", 
      "sbg:toolDefaultValue": "1", 
      "type": [
        "null", 
        "int"
      ]
    }, 
    {
      "description": "Output pseudoalignments in SAM format to stdout", 
      "id": "#pseudobam", 
      "inputBinding": {
        "position": 2, 
        "prefix": "--pseudobam", 
        "sbg:cmdInclude": true, 
        "separate": false
      }, 
      "label": "SAM Output", 
      "sbg:category": "Pseudobam", 
      "sbg:toolDefaultValue": "False", 
      "type": [
        "null", 
        "boolean"
      ]
    }, 
    {
      "description": "Filename for output pseudobam file (ext: SAM)", 
      "id": "#pseudobam_filename", 
      "label": "Pseudobam SAM Filename", 
      "sbg:category": "Pseudobam", 
      "sbg:toolDefaultValue": "pseudobam.sam", 
      "type": [
        "null", 
        "string"
      ]
    }, 
    {
      "description": "Input FASTQ file 1", 
      "id": "#TUMOR_FASTQ_1", 
      "inputBinding": {
        "position": 3, 
        "sbg:cmdInclude": true, 
        "separate": false
      }, 
      "label": "TUMOR_FASTQ_1", 
      "sbg:category": "FASTQ", 
      "sbg:fileTypes": "FASTQ, FQ, FASTQ.GZ, FQ.GZ", 
      "type": [
        "File"
      ]
    }, 
    {
      "description": "Input FASTQ 2", 
      "id": "#TUMOR_FASTQ_2", 
      "inputBinding": {
        "position": 3, 
        "sbg:cmdInclude": true, 
        "separate": false
      }, 
      "label": "TUMOR_FASTQ_2", 
      "sbg:category": "FASTQ", 
      "sbg:fileTypes": "FASTQ, FQ, FASTQ.GZ, FQ.GZ", 
      "type": [
        "null", 
        "File"
      ]
    }, 
    {
      "description": "Specify prefix for output filenames", 
      "id": "#output_prefix", 
      "label": "Output Filename Prefix", 
      "sbg:category": "Output", 
      "sbg:toolDefaultValue": "Uses FASTQ1 basename if none specified", 
      "type": [
        "null", 
        "string"
      ]
    }, 
    {
      "description": "Determine whether to save the Run JSON", 
      "id": "#save_json", 
      "label": "Save Run JSON", 
      "sbg:category": "Output", 
      "sbg:stageInput": null, 
      "sbg:toolDefaultValue": "False", 
      "type": [
        "null", 
        "boolean"
      ]
    }
  ], 
  "label": "kallisto-quant", 
  "outputs": [
    {
      "description": "Run Info JSON", 
      "id": "#json", 
      "label": "JSON", 
      "outputBinding": {
        "glob": {
          "class": "Expression", 
          "engine": "#cwl-js-engine", 
          "script": "if ($job.inputs.save_json) { '*run_info.json' } "
        }, 
        "sbg:inheritMetadataFrom": "#fastq1"
      }, 
      "sbg:fileTypes": "JSON", 
      "type": [
        "null", 
        "File"
      ]
    }, 
    {
      "description": "Abundances in h5 format", 
      "id": "#abundance_h5", 
      "label": "Abundance H5", 
      "outputBinding": {
        "glob": {
          "class": "Expression", 
          "engine": "#cwl-js-engine", 
          "script": "if ($job.inputs.plaintext==false) { '*abundance.h5' } "
        }, 
        "sbg:inheritMetadataFrom": "#fastq1"
      }, 
      "sbg:fileTypes": "H5", 
      "type": [
        "null", 
        "File"
      ]
    }, 
    {
      "description": "Abundance by gene in TSV format", 
      "id": "#abundance_tsv", 
      "label": "Abundance TSV", 
      "outputBinding": {
        "glob": "*abundance.tsv", 
        "sbg:inheritMetadataFrom": "#fastq1"
      }, 
      "sbg:fileTypes": "TSV", 
      "type": [
        "File"
      ]
    }, 
    {
      "description": "Pseudobam file output if true", 
      "id": "#sam", 
      "label": "SAM", 
      "outputBinding": {
        "glob": {
          "class": "Expression", 
          "engine": "#cwl-js-engine", 
          "script": "if ($job.inputs.pseudobam) { '*.sam' }"
        }, 
        "sbg:inheritMetadataFrom": "#fastq1"
      }, 
      "sbg:fileTypes": "SAM", 
      "type": [
        "null", 
        "File"
      ]
    }
  ], 
  "requirements": [
    {
      "class": "ExpressionEngineRequirement", 
      "id": "#cwl-js-engine", 
      "requirements": [
        {
          "class": "DockerRequirement", 
          "dockerPull": "rabix/js-engine"
        }
      ]
    }
  ], 
  "sbg:categories": [
    "RNA"
  ], 
  "sbg:id": "gauravCGC/kallisto-dream/kallisto-quant/1", 
  "sbg:toolAuthor": "Bray, N. L., Pimentel, H., Melsted, P. & Pachter, L.", 
  "sbg:toolkit": "kallisto", 
  "stdin": "", 
  "stdout": {
    "class": "Expression", 
    "engine": "#cwl-js-engine", 
    "script": "if ($job.inputs.pseudobam) { \n  ($job.inputs.pseudobam_filename.split('.')[0] || 'pseudobam') + '.sam' \n}"
  }, 
  "successCodes": [], 
  "temporaryFailCodes": []
}
