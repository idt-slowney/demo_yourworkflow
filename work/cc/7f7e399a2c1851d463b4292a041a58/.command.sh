#!/bin/bash -euo pipefail
printf "%s %s\n" test_sample1_1_val_1.fq.gz test_sample1_1.gz test_sample1_2_val_2.fq.gz test_sample1_2.gz | while read old_name new_name; do
    [ -f "${new_name}" ] || ln -s $old_name $new_name
done

fastqc \
     \
    --threads 6 \
    --memory 10000 \
    test_sample1_1.gz test_sample1_2.gz

cat <<-END_VERSIONS > versions.yml
"DEMO_YOURWORKFLOW:YOURWORKFLOW:PROCESSFASTQ:PostprocessFASTQC":
    fastqc: $( fastqc --version | sed '/FastQC v/!d; s/.*v//' )
END_VERSIONS
