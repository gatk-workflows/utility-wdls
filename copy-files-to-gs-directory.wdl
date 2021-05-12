version 1.0
## Copyright Broad Institute, 2020
## Purpose: 
## This WDL workflow copies an array of files from a gs bucket to another specfied gs bucket
##
## Requirements/expectations :
## - Array[String] files_2_copy = Files to copy
## - String output_gs_dir = Directory to copy files to
##
## Outputs :
## -  File output_text_file = The bash script used to copy files
## -  Array[String] new_file_paths = Files contained in the output bucket
##
## Cromwell version support 
## - Successfully tested on v53
##
## Runtime parameters are optimized for Broad's Google Cloud Platform implementation.
##
## LICENSING : 
## This script is released under the WDL source code license (BSD-3) (see LICENSE in 
## https://github.com/broadinstitute/wdl). Note however that the programs it calls may 
## be subject to different licenses. Users are responsible for checking that they are
## authorized to run all programs before running this script. Please see the dockers
## for detailed licensing information pertaining to the included programs.

workflow CopyFiles2Directory{
    input{
      Array[String] files_2_copy
      String output_gs_dir
      String dir_name = ""
    }
    
    Boolean add_dir_name = dir_name!=""
    
    String dir_name_slash = if add_dir_name then dir_name + "/" else dir_name
    
call copyFile{
    input:
      files_2_copy = files_2_copy,
      output_gs_dir = output_gs_dir + dir_name_slash
}
output{
    File output_text_file = copyFile.output_text_file
    Array[String] new_file_paths = copyFile.new_file_paths
    }
}

task copyFile{
    input{
      Array[String] files_2_copy
      String output_gs_dir
    }
    
    command<<<
        set -eo pipefail

        # Create a file with each line as the file to copy
        cp ~{write_lines(files_2_copy)} list_of_files.txt
        # Add gs copy command to the begining of each line
        sed -i -e 's|^|gsutil cp |' list_of_files.txt
        # Add directory to copy files to
        sed -i -e 's|$| ~{output_gs_dir}|' list_of_files.txt
        
        # Convert text file to executable
        cp list_of_files.txt list_of_files.sh
        
        source list_of_files.sh

        gsutil ls ~{output_gs_dir} >> new_file_paths.txt
    >>>
    output{
        File output_text_file = "list_of_files.txt"
        Array[String] new_file_paths = read_lines("new_file_paths.txt")
    }
    runtime {
        docker: "gcr.io/google.com/cloudsdktool/cloud-sdk:latest"
    }
}

