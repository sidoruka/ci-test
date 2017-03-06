echo
echo Scenario 4. Reference. Will register reference genome with genes
echo ------------------------------

echo
echo Scenario 4. Reference. Basic registration with genes and default name
echo ------------------------------
# Register reference
it \
    "Should register reference with default name ${FASTA_NO_EXT}" \
    "ngb reg_ref ${FASTA}"

# Register GTF with explicit name
it \
    "Should register genes file with explicit name" \
    "ngb reg_file ${FASTA_NO_EXT} ${GTF}?${GTF_INDEX} --name ${GTF_NAME}"

# Add GTF to reference
it \
    "Should assign registered genes file to a reference by name" \
    "ngb add_genes ${FASTA_NO_EXT} ${GTF_NAME}"

# Check reference exists
#TODO

# Remove GTF from reference
it \
    "Should remove GTF file from reference" \
    "ngb remove_genes ${FASTA_NO_EXT}"

# Delete GTF
it \
    "Should delete GTF file" \
    "ngb del_file ${GTF_NAME}"

# Delete reference
it \
    "Should delete reference" \
    "ngb del_ref ${FASTA_NO_EXT}"

# Check reference deleted
#TODO

echo
echo Scenario 4. Reference. Basic registration with genes and explicit name
echo ------------------------------
# Register reference with explicit name
it \
    "Should register reference with explicit name ${REFERENCE_NAME}" \
    "ngb reg_ref ${FASTA} --name ${REFERENCE_NAME}"

# Register GTF with explicit name
it \
    "Should register genes file with explicit name" \
    "ngb reg_file ${REFERENCE_NAME} ${GTF}?${GTF_INDEX} --name ${GTF_NAME}"

# Add GTF to reference
it \
    "Should assign registered genes file to a reference by name" \
    "ngb add_genes ${REFERENCE_NAME} ${GTF_NAME}"

# Check reference exists
#TODO

# Remove GTF from reference
it \
    "Should remove GTF file from reference" \
    "ngb remove_genes ${REFERENCE_NAME}"

# Delete GTF
it \
    "Should delete GTF file" \
    "ngb del_file ${GTF_NAME}"

# Delete reference
it \
    "Should delete reference" \
    "ngb del_ref ${REFERENCE_NAME}"

# Check reference deleted
#TODO

echo
echo Scenario 4. Reference. Registration with gzipped genes using -g option
echo ------------------------------

GTF_GZ_NAME=`basename $GTF`

# Register reference with explicit name and gzipped GTF - single line
it \
    "Should register reference with explicit name ${REFERENCE_NAME} and gzipped genes ${GTF}?${GTF_INDEX}" \
    "ngb reg_ref ${FASTA} --name ${REFERENCE_NAME} --genes ${GTF}?${GTF_INDEX}"

# Check reference exists
#TODO

# Remove GTF from reference
it \
    "Should remove GTF file from reference" \
    "ngb remove_genes ${REFERENCE_NAME}"

# Delete GTF
it \
    "Should delete GTF file by file name ${GTF_GZ_NAME}" \
    "ngb del_file ${GTF_GZ_NAME}"

# Delete reference
it \
    "Should delete reference" \
    "ngb del_ref ${REFERENCE_NAME}"

# Check reference deleted
#TODO

echo
echo Scenario 4. Reference. Registration with plain genes using -g option
echo ------------------------------

GTF_PLAIN_NAME=`basename $GTF_PLAIN`

# Register reference with explicit name and plain GTF - single line
it \
    "Should register reference with explicit name ${REFERENCE_NAME} and plain genes ${GTF_PLAIN}" \
    "ngb reg_ref ${FASTA} --name ${REFERENCE_NAME} --genes ${GTF_PLAIN}"

# Check reference exists
#TODO

# Remove GTF from reference
it \
    "Should remove GTF file from reference" \
    "ngb remove_genes ${REFERENCE_NAME}"

# Delete GTF
it \
    "Should delete GTF file by file name ${GTF_PLAIN_NAME}" \
    "ngb del_file ${GTF_PLAIN_NAME}"

# Delete reference
it \
    "Should delete reference" \
    "ngb del_ref ${REFERENCE_NAME}"

# Check reference deleted
#TODO

echo
echo Scenario 4. Reference. Registration with -ngc option
echo ------------------------------
# Register reference with explicit name and no GC content calculation
# Register reference with explicit name
it \
    "Should register reference with explicit name ${REFERENCE_NAME} and no gc content" \
    "ngb reg_ref ${FASTA} --name ${REFERENCE_NAME} -ngc"

# Check reference exists
#TODO

# Delete reference
it \
    "Should delete reference" \
    "ngb del_ref ${REFERENCE_NAME}"

# Check reference deleted
#TODO

echo
echo Scenario 4. Reference. Registration error hadling
echo ------------------------------

FASTA_INVALID=`pwd`/invalid.fasta

# Should fail to register unexisting file
it \
    "Should fail to register reference from invalid fasta path" \
    "! ngb reg_ref ${FASTA_INVALID}"

# Check reference does not exist
#TODO

# Resgister first reference to take name
it \
    "Should register reference with explicit name ${REFERENCE_NAME}" \
    "ngb reg_ref ${FASTA} --name ${REFERENCE_NAME}"

# Should fail to register already taken name
it \
    "Should fail to register reference with already taken name" \
    "! ngb reg_ref ${FASTA} --name ${REFERENCE_NAME}"

echo ------------------------------
echo Scenario 4. Finished
echo
