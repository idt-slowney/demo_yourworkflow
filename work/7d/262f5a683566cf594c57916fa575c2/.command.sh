#!/bin/bash -euo pipefail
INDEX=`find -L ./ -name "*.amb" | sed 's/\.amb$//'`

ID=ID:test_sample1
SM=SM:test_sample1
LB=LB:test_sample1
PL=PL:test_sample1
PU=PU:test_sample1

bwa-mem2 \
    mem \
    -K 100000000 -R "@RG\t$ID\t$SM\t$LB\t$PL\t$PU" -C \
    -t 8 \
    $INDEX \
    test_sample1_1_val_1.fq.gz test_sample1_2_val_2.fq.gz \
    | samtools sort  -@ 8  -o test_sample1.bwa2.IDT.hg19.local.Aligned.bam -

cat <<-END_VERSIONS > versions.yml
"DEMO_YOURWORKFLOW:YOURWORKFLOW:ALIGNREADS:BWAMEM2_MEM":
    bwamem2: $(echo $(bwa-mem2 version 2>&1) | sed 's/.* //')
    samtools: $(echo $(samtools --version 2>&1) | sed 's/^.*samtools //; s/Using.*$//')
END_VERSIONS
