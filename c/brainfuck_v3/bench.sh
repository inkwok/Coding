shopt -s nullglob

bench() {
    local scores=()
    local average

    taskset -c 2,3 timeout --preserve-status "$1" \
        "${FILE[0]}" ./bf_programs/e.bf > "log/output_0.log" &
    taskset -c 4,5 timeout --preserve-status "$1" \
        "${FILE[0]}" ./bf_programs/e.bf > "log/output_1.log" &
    taskset -c 6,7 timeout --preserve-status "$1" \
        "${FILE[0]}" ./bf_programs/e.bf > "log/output_2.log" &
    wait

    for i in {0..2}; do
        (( scores[i] = $(wc -m < "log/output_$i.log") - 2 ))
        (( average += scores[i] ))
    done
    (( average /= 3 ))

    {
        printf '%s\n' "${scores[@]}"
        printf 'Average: %s\n' "$average"
        printf 'Digits/sec: %s\n' "$(( average / $1 ))"
        printf 'Time: %s\n' "$1"
    } | tee -a "log/scores_$1.log"

    rm -f log/output_*.log
    return 0
}

DURATION=10

if [ $# -gt 0 ]; then
    DURATION=$1
fi

echo "[Build]"
make > /dev/null
FILE=(./target/*)
if (( ${#FILE[@]} != 1 )); then
    echo "Clean /target/. There is more than one program there."
    return 1
fi


echo "[Test]"
mkdir -p log/
bench "$((DURATION +  0))"
# bench "$((DURATION + 10))"
# bench "$((DURATION + 20))"
