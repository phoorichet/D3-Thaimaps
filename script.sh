#!/bin/bash
echo "##############################################################"
echo "#### A script to generate GeoJSON files for Thailand map #####"
echo "##############################################################"

FILE_PLACES='maps/places.json'
FILE_POPULATED='ne_10m_populated_places/ne_10m_populated_places.shp'

gen_places()
{
  if [ -e $FILE_PLACES ]
  then
    echo "Removing $FILE_PLACES"
    rm $FILE_PLACES
  fi
  echo "Generating places"
  ogr2ogr -f GeoJSON -where "ISO_A2 = 'TH'" $FILE_PLACES $FILE_POPULATED
  return 0
}


gen_maps()
{
  echo "$1, $2"
  if [ -e $2 ]
  then
    echo "Removing $2"
    rm $2
  fi

  tmp_file="maps/subunits.json"
  if [ -e $tmp_file ]
  then
    rm $tmp_file
  fi

  echo "Generating GeoJSON from shapefile.. $1"
  ogr2ogr -f GeoJSON $tmp_file $1
  echo "Generating TopoJSON from GeoJSON file.. $tmp_file"
  topojson -o $2 --id-property ID_0 --properties -- $tmp_file $FILE_PLACES
  echo "output.. $2"
  echo "Done..!"
  echo ""

  if [ -e $tmp_file ]
  then
    rm $tmp_file
  fi

}


## MAIN ###

# Inflate the zip file
echo "Inflating zip file.."
unzip -o THA_adm.zip -d THA_adm
gen_places


FILE1="THA_adm/THA_adm0.shp"
FILE2="maps/tha_adm0.json"
gen_maps $FILE1 $FILE2

FILE1="THA_adm/THA_adm1.shp"
FILE2="maps/tha_provinces.json"
gen_maps $FILE1 $FILE2

FILE1="THA_adm/THA_adm2.shp"
FILE2="maps/tha_amphers.json"
gen_maps $FILE1 $FILE2

FILE1="THA_adm/THA_adm3.shp"
FILE2="maps/tha_districts.json"
gen_maps $FILE1 $FILE2

# FILE1='maps/tha_adm1.json'
# FILE2='maps/subunit_adm1.json'
# if [ -e $FILE1 ] || [ -e $FILE2 ];
# then
#   # Remove the existing files
#   echo "Removing files $FILE1 $FILE2"
#   rm $FILE1
#   rm $FILE2
# fi
# 
# echo 'Generating GeoJSON from shapefile'
# ogr2ogr -f GeoJSON maps/subunit_adm1.json THA_adm/THA_adm1.shp
# echo 'Generating TopoJSON from GeoJSON file'
# topojson -o maps/tha_adm1.json --id-property ID_0 --properties -- maps/subunit_adm1.json $FILE_PLACES
# echo 'Done..!'
