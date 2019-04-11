FILE=$1
OUTFILE=$2

ROWS=$(cat $1)

cnt=0
while read LINE
do
#    echo "${cnt} : "${LINE}
    cnt=`expr ${cnt} + 1`
    if [ ${cnt} -eq 1 ]
    then
        fld1=$(echo -n ${LINE} | cut -d, -f2-14)
        fld2="latitude"
        fld3="longitude"
        fld4=$(echo ${LINE} | cut -d, -f16-217)
        fld5=$(echo ${LINE} | cut -d, -f219-)
        echo ${fld1},${fld2},${fld3},${fld4},${fld5} > ${OUTFILE}
    else
        fld1=$(echo -n ${LINE} | cut -d, -f2-14)
        location=$(echo -n ${LINE} | cut -d, -f15)
        if [ -n "${location}" ]
        then
            location=$(echo -n ${LINE} | cut -d, -f15-16)
            fld2=$(echo -n ${location} | cut -d, -f1| sed -e 's/"(//g')
            fld3=$(echo -n ${location} | cut -d, -f2| sed -e 's/)"//g')
            fld4=$(echo ${LINE} | cut -d, -f17-218)
            fld5=$(echo ${LINE} | cut -d, -f220-)
            echo ${fld1},${fld2},${fld3},${fld4},${fld5} >> ${OUTFILE}
        fi
    fi

#    echo ${LINE} | awk -F, '{$13="";print}'
done <<_EOD
${ROWS}
_EOD

