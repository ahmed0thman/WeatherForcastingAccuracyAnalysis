#! /bin/bash
echo $(tail -7 historical_fc_accuracy.tsv  | cut -f6) > scratch.txt
week_fc=($(echo $(cat scratch.txt)))
for i in {0..6}; do
  if [[ ${week_fc[$i]} -lt 0 ]]
  then
    week_fc[$i]=$((-1*${week_fc[$i]}))
  fi
  # validate result:
  echo ${week_fc[$i]}
done

max=${week_fc[1]}
min=${week_fc[1]}
for i in {0..6}; do
    if [ ${week_fc[$i]} -gt $max ] 
    then
        max=${week_fc[$i]}
    fi

    if [ ${week_fc[$i]} -lt $min ] 
    then
        min=${week_fc[$i]}
    fi
done
echo -e "minimum ebsolute error = $min"
echo -e "maximum absolute error = $max"
