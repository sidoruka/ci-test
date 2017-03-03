# Create integration tests working directory
echo 'mkdir /ngs && cd /ngs'
mkdir /ngs && cd /ngs

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
echo 'cd /ngs/ngb-cli/bin'
cd /ngs/ngb-cli/bin

#-----------------TESTS------------------

# General commands
echo 'General commands'
echo '--------'

## set_srv
echo 'Should allow to configure NGB server address'
./ngb set_srv http://localhost:8080/catgenome

## search

## search -l

# Reference commands
echo 'Reference commands'
echo '--------'

## reg_ref
echo 'Should register DM6 reference'
echo './ngb reg_ref /ngs/dmel-all-chromosome-r6.06.fasta --name dm6'
./ngb reg_ref /ngs/dmel-all-chromosome-r6.06.fasta --name dm6

echo 'Should register GRCh38 reference'

## reg_ref -n

## reg_ref -g

# Datasets commands
echo 'Datasets commands'
echo '--------'

## reg_dataset

## reg_dataset -p

## reg_dataset [file-names]

## add_dataset

## remove_dataset

## move_dataset

## list_dataset -p

## del_dataset

## url 

## url -loc:chr

## url -loc:chr:range

## url -[file-names]

# Files
## BAM

### reg_file

### reg_file -n

### reg_file -ni

### del_file

### index_file

## CRAM

## GFF

## GTF

## BED

## VCF (SVs, SNPs, InDels)

## BW

## SEG
