#!/bin/bash

function print_success {
  echo `tput setaf 2`$1`tput sgr0`
}

function print_error {
  echo `tput setaf 1`$1`tput sgr0`
}

function it {
  echo $1
  echo "--> "$2
  if [ -z "$3" ]; then
    if $2; then
      ((PASSED_COUNT++))
      print_success PASSED
    else
      ((FAILED_COUNT++))
      print_error FAILED
    fi
  else
    ((SKIPPED_COUNT++))
    echo "SKIPPED"
  fi
  
  echo
}  

#-------------INIT VARIABLES-------------

# General
FAILED_COUNT=0
PASSED_COUNT=0
SKIPPED_COUNT=0
NGS_FOLDER=/ngs/
CLI_FOLDER=${NGS_FOLDER}ngb-cli/bin

# Reference
REFERENCE_NAME=ref
FASTA=${NGS_FOLDER}dmel-all-chromosome-r6.06.fasta
FASTA_INDEX=${NGS_FOLDER}dmel-all-chromosome-r6.06.fasta.fai
FASTA_NO_EXT="$(basename "$FASTA" | sed -e 's/\.[^.]*$//')"

# Datasets
DATASET_ROOT=root_dataset
DATASET_CHILD=child_dataset

# Files
GTF=${NGS_FOLDER}dmel-all-r6.06.sorted.gtf.gz
GTF_INDEX=${NGS_FOLDER}dmel-all-r6.06.sorted.gtf.gz.tbi
GTF_NAME=genes_file

BAM=${NGS_FOLDER}agnX1.09-28.trim.dm606.realign.bam
BAM_INDEX=${NGS_FOLDER}agnX1.09-28.trim.dm606.realign.bai
BAM_NAME=bam_file

VCF_SNP=${NGS_FOLDER}agnX1.09-28.trim.dm606.realign.vcf
VCF_SNP_NAME=vcf_file

#-----------------INIT WORKING DIRECTORY------------------

# Create integration tests working directory
echo 'mkdir /${NGS_FOLDER} && cd /${NGS_FOLDER}'
mkdir /${NGS_FOLDER} && cd /${NGS_FOLDER}

echo 'TEST: Download distr'
wget http://ngb.opensource.epam.com/distr/2.3/catgenome-2.3.jar
wget http://ngb.opensource.epam.com/distr/2.3/ngb-cli-2.3.tar.gz
#Rename NGB distr as normally build
echo 'mv catgenome-2.3.jar catgenome.jar'
mv catgenome-2.3.jar catgenome.jar
# Unzip CLI
echo 'tar -zxvf ngb-cli-2.3.tar.gz'
tar -zxvf ngb-cli-2.3.tar.gz

echo 'TEST: Download data'
wget http://ngb.opensource.epam.com/distr/data/genome/dm6/dmel-all-chromosome-r6.06.fasta
wget http://ngb.opensource.epam.com/distr/data/genome/dm6/dmel-all-chromosome-r6.06.fasta.fai
wget http://ngb.opensource.epam.com/distr/data/genome/dm6/dmel-all-r6.06.sorted.gtf.gz
wget http://ngb.opensource.epam.com/distr/data/genome/dm6/dmel-all-r6.06.sorted.gtf.gz.tbi
wget http://ngb.opensource.epam.com/distr/data/demo/ngb_demo_data/agnX1.09-28.trim.dm606.realign.bam
wget http://ngb.opensource.epam.com/distr/data/demo/ngb_demo_data/agnX1.09-28.trim.dm606.realign.bai
wget http://ngb.opensource.epam.com/distr/data/demo/ngb_demo_data/agnX1.09-28.trim.dm606.realign.vcf

#-----------------INIT NGB AND CLI------------------
# Start NGB as a service
echo 'nohup java -Xmx3G -jar catgenome.jar &'
nohup java -Xmx3G -jar catgenome.jar &

# Give NGB time to start
echo 'sleep 30'
sleep 30

# Show start up log
echo 'cat nohup.out'
cat nohup.out

# Navigate to CLI command location
echo 'cd ${CLI_FOLDER}'
cd ${CLI_FOLDER}

#-----------------TESTS------------------
echo
echo Scenario 1. Simple Dataset. Registration phase
echo ------------------------------

it \
  "Should configure NGB server address" \
  "./ngb set_srv http://localhost:8080/catgenome"

it \
    "Should register reference with index and explicit name" \
    "./ngb reg_ref ${FASTA} --name ${REFERENCE_NAME}"

it \
    "Should register gzipped genes file with explicit name" \
    "./ngb reg_file ${REFERENCE_NAME} ${GTF}?${GTF_INDEX} --name ${GTF_NAME}"

it \
    "Should assign registered genes file to a reference by name" \
    "./ngb add_genes ${REFERENCE_NAME} ${GTF_NAME}"

it \
    "Should register root dataset for reference" \
    "./ngb reg_dataset ${REFERENCE_NAME} ${DATASET_ROOT}"

it \
    "Should register BAM file with explicit name" \
    "./ngb reg_file ${REFERENCE_NAME} ${BAM}?${BAM_INDEX} --name ${BAM_NAME}"

it \
    "Should add registered BAM file to root dataset" \
    "./ngb add_dataset ${DATASET_ROOT} ${BAM_NAME}"

it \
    "Should register VCF file with explicit name" \
    "./ngb reg_file ${REFERENCE_NAME} ${VCF_SNP} --name ${VCF_SNP_NAME}"

it \
    "Should add registered VCF file to root dataset" \
    "./ngb add_dataset ${DATASET_ROOT} ${VCF_SNP_NAME}"

echo
echo Scenario 1. Simple Dataset. Check phase - search registered items
echo ------------------------------

it \
    "Should list registered reference and output in a table format" \
    "./ngb list_ref -t"

it \
    "Should find registered reference by strict name and output in a table format" \
    "./ngb search ${REFERENCE_NAME} -t"

it \
    "Should list registered dataset and output in a table format" \
    "./ngb list_dataset -t"

it \
    "Should find registered GTF file by strict name and output in a table format" \
    "./ngb search ${GTF_NAME} -t"

it \
    "Should find registered BAM file by strict name and output in a table format" \
    "./ngb search ${BAM_NAME} -t"

it \
    "Should find registered VCF file by strict name and output in a table format" \
    "./ngb search ${VCF_SNP_NAME} -t"

echo
echo Scenario 1. Simple Dataset. Clean-up phase - delete registered items
echo ------------------------------

it \
    "Should remove BAM file from dataset" \
    "./ngb remove_dataset ${DATASET_ROOT} ${BAM_NAME}"

it \
    "Should remove VCF file from dataset" \
    "./ngb remove_dataset ${DATASET_ROOT} ${VCF_SNP_NAME}"

it \
    "Should delete root dataset" \
    "./ngb del_dataset ${DATASET_ROOT}"

it \
    "Should delete BAM file" \
    "./ngb del_file ${BAM_NAME}"

it \
    "Should delete VCF file" \
    "./ngb del_file ${VCF_SNP_NAME}"

it \
    "Should remove GTF file from reference" \
    "./ngb remove_genes ${REFERENCE_NAME}"

it \
    "Should delete GTF file" \
    "./ngb del_file ${GTF_NAME}"

it \
    "Should delete reference" \
    "./ngb del_ref ${REFERENCE_NAME}"

# Reference commands

## reg_ref
## <TODO>

## reg_ref -g
## <TODO>

## reg_ref -ngc
## <TODO>

## add_genes [file-paths]
## <TODO>

# Datasets commands

## reg_dataset -p
## <TODO>

## reg_dataset [file-names]
## <TODO>

## reg_dataset [file-paths]
## <TODO>

## add_dataset [file-paths]
## <TODO>

## move_dataset
## <TODO>

## list_dataset -p
## <TODO>

## url 
## <TODO>

## url -loc:chr
## <TODO>

## url -loc:chr:range
## <TODO>

## url -[file-names]
## <TODO>


# Files
## BAM

### reg_file
## <TODO>

### reg_file -n
## <TODO>

### reg_file -ni
## <TODO>

### del_file
## <TODO>

### index_file
## <TODO>

## CRAM
## <TODO>

## GFF
## <TODO>

## GTF
## <TODO>

## BED
## <TODO>

## VCF (SVs, SNPs, InDels)
## <TODO>

## BW
## <TODO>

## SEG
## <TODO>


# General commands

## set_srv
## <TODO>

## search
## <TODO>

## search -l
## <TODO>

# Tests results
echo TOTAL: $((PASSED_COUNT + FAILED_COUNT + SKIPPED_COUNT))
print_success "  PASSED: ${PASSED_COUNT}"
print_error "  FAILED: ${FAILED_COUNT}"
echo " SKIPPED: ${SKIPPED_COUNT}"

if ((FAILED_COUNT>0)); then
  exit 1
else
  exit 0
fi
