echo
echo Scenario 1. Simple Dataset. Registration phase
echo ------------------------------

it \
  "Should configure NGB server address" \
  "ngb set_srv http://localhost:8080/catgenome"

it \
    "Should register reference with index and explicit name" \
    "ngb reg_ref ${FASTA} --name ${REFERENCE_NAME}"

it \
    "Should register gzipped genes file with explicit name" \
    "ngb reg_file ${REFERENCE_NAME} ${GTF}?${GTF_INDEX} --name ${GTF_NAME}"

it \
    "Should assign registered genes file to a reference by name" \
    "ngb add_genes ${REFERENCE_NAME} ${GTF_NAME}"

it \
    "Should register root dataset for reference" \
    "ngb reg_dataset ${REFERENCE_NAME} ${DATASET_ROOT}"

it \
    "Should register BAM file with explicit name" \
    "ngb reg_file ${REFERENCE_NAME} ${BAM}?${BAM_INDEX} --name ${BAM_NAME}"

it \
    "Should add registered BAM file to root dataset" \
    "ngb add_dataset ${DATASET_ROOT} ${BAM_NAME}"

it \
    "Should register VCF file with explicit name" \
    "ngb reg_file ${REFERENCE_NAME} ${VCF_SNP} --name ${VCF_SNP_NAME}"

it \
    "Should add registered VCF file to root dataset" \
    "ngb add_dataset ${DATASET_ROOT} ${VCF_SNP_NAME}"

echo
echo Scenario 1. Simple Dataset. Check phase - search registered items
echo ------------------------------

it \
    "Should list registered reference and output in a table format" \
    "ngb list_ref -t" \
    "${FASTA}"

it \
    "Should find registered reference by strict name and output in a table format" \
    "ngb search ${REFERENCE_NAME} -t" \
    "asdc"

it \
    "Should list registered dataset and output in a table format" \
    "ngb list_dataset -t"

it \
    "Should find registered GTF file by strict name and output in a table format" \
    "ngb search ${GTF_NAME} -t"

it \
    "Should find registered BAM file by strict name and output in a table format" \
    "ngb search ${BAM_NAME} -t"

it \
    "Should find registered VCF file by strict name and output in a table format" \
    "ngb search ${VCF_SNP_NAME} -t"
    
it \
    "Should generate url for whole dataset" \
    "ngb url ${DATASET_ROOT}" \
    "http://localhost:8080/catgenome/#/ref?tracks=\[{\"p\":\"${DATASET_ROOT}\"}\]"

it \
    "Should generate url for whole root dataset at 1st chr" \
    "ngb url ${DATASET_ROOT} --location ${CHR}" \
    "http://localhost:8080/catgenome/#/ref/X?tracks=\[{\"p\":\"${DATASET_ROOT}\"}\]"

it \
    "Should generate url for whole root dataset at 1st chr and range 1000bp-2000bp" \
    "ngb url ${DATASET_ROOT} --location ${CHR}:1000-2000"
    
it \
    "Should generate url for only one BAM file from a root dataset at 1st chr and range 1000bp-2000bp" \
    "ngb url ${DATASET_ROOT} ${BAM_NAME} --location ${CHR}:1000-2000"
    
it \
    "Should generate url for only BAM and VCF files from a root dataset at 1st chr and range 1000bp-2000bp" \
    "ngb url ${DATASET_ROOT} ${BAM_NAME} ${VCF_SNP_NAME} --location ${CHR}:1000-2000"

echo
echo Scenario 1. Simple Dataset. Clean-up phase - delete registered items
echo ------------------------------

it \
    "Should remove BAM file from dataset" \
    "ngb remove_dataset ${DATASET_ROOT} ${BAM_NAME}"

it \
    "Should remove VCF file from dataset" \
    "ngb remove_dataset ${DATASET_ROOT} ${VCF_SNP_NAME}"

it \
    "Should delete root dataset" \
    "ngb del_dataset ${DATASET_ROOT}"

it \
    "Should delete BAM file" \
    "ngb del_file ${BAM_NAME}"

it \
    "Should delete VCF file" \
    "ngb del_file ${VCF_SNP_NAME}"

it \
    "Should remove GTF file from reference" \
    "ngb remove_genes ${REFERENCE_NAME}"

it \
    "Should delete GTF file" \
    "ngb del_file ${GTF_NAME}"

it \
    "Should delete reference" \
    "ngb del_ref ${REFERENCE_NAME}"

echo ------------------------------
echo Scenario 1. Finished
echo

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

## search -l
## <TODO>