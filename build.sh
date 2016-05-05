#!/bin/bash

build=build
project_582=PetrasVaclav_ProjectPresentation
fwstalk=petras_grass_lidar_fws
usiale=vpetras_grass_lidar_usiale
foss4gna=vpetras_grass_gis_loves_lidar

# how many times repeat latex
n=3

function tex_to_pdf {
    for i in $(eval echo {1..$n}); do pdflatex $1; done
}

set -e

# copy files for the web page
mkdir -p ${build}/images
mkdir -p ${build}/images/grass
cp images/grass/segment_on_counts.png ${build}/images/grass/segment_on_counts.png

cp index.html ${build}/index.html

# create alternative versions
sed -e "s/aspectratio=1610/aspectratio=169/g" < ${project_582}.tex > ${project_582}_16x9.tex
sed -e "s/aspectratio=1610/aspectratio=43/g" < ${project_582}.tex > ${project_582}_4x3.tex
sed -e "s/aspectratio=169/aspectratio=43/g" < ${usiale}.tex > ${usiale}_4x3.tex
sed -e "s/aspectratio=43/aspectratio=169/g" < ${foss4gna}.tex > ${foss4gna}_16x9.tex

# build PDFs
tex_to_pdf ${project_582} &
tex_to_pdf ${project_582}_16x9 &
tex_to_pdf ${project_582}_4x3 &

tex_to_pdf ${fwstalk} &
tex_to_pdf ${usiale} &
tex_to_pdf ${usiale}_4x3 &
tex_to_pdf ${foss4gna} &
tex_to_pdf ${foss4gna}_16x9 &

wait

echo done

# copy results
cp ${project_582}.pdf $build
cp ${project_582}_16x9.pdf $build
cp ${project_582}_4x3.pdf $build
cp ${project_582}.pdf $build/${project_582}_16x10.pdf

cp ${fwstalk}.pdf $build
cp ${usiale}.pdf $build
cp ${usiale}_4x3.pdf $build
cp ${foss4gna}.pdf $build
cp ${foss4gna}_16x9.pdf $build

# remove files for alternative versions
rm ${project_582}_16x9.* ${project_582}_4x3.*
rm ${usiale}_4x3.*
rm ${foss4gna}_16x9.*
