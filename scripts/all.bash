#!/bin/bash -eu

ARG0=${BASH_SOURCE[0]}
FILE_PATH=$(greadlink -f $ARG0)
FILE_DIR=$(dirname $FILE_PATH)
BASE_DIR=$(dirname $FILE_DIR)

$FILE_DIR/train.py

pushd $BASE_DIR

cat $FILE_DIR/input.list \
    | $FILE_DIR/predict.py \
	  -model $BASE_DIR/models/Model.SVM/ \
	  > $FILE_DIR/output.list

popd

