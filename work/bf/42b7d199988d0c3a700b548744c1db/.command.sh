#!/bin/bash -euo pipefail
picard \
    -Xmx29491M \
    MarkDuplicates \
    --CREATE_INDEX \
    --INPUT test_sample1.bwa2.IDT.hg19.local.Aligned.bam \
    --OUTPUT test_sample1.bwa2.IDT.hg19.local.DupMarked.bam \
    --REFERENCE_SEQUENCE hg19_primary.fa \
    --METRICS_FILE test_sample1.bwa2.IDT.hg19.local.DupMarked.MarkDuplicates.metrics.txt

cat <<-END_VERSIONS > versions.yml
"DEMO_YOURWORKFLOW:YOURWORKFLOW:ALIGNREADS:PICARD_MARKDUPLICATES":
    picard: $(echo $(picard MarkDuplicates --version 2>&1) | grep -o 'Version:.*' | cut -f2- -d:)
END_VERSIONS
