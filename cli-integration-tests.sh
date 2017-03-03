#-------------INIT VARIABLES-------------

# General
NGS_FOLDER=/ngs/
CLI_FOLDER=${NGS_FOLDER}ngb-cli/bin

# Reference
REFERENCE_NAME=ref
REFERENCE_NAME_GENES=ref_genes
FASTA=${NGS_FOLDER}dmel-all-chromosome-r6.06.fasta
FASTA_NO_EXT=$(basename "$FASTA" | cut -d. -f1)

# Datasets

# Files
GTF=${NGS_FOLDER}dmel-all-r6.06.sorted.gtf.gz
GTF_INDEX=${NGS_FOLDER}dmel-all-r6.06.sorted.gtf.gz.tbi

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

# Reference commands
echo 'Reference commands'
echo '--------'

## reg_ref
echo 'Should register reference with default name'
./ngb reg_ref ${FASTA} && echo 'PASSED' && echo

## reg_ref -n
echo 'Should register reference with explicit name'
./ngb reg_ref ${FASTA} --name ${REFERENCE_NAME} && echo 'PASSED' && echo

## reg_ref -g
echo 'Should register reference with explicit name and genes file'
./ngb reg_ref ${FASTA} --name ${REFERENCE_NAME} --genes ${GTF}?${GTF_INDEX} && echo 'PASSED' && echo

## list_ref
## <TODO>

## del_ref
echo 'Should delete reference with default name'
./ngb del_ref ${FASTA_NO_EXT} && echo 'PASSED' && echo

echo 'Should delete reference with explicit name'
./ngb del_ref ${REFERENCE_NAME} && echo 'PASSED' && echo

## add_genes
## <TODO>

## remove_genes
## <TODO>

# Datasets commands

## reg_dataset
## <TODO>

## reg_dataset -p
## <TODO>

## reg_dataset [file-names]
## <TODO>

## add_dataset
## <TODO>

## remove_dataset
## <TODO>

## move_dataset
## <TODO>

## list_dataset -p
## <TODO>

## del_dataset
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
echo 'General commands'
echo '--------'

## set_srv
echo 'Should allow to configure NGB server address'
./ngb set_srv http://localhost:8080/catgenome && echo 'PASSED' && echo

## search
## <TODO>

## search -l
## <TODO>
