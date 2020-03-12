#!bin/sh
totlenum=$1
file=$2
type=$3
targetpath=$4
filename="${file}"".""${type}"
for i in `seq -f'%03g' 001 $totlenum`
do
cp ${targetpath}/${filename} ${targetpath}/${file}${i}.${type}
done
