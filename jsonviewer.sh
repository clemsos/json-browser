#!/bin/bash

FILELIST="filelist"

die () {
    echo >&2 "$@"
    exit 1
}

[ "$#" -eq 1 ] || die "1 argument required, $# provided"

# get current dir for script
CUR="${BASH_SOURCE[0]}";
if([ -h "${CUR}" ]) then
  while([ -h "${CUR}" ]) do CUR=`readlink -m "${CUR}"`; done
fi
pushd . > /dev/null
cd `dirname ${CUR}` > /dev/null
CUR=`pwd`;
popd  > /dev/null

# watch dir
DATA_DIR=${CUR}/${1}

# if [ ! -z `ls ${DATA_DIR}` ]; then echo 'a'; fi 
if [ ! -d ${DATA_DIR} ]; then die "${DATA_DIR} doesn't exist"; fi 

# delete file list on start
if [ ! -z `ls ${FILELIST}` ]; then rm ${FILELIST}; fi 

# create dir list
echo "creating list of files for "${DATA_DIR}
echo "$(find -L ${DATA_DIR}  -type f -iname "*.json")"  > ${FILELIST};

cat ${FILELIST}

python -m SimpleHTTPServer 
