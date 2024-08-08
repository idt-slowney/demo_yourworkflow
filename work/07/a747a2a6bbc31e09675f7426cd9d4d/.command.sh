#!/bin/bash -euo pipefail
printf "%s\n" 20221114-JN9PH-S1_R1.fastq.gz 20221114-JN9PH-S1_R2.fastq.gz | while read f;
do
    seqtk \
        sample \
         -s100 \
        $f \
        5000 \
        | gzip --no-name > test_sample1_$(basename $f)
done

cat <<-END_VERSIONS > versions.yml
"DEMO_YOURWORKFLOW:YOURWORKFLOW:PROCESSFASTQ:SEQTK_SAMPLE":
    seqtk: $(echo $(seqtk 2>&1) | sed 's/^.*Version: //; s/ .*$//')
END_VERSIONS
