# $1 - File path
# $2 - File index path
# $3 - File name
function check_file {
    FILE_PATH=$1
    DEF_FILE_NAME=`basename $FILE_PATH`

    if [ -z "$2" ]; then
        FULL_FILE_PATH=$1
        HAS_INDEX=0
    else
        FULL_FILE_PATH=$1?$2
        HAS_INDEX=1
    fi

    if [ -z "$3" ]; then
        EXPL_FILE_NAME=""
        HAS_EXPL_NAME=0
    else
        EXPL_FILE_NAME=$3
        HAS_EXPL_NAME=1
    fi


    # Each file type should perform the following checks
    #   - register file
    it \
        "Should register file ${FULL_FILE_PATH} with default name" \
        "ngb reg_file ${REFERENCE_NAME} ${FULL_FILE_PATH}"

    #   - search for file
    it \
        "Should find registered file by strict default name and output in a table format" \
        "ngb search ${DEF_FILE_NAME} -t" \
        "${FILE_PATH}"

    #   - add to dataset
    it \
        "Should add default named file ${DEF_FILE_NAME} to dataset ${DATASET_ROOT}" \
        "ngb add_dataset ${DATASET_ROOT} ${DEF_FILE_NAME}"

    #   - remove from dataset
    it \
        "Should remove default named file ${DEF_FILE_NAME} from dataset ${DATASET_ROOT}" \
        "ngb remove_dataset ${DATASET_ROOT} ${DEF_FILE_NAME}"

    #   - delete file
    it \
        "Should delete default named file ${DEF_FILE_NAME}" \
        "ngb del_file ${DEF_FILE_NAME}"

    if ((HAS_EXPL_NAME)); then
        #   - register file with expl name
        it \
            "Should register file ${FULL_FILE_PATH} with explicit name" \
            "ngb reg_file ${REFERENCE_NAME} ${FULL_FILE_PATH} --name ${EXPL_FILE_NAME}"

        #   - search for file with expl name
        it \
            "Should find registered file by strict explicit name and output in a table format" \
            "ngb search ${EXPL_FILE_NAME} -t" \
            "${FILE_PATH}"

        #   - add to dataset by expl name
        it \
            "Should add explicit named file ${EXPL_FILE_NAME} to dataset ${DATASET_ROOT}" \
            "ngb add_dataset ${DATASET_ROOT} ${EXPL_FILE_NAME}"

        #   - remove from dataset by expl name
        it \
            "Should remove explicit named file ${EXPL_FILE_NAME} from dataset ${DATASET_ROOT}" \
            "ngb remove_dataset ${DATASET_ROOT} ${EXPL_FILE_NAME}"

        #   - delete file by expl name
        it \
            "Should delete explicit named file ${EXPL_FILE_NAME}" \
            "ngb del_file ${EXPL_FILE_NAME}"
    fi

    #   - register file without index (should fail)
    if ((HAS_INDEX)); then
         skip_it \ # SKIPPED because it allows to register GZIPPED file without index
            "Should fail to register file ${FILE_PATH} without index" \
            "! ngb reg_file ${REFERENCE_NAME} ${FILE_PATH}"
        
        #   - search for file without index (should fail)
        # TODO
    fi

    #   - register unexisting file (should fail)
    it \
        "Should fail to register unexisting file" \
        "! ngb reg_file /not/exist${FULL_FILE_PATH}"
        
    #   - search for unexisting file (should fail)
    # TODO
    
    #   - register file for unexisting reference (should fail)
    it \
        "Should fail to register file for unexisting reference" \
        "! ngb reg_file not_existing_ref ${FULL_FILE_PATH}"

    #   - search for file with unexisting reference (should fail)
    # TODO

    #   - register file for unexisting dataset (should fail)
    #       - register file
     it \
        "Should register file ${FULL_FILE_PATH} with default name" \
        "ngb reg_file ${REFERENCE_NAME} ${FULL_FILE_PATH}"
    #       - check invalid dataset
    it \
        "Should fail to add file ${DEF_FILE_NAME} to unexisting dataset" \
        "! ngb add_dataset not_existing_dataset ${DEF_FILE_NAME}"
    #       - delete file
    it \
        "Should delete default named file ${DEF_FILE_NAME}" \
        "ngb del_file ${DEF_FILE_NAME}"

    #   - search for file with unexisting dataset (should fail)
    # TODO

    #   - register duplicate file (should fail)
    #       - register file
     it \
        "Should register file ${FULL_FILE_PATH} with default name" \
        "ngb reg_file ${REFERENCE_NAME} ${FULL_FILE_PATH}"

    #   - check duplicate
    skip_it \ # SKIPPED because it always returns zero exit code
        "Should fail to register duplicated file" \
        "! ngb reg_file ${REFERENCE_NAME} ${FULL_FILE_PATH}"

    #       - delete file
    it \
        "Should delete default named file ${DEF_FILE_NAME}" \
        "ngb del_file ${DEF_FILE_NAME}"

}

echo
echo Scenario 2. File types. Will register all supported file types in gzipped and plain formats
echo ------------------------------

echo
echo Scenario 2. File types. Init reference and dataset
echo ------------------------------

it \
  "Should configure NGB server address" \
  "ngb set_srv http://localhost:8080/catgenome"

it \
    "Should register reference with index and explicit name" \
    "ngb reg_ref ${FASTA} --name ${REFERENCE_NAME}"

it \
    "Should register root dataset for reference" \
    "ngb reg_dataset ${REFERENCE_NAME} ${DATASET_ROOT}"

echo
echo Scenario 2. File types. BAM
echo ------------------------------

check_file "${BAM}" "${BAM_INDEX}" "${BAM_NAME}"

echo
echo Scenario 2. File types. CRAM
echo ------------------------------

echo
echo Scenario 2. File types. VCF
echo ------------------------------

# plain
check_file "${VCF_SNP}" "" "${VCF_SNP_NAME}"

# gzipped

echo
echo Scenario 2. File types. BED
echo ------------------------------


# plain

# gzipped

echo
echo Scenario 2. File types. GTF
echo ------------------------------

# plain
check_file "${GTF_PLAIN}" "" "${GTF_NAME}"
# gzipped
check_file "${GTF}" "${GTF_INDEX}" "${GTF_NAME}"

echo
echo Scenario 2. File types. GFF
echo ------------------------------

# plain

# gzipped

echo
echo Scenario 2. File types. SEG
echo ------------------------------

# plain

# gzipped

echo
echo Scenario 2. File types. Clean-up reference and dataset
echo ------------------------------

it \
    "Should delete root dataset" \
    "ngb del_dataset ${DATASET_ROOT}"

it \
    "Should delete reference" \
    "ngb del_ref ${REFERENCE_NAME}"

echo ------------------------------
echo Scenario 2. Finished
echo
