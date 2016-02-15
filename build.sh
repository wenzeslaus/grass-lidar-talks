#!/bin/bash

build=build
project_582=PetrasVaclav_ProjectPresentation

pdflatex $project_582
pdflatex $project_582
pdflatex $project_582

cp $project_582.pdf $build/$project_582.pdf
cp index.html $build/index.html
