DATASETS_COUNT=3

echo
echo Scenario 3. Hierarchies operations. Will create 3-level datasets hierachy with ${DATASETS_COUNT} nodes each
echo ------------------------------

it \
  "Should configure NGB server address" \
  "ngb set_srv http://localhost:8080/catgenome"

it \
    "Should register reference with index and explicit name" \
    "ngb reg_ref ${FASTA} --name ${REFERENCE_NAME}"

for DATASET_NUM in $(seq 1 $DATASETS_COUNT)
do
    ROOT_L1_NAME=${DATASET_ROOT}_${DATASET_NUM}
	it \
        "Should register root dataset ${ROOT_L1_NAME} for reference" \
        "ngb reg_dataset ${REFERENCE_NAME} ${ROOT_L1_NAME}"

        for DATASET_NUM_L2 in $(seq 1 $DATASETS_COUNT)
        do
            CHILD_L2_NAME=${DATASET_CHILD}_${DATASET_NUM}_${DATASET_NUM_L2}
            it \
                "Should register child dataset ${CHILD_L2_NAME} for reference" \
                "ngb reg_dataset ${REFERENCE_NAME} ${CHILD_L2_NAME} -p ${ROOT_L1_NAME}"

                for DATASET_NUM_L3 in $(seq 1 $DATASETS_COUNT)
                do
                    CHILD_L3_NAME=${CHILD_L2_NAME}_${DATASET_NUM_L3}
                    it \
                        "Should register child dataset ${CHILD_L3_NAME} for reference" \
                        "ngb reg_dataset ${REFERENCE_NAME} ${CHILD_L3_NAME} -p ${CHILD_L2_NAME}"
                done
        done
done

echo ------------------------------
echo Scenario 3. Finished
echo
