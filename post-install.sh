#!/bin/bash

echo "Executing post install hooks..."


if [ ! -d "post-install" ]
then
        echo "No hooks registered"
else
        for HOOK in post-install/*
        do
                source ${HOOK}
        done
fi