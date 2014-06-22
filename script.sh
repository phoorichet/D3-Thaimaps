#!/bin/bash
echo 'THA adm1..'

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



## MAIN ###
gen_places

FILE1='maps/tha_adm1.json'
FILE2='maps/subunit_adm1.json'
if [ -e $FILE1 ] || [ -e $FILE2 ];
then
  # Remove the existing files
  echo "Removing files $FILE1 $FILE2"
  rm $FILE1
  rm $FILE2
fi

echo 'Generating GeoJSON from shapefile'
ogr2ogr -f GeoJSON maps/subunit_adm1.json THA_adm/THA_adm1.shp
echo 'Generating TopoJSON from GeoJSON file'
topojson -o maps/tha_adm1.json --id-property ID_0 --properties -- maps/subunit_adm1.json $FILE_PLACES
echo 'Done..!'
