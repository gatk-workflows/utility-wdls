version 1.0 
## Copyright Broad Institute, 2020
##
## Creates a text file listing the file paths provided as input. 
##
## Requirements/expectations :
## - An array of file paths
##
## Outputs :
## - Text file listing the file paths
##
## Cromwell version support
## - Successfully tested on v53

workflow make_fofn {
    input {
        Array[String] input_files
        String fofn_name
    }
    
    call CreateFoFN {
        input :
            input_files = input_files,
            fofn_name = fofn_name
    }
    output {
        File fofn_list = CreateFoFN.fofn_list
    }
}

task CreateFoFN {
    input {
        # Command parameters
        Array[String] input_files
        String fofn_name
    }
    command {
        echo "~{sep='\n' input_files}" >> ~{fofn_name}.list
    }
    output {
        File fofn_list = "~{fofn_name}.list"
    }
    runtime {
        docker: "ubuntu:latest"
    }
}
