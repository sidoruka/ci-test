echo
echo Scenario 2. File types. Will register all supported file types in gzipped and plain formats
echo ------------------------------

echo
echo Scenario 2. File types. Init reference and dataset
echo ------------------------------

skip_it \
  "Should configure NGB server address" \
  "ngb set_srv http://localhost:8080/catgenome"

skip_it \
    "Should register reference with index and explicit name" \
    "ngb reg_ref ${FASTA} --name ${REFERENCE_NAME}"

skip_it \
    "Should register gzipped genes file with explicit name" \
    "ngb reg_file ${REFERENCE_NAME} ${GTF}?${GTF_INDEX} --name ${GTF_NAME}"

skip_it \
    "Should assign registered genes file to a reference by name" \
    "ngb add_genes ${REFERENCE_NAME} ${GTF_NAME}"

skip_it \
    "Should register root dataset for reference" \
    "ngb reg_dataset ${REFERENCE_NAME} ${DATASET_ROOT}"

# Each file type should perform the following checks
#   - register file
#   - search for file
#   - add to dataset
#   - remove from dataset
#   - delete file

#   - register file with expl name
#   - search for file with expl name
#   - add to dataset by expl name
#   - remove from dataset by expl name
#   - delete file by expl name

#   - register gzipped file with expl name
#   - search for gzipped file with expl name 
#   - add to dataset by expl name
#   - remove from dataset by expl name
#   - delete file by expl name

#   - register gzipped file without index (should fail)
#   - search for gzipped file without index (should fail)

#   - register unexisting file (should fail)
#   - search for unexisting file (should fail)

#   - register file for unexisting reference (should fail)
#   - search for file with unexisting reference (should fail)

#   - register file for unexisting dataset (should fail)
#   - search for file with unexisting dataset (should fail)

echo
echo Scenario 2. File types. BAM
echo ------------------------------

echo
echo Scenario 2. File types. CRAM
echo ------------------------------

echo
echo Scenario 2. File types. VCF
echo ------------------------------

echo
echo Scenario 2. File types. BED
echo ------------------------------

echo
echo Scenario 2. File types. GTF
echo ------------------------------

echo
echo Scenario 2. File types. GFF
echo ------------------------------

echo
echo Scenario 2. File types. SEG
echo ------------------------------

echo
echo Scenario 2. File types. Clean-up reference and dataset
echo ------------------------------

it \
    "Should delete root dataset" \
    "ngb del_dataset ${DATASET_ROOT}"

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
echo Scenario 2. Finished
echo
