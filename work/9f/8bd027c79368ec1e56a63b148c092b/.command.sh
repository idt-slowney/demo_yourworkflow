#!/bin/bash -euo pipefail
[ ! -f  test_sample1_1.fastq.gz ] && ln -s test_sample1_20221114-JN9PH-S1_R1.fastq.gz test_sample1_1.fastq.gz
[ ! -f  test_sample1_2.fastq.gz ] && ln -s test_sample1_20221114-JN9PH-S1_R2.fastq.gz test_sample1_2.fastq.gz
trim_galore \
     \
    --cores 8 \
    --paired \
    --gzip \
    test_sample1_1.fastq.gz \
    test_sample1_2.fastq.gz

cat <<-END_VERSIONS > versions.yml
"DEMO_YOURWORKFLOW:YOURWORKFLOW:PROCESSFASTQ:TRIMGALORE":
    trimgalore: $(echo $(trim_galore --version 2>&1) | sed 's/^.*version //; s/Last.*$//')
    cutadapt: $(cutadapt --version)
END_VERSIONS
