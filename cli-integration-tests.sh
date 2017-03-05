#!/bin/bash

function print_success {
  echo `tput setaf 2`$1`tput sgr0`
}

function print_error {
  echo `tput setaf 1`$1`tput sgr0`
}

function escape_string {
    echo $1 | sed 's/\"/\\"/g' | sed 's/\[/\\[/g' | sed 's/\]/\\]/g'
}

function skip_it {
  echo $1
  echo "--> "$2
  ((SKIPPED_COUNT++))
  echo "SKIPPED"
  echo
}

function it {
  echo $1
  echo "--> CMD: "$2
  
  EXEC_CODE=0
  if [ -z "$3" ]; then
    $2
    EXEC_CODE=$?
  else
    echo "--> EXP: "$3
    EXEC_RESULT=`$2`
    echo $EXEC_RESULT
    EXEC_CODE=$?
    if ! ((EXEC_CODE)); then
      echo $EXEC_RESULT | grep -q "$3"
      EXEC_CODE=$?
      if ((EXEC_CODE)); then
        print_error "Pattern $3 not found"
      fi
    fi
  fi
  
  if ! ((EXEC_CODE)); then
    ((PASSED_COUNT++))
    print_success PASSED
  else
    ((FAILED_COUNT++))
    print_error FAILED
  fi
  
  echo
}  

export -f skip_it
export -f it

#-------------INIT VARIABLES-------------

# General
export FAILED_COUNT=0
export PASSED_COUNT=0
export SKIPPED_COUNT=0
export NGS_FOLDER=ngs/
export CLI_FOLDER=${NGS_FOLDER}ngb-cli/bin/

# Reference
export REFERENCE_NAME=ref
export FASTA=${NGS_FOLDER}dmel-all-chromosome-r6.06.fasta
export FASTA_INDEX=${NGS_FOLDER}dmel-all-chromosome-r6.06.fasta.fai
export FASTA_NO_EXT="$(basename "$FASTA" | sed -e 's/\.[^.]*$//')"
export CHR=X

# Datasets
export DATASET_ROOT=root_dataset
export DATASET_CHILD=child_dataset

# Files
export GTF=${NGS_FOLDER}dmel-all-r6.06.sorted.gtf.gz
export GTF_INDEX=${NGS_FOLDER}dmel-all-r6.06.sorted.gtf.gz.tbi
export GTF_NAME=genes_file

export BAM=${NGS_FOLDER}agnX1.09-28.trim.dm606.realign.bam
export BAM_INDEX=${NGS_FOLDER}agnX1.09-28.trim.dm606.realign.bai
export BAM_NAME=bam_file

export VCF_SNP=${NGS_FOLDER}agnX1.09-28.trim.dm606.realign.vcf
export VCF_SNP_NAME=vcf_file

#-----------------INIT WORKING DIRECTORY------------------

# Create integration tests working directory
echo 'mkdir ${NGS_FOLDER} && cd ${NGS_FOLDER}'
mkdir ${NGS_FOLDER} && cd ${NGS_FOLDER}
export PATH=$CLI_FOLDER:$PATH

# Temporary staff
echo 'TEST: Download distr'
wget http://ngb.opensource.epam.com/distr/2.3/catgenome-2.3.jar
wget http://ngb.opensource.epam.com/distr/2.3/ngb-cli-2.3.tar.gz
#Rename NGB distr as normally build
echo 'mv catgenome-2.3.jar catgenome.jar'
mv catgenome-2.3.jar catgenome.jar
# Unzip CLI
echo 'tar -zxvf ngb-cli-2.3.tar.gz'
tar -zxvf ngb-cli-2.3.tar.gz

#-----------------DOWNLOAD TEST DATA------------------

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

#-------------------RUN SCENARIOS-------------------

cd ..

for file in scenarios/test-*.sh
do
    if [[ -f $file ]]; then
        echo SCENARIO: $file
        /bin/bash $file
    fi
done

#-------------------PRINT RESULTS-------------------

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
