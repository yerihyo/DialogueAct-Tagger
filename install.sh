#!/bin/bash

#1) Install python dependencies

ARG0=${BASH_SOURCE[0]}
FILE_PATH=$(greadlink -f $ARG0)
FILE_DIR=$(dirname $FILE_PATH)

#pip install nltk
#pip install scikit-learn
#pip install spacy

pushd $FILE_DIR

pip install -U -r requirements.txt

python -m spacy download en

#2) Download publicly available corpora
mkdir -p data/Maptask data/AMI data/Oasis

if [ ! -d "data/Maptask/maptaskv2-1" ] ; then
	echo "Downloading the Maptask corpus"
	wget http://groups.inf.ed.ac.uk/maptask/hcrcmaptask.nxtformatv2-1.zip && unzip -q hcrcmaptask.nxtformatv2-1.zip && rm -rf hcrcmaptask.nxtformatv2-1.zip && mv maptaskv2-1 data/Maptask/maptaskv2-1
fi

if [ ! -d "data/AMI/corpus" ] ; then
	echo "Downloading the AMI corpus"
	 mkdir corpus && cd corpus && wget http://groups.inf.ed.ac.uk/ami/AMICorpusAnnotations/ami_public_manual_1.6.2.zip && unzip -q ami_public_manual_1.6.2.zip && rm -f ami_public_manual_1.6.2.zip && cd .. && mv corpus data/AMI/corpus
fi

if [ ! -d "data/Oasis/corpus" ] ; then
	echo "Downloading the Oasis corpus"
         mkdir corpus && cd corpus && wget http://groups.inf.ed.ac.uk/oasis/download/oasis_full_rel1.0.zip && unzip -q oasis_full_rel1.0.zip && rm -f oasis_full_rel1.0.zip && cd .. && mv corpus data/Oasis/corpus
fi

popd
