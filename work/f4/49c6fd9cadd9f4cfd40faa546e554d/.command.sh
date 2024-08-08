#!/bin/bash -euo pipefail
printf "%s %s\n" 20221114-JN9PH-S1_R1.fastq.gz test_sample1_1.gz 20221114-JN9PH-S1_R2.fastq.gz test_sample1_2.gz | while read old_name new_name; do
    [ -f "${new_name}" ] || ln -s $old_name $new_name
done

fastqc \
     \
    --threads 6 \
    --memory 10000 \
    test_sample1_1.gz test_sample1_2.gz

cat <<-END_VERSIONS > versions.yml
"DEMO_YOURWORKFLOW:YOURWORKFLOW:PROCESSFASTQ:PreprocessFASTQC":
    fastqc: $( fastqc --version | sed '/FastQC v/!d; s/.*v//' )
END_VERSIONS
