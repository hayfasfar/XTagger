#!/bin/bash

function execute() 
{
    PROJECTDIR=$PWD
    source Env/env_cpu.sh || return 1
    git clone https://github.com/LLPDNNX/test-files || return 1
    export PYTHONPATH=$PYTHONPATH:$PROJECTDIR/Ops/release/lib/python2.7/site-packages
    
    python Training/training.py -b 10 --train test-files/nanox_unpacked/train.txt --test test-files/nanox_unpacked/test.txt -e 1 --name test || return 1 
    python Training/convert_to_const_graph.py output/test/epoch_0/model_epoch.hdf5 || return 1
}

execute