#!/bin/bash

docker run  -v $(pwd)/mounted-volume/user:/home/ofuser/OpenFOAM/user-v2306 -dit ahmadamani/openfoam-v2306-modified:git_and_write_permission bash

#$(pwd)/mounted-volume/source:/opt/OpenFOAM/OpenFOAM-v2006 
