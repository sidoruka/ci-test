echo
echo Scenario 5. Datasets. Will register Datasets and add files by name and paths
echo ------------------------------

echo
echo Scenario 5. Dataset. Init reference and dataset
echo ------------------------------

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

echo
echo Scenario 5. Dataset. Add files
echo ------------------------------

VCF_SNP_DEF_NAME=`basename $VCF_SNP`
BAM_DEF_NAME=`basename $BAM`

# ---Default naming feature---
# Register feature file
it \
    "Should register feature file ${VCF_SNP} with default name" \
    "ngb reg_file ${REFERENCE_NAME} ${VCF_SNP}"

# Add feature file to dataset
it \
    "Should add default named feature file ${VCF_SNP_DEF_NAME} to a dataset ${DATASET_ROOT}" \
    "ngb add_dataset ${DATASET_ROOT} ${VCF_SNP_DEF_NAME}"

# Remove feature file from dataset
it \
    "Should remove default named feature file ${VCF_SNP_DEF_NAME} from a dataset ${DATASET_ROOT}" \
    "ngb remove_dataset ${DATASET_ROOT} ${VCF_SNP_DEF_NAME}"

# Delete feature files
it \
    "Should delete default named feature file ${VCF_SNP_DEF_NAME}" \
    "ngb del_file ${VCF_SNP_DEF_NAME}"

# ---Explicit naming feature---
# Register feature file with explicit name
it \
    "Should register feature file ${VCF_SNP} with explicit name ${VCF_SNP_NAME}" \
    "ngb reg_file ${REFERENCE_NAME} ${VCF_SNP} --name ${VCF_SNP_NAME}"

# Add feature file to dataset by explicit name
it \
    "Should add explicitly named feature file ${VCF_SNP_NAME} to a dataset ${DATASET_ROOT}" \
    "ngb add_dataset ${DATASET_ROOT} ${VCF_SNP_NAME}"

# Remove feature file from dataset by explicit name
it \
    "Should remove explicit named feature file ${VCF_SNP_NAME} from a dataset ${DATASET_ROOT}" \
    "ngb remove_dataset ${DATASET_ROOT} ${VCF_SNP_NAME}"

# Delete feature file by explicit name
it \
    "Should delete explicit named feature file ${VCF_SNP_NAME}" \
    "ngb del_file ${VCF_SNP_NAME}"

# ---Not registered feature---
# Add feature file to a dataset without registration
it \
    "Should add not registered feature file ${VCF_SNP} to a dataset ${DATASET_ROOT}" \
    "ngb add_dataset ${DATASET_ROOT} ${VCF_SNP}"

# Remove feature file from dataset
it \
    "Should remove default named feature file ${VCF_SNP_DEF_NAME} from a dataset ${DATASET_ROOT}" \
    "ngb remove_dataset ${DATASET_ROOT} ${VCF_SNP_DEF_NAME}"

# Delete feature file
it \
    "Should delete default named feature file ${VCF_SNP_DEF_NAME}" \
    "ngb del_file ${VCF_SNP_DEF_NAME}"

# ---Default naming BAM---
# Register BAM file
it \
    "Should register BAM file ${BAM} with default name" \
    "ngb reg_file ${REFERENCE_NAME} ${BAM}"

# Add BAM file to dataset
it \
    "Should add default named BAM file ${BAM_DEF_NAME} to a dataset ${DATASET_ROOT}" \
    "ngb add_dataset ${DATASET_ROOT} ${BAM_DEF_NAME}"

# Remove BAM file from dataset
it \
    "Should remove default named BAM file ${BAM_DEF_NAME} from a dataset ${DATASET_ROOT}" \
    "ngb remove_dataset ${DATASET_ROOT} ${BAM_DEF_NAME}"

# Delete BAM file
it \
    "Should delete default named BAM file ${BAM_DEF_NAME}" \
    "ngb del_file ${BAM_DEF_NAME}"

# ---Explicit naming BAM---
# Register BAM file with explicit name
it \
    "Should register BAM file ${BAM} with explicit name ${BAM_NAME}" \
    "ngb reg_file ${REFERENCE_NAME} ${BAM} --name ${BAM_NAME}"

# Add BAM file to dataset by explicit name
it \
    "Should add explicitly named BAM file ${BAM_NAME} to a dataset ${DATASET_ROOT}" \
    "ngb add_dataset ${DATASET_ROOT} ${BAM_NAME}"

# Remove BAM file from dataset by explicit name
it \
    "Should remove explicit named BAM file ${BAM_NAME} from a dataset ${DATASET_ROOT}" \
    "ngb remove_dataset ${DATASET_ROOT} ${BAM_NAME}"

# Delete BAM file by explicit name
it \
    "Should delete explicit named BAM file ${BAM_NAME}" \
    "ngb del_file ${BAM_NAME}"

# ---Not registered BAM---
# Add BAM file to a dataset without registration
it \
    "Should add not registered feature file ${BAM} to a dataset ${DATASET_ROOT}" \
    "ngb add_dataset ${DATASET_ROOT} ${BAM}"

# Remove BAM file from dataset
it \
    "Should remove default named BAM file ${BAM_DEF_NAME} from a dataset ${DATASET_ROOT}" \
    "ngb remove_dataset ${DATASET_ROOT} ${BAM_DEF_NAME}"

# Delete BAM file
it \
    "Should delete default named BAM file ${BAM_DEF_NAME}" \
    "ngb del_file ${BAM_DEF_NAME}"

echo
echo Scenario 5. Datasets. Clean-up reference and dataset
echo ------------------------------

# Delete dataset
it \
    "Should delete root dataset" \
    "ngb del_dataset ${DATASET_ROOT}"

# Delete reference
it \
    "Should delete reference" \
    "ngb del_ref ${REFERENCE_NAME}"

echo ------------------------------
echo Scenario 5. Finished
echo
