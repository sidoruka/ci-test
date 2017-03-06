DATASETS_COUNT=3

echo
echo Scenario 3. Hierarchies operations. Will create 3-level datasets hierachy with ${DATASETS_COUNT} nodes each and check it is created
echo ------------------------------

it \
  "Should configure NGB server address" \
  "ngb set_srv http://localhost:8080/catgenome"

it \
    "Should register reference with index and explicit name" \
    "ngb reg_ref ${FASTA} --name ${REFERENCE_NAME}"

# Build hierachy
#   - root_dataset_N
#       - child_dataset_N_M
#           - child_dataset_N_M_K

# Adding level 1 datasets
for DATASET_NUM in $(seq 1 $DATASETS_COUNT)
do
    ROOT_L1_NAME=${DATASET_ROOT}_${DATASET_NUM}
	it \
        "Should register root dataset ${ROOT_L1_NAME} for reference" \
        "ngb reg_dataset ${REFERENCE_NAME} ${ROOT_L1_NAME}"

        # Adding level 2 datasets
        for DATASET_NUM_L2 in $(seq 1 $DATASETS_COUNT)
        do
            CHILD_L2_NAME=${DATASET_CHILD}_${DATASET_NUM}_${DATASET_NUM_L2}
            it \
                "Should register child dataset ${CHILD_L2_NAME} for reference" \
                "ngb reg_dataset ${REFERENCE_NAME} ${CHILD_L2_NAME} -p ${ROOT_L1_NAME}"

                # Adding level 3 datasets
                for DATASET_NUM_L3 in $(seq 1 $DATASETS_COUNT)
                do
                    CHILD_L3_NAME=${CHILD_L2_NAME}_${DATASET_NUM_L3}
                    it \
                        "Should register child dataset ${CHILD_L3_NAME} for reference" \
                        "ngb reg_dataset ${REFERENCE_NAME} ${CHILD_L3_NAME} -p ${CHILD_L2_NAME}"
                done

                # Check that ${CHILD_L2_NAME} has ${DATASETS_COUNT} child items
                # TODO
        done

        # Check that ${ROOT_L1_NAME} has ${DATASETS_COUNT} child items
        # TODO
done

# Check that root level has ${DATASETS_COUNT} items
# TODO

echo
echo Scenario 3. Hierarchies operations. Will delete all created datasets and check they are deleted
echo ------------------------------

# Deleting level 1 datasets
for DATASET_NUM in $(seq 1 $DATASETS_COUNT)
do
    ROOT_L1_NAME=${DATASET_ROOT}_${DATASET_NUM}

    # Deleting level 2 datasets
    for DATASET_NUM_L2 in $(seq 1 $DATASETS_COUNT)
    do
        CHILD_L2_NAME=${DATASET_CHILD}_${DATASET_NUM}_${DATASET_NUM_L2}
           
        # Deleting level 3 datasets
        for DATASET_NUM_L3 in $(seq 1 $DATASETS_COUNT)
        do
            CHILD_L3_NAME=${CHILD_L2_NAME}_${DATASET_NUM_L3}
            it \
                "Should delete L3 child dataset ${CHILD_L3_NAME}" \
                "ngb del_dataset ${CHILD_L3_NAME}"
            done

            # Check that ${CHILD_L2_NAME} has no child items
            # TODO

            it \
                "Should delete L2 child dataset ${CHILD_L2_NAME}" \
                "ngb del_dataset ${CHILD_L2_NAME}"
        done

        # Check that ${ROOT_L1_NAME} has no child items
        # TODO

        it \
            "Should delete root dataset ${ROOT_L1_NAME}" \
            "ngb del_dataset ${ROOT_L1_NAME}"
done

# Check that no root items left
# TODO

echo
echo Scenario 3. Hierarchies operations. Will move child nodes between root nodes
echo ------------------------------

it \
    "Should register first root dataset ${DATASET_ROOT}_1" \
    "ngb reg_dataset ${REFERENCE_NAME} ${DATASET_ROOT}_1"

it \
    "Should register dataset ${DATASET_CHILD} as a child to ${DATASET_ROOT}_1" \
    "ngb reg_dataset ${REFERENCE_NAME} ${DATASET_CHILD} -p ${DATASET_ROOT}_1"

it \
    "Should register second root dataset ${DATASET_ROOT}_2" \
    "ngb reg_dataset ${REFERENCE_NAME} ${DATASET_ROOT}_2"

# Check datasets are created
# TODO

it \
    "Should move ${DATASET_CHILD} from ${DATASET_ROOT}_1 to ${DATASET_ROOT}_2" \
    "ngb move_dataset ${DATASET_CHILD} ${DATASET_ROOT}_2"

# Check dataset is moved created
# TODO

# Clean datasets
it \
    "Should delete child dataset ${DATASET_CHILD}" \
    "ngb del_dataset ${DATASET_CHILD}"

it \
    "Should delete root dataset ${DATASET_ROOT}_1" \
    "ngb del_dataset ${DATASET_ROOT}_1"

it \
    "Should delete root dataset ${DATASET_ROOT}_2" \
    "ngb del_dataset ${DATASET_ROOT}_2"


echo
echo Scenario 3. Hierarchies operations. Clean-up reference
echo ------------------------------

it \
    "Should delete reference" \
    "ngb del_ref ${REFERENCE_NAME}"


echo ------------------------------
echo Scenario 3. Finished
echo
