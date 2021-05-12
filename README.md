# utility-wdls
Short workflows to run common tasks.

## make-fofn 
### Purpose :
Creates a text file listing the file paths provided as input. 

### Requirements/expectations :
 - An array of file paths.

### Output :
 - A file containing a list of file paths.

## generate-sample-map
### Purpose:
Generate a sample_map file, which can be used for JointGenotyping workflow.

### Requirements/expectations :
 - An array of file paths
 - An array of file names
 - Name of output sample_map

### Outputs :
 - sample map file

## copy-files-to-directory
### Purpose: 
This workflow copies an array of files from a gs bucket to another specfied gs bucket

### Requirements/expectations :
 - Array[String] files_2_copy = Files to copy
 - String output_gs_dir = Directory to copy files to

### Outputs :
 -  File output_text_file = The bash script used to copy files
 -  Array[String] new_file_paths = Files contained in the output bucket

---

### Software version notes :
- Cromwell version support 
  - Successfully tested on v53 

### Important Notes :
- Runtime parameters are optimized for Broad's Google Cloud Platform implementation.
- The provided JSON is a generic ready to use example template for the workflow. It is the user’s responsibility to correctly set the reference and resource variables for their own particular test case using the [GATK Tool and Tutorial Documentations](https://gatk.broadinstitute.org/hc/en-us/categories/360002310591).
- For help running workflows on the Google Cloud Platform or locally, please
view the following tutorial [(How to) Execute Workflows from the gatk-workflows Git Organization](https://gatk.broadinstitute.org/hc/en-us/articles/360035530952).
- Relevant reference and resources bundles can be accessed in [Resource Bundle](https://gatk.broadinstitute.org/hc/en-us/articles/360035890811).

### Contact Us :
- The following material is provided by the Data Sciences Platform group at the Broad Institute. Please direct any questions or concerns to one of our forum sites : [GATK](https://gatk.broadinstitute.org/hc/en-us/community/topics) or [Terra](https://support.terra.bio/hc/en-us/community/topics/360000500432).

### LICENSING :
Copyright Broad Institute, 2019 | BSD-3

This script is released under the [WDL open source code license](https://github.com/openwdl/wdl/blob/master/LICENSE) (BSD-3). Note however that the programs it calls may be subject to different licenses. Users are responsible for checking that they are authorized to run all programs before running this script.
