#!/bin/bash

echo "Executing pre install hooks..."


if [ ! -d "pre-install" ]
then
        echo "No hooks registered"
else
        for HOOK in pre-install/*
        do
                source ${HOOK}
        done
fi
