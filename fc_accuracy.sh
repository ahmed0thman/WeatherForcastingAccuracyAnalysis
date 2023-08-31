#! /bin/bash
file_len=$(wc -l rx_poc.log | cut -d ' ' -f1)
echo $file_len
for ((i=2; i<=$file_len; i++)); do
    pre_fc_tmp=$(cat -A  rx_poc.log | head -$i | tail -1 | cut -d '^' -f5 | tr -d 'I$')
    row=$(cat -A  rx_poc.log | head -$(($i+1)) | tail -1)
    today_obs_tmp=$(echo $row | cut -d '^' -f4 | tr -d 'I$')
    accuracy=$(($today_obs_tmp-$pre_fc_tmp))

    if [ -1 -le $accuracy ] && [ $accuracy -le 1 ]
    then
            accuracy_range=excellent
    elif [ -2 -le $accuracy ] && [ $accuracy -le 2 ]
    then
            accuracy_range=good
    elif [ -3 -le $accuracy ] && [ $accuracy -le 3 ]
    then
            accuracy_range=fair
    else
            accuracy_range=poor
fi
    echo forcast accuracy is $accuracy
    year=$(echo $row | cut -d '^' -f1 | tr -d 'I$')
    month=$(echo $row | cut -d '^' -f2 | tr -d 'I$')
    day=$(echo $row | cut -d '^' -f3 | tr -d 'I$')
    echo -e $year"\t"$month"\t"$day"\t"$today_obs_tmp"\t"$pre_fc_tmp"\t"$accuracy"\t"$accuracy_range >> historical_fc_accuracy.tsv
done