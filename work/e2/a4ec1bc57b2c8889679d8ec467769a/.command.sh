#!/bin/bash -euo pipefail
export JAVA_OPTS='"-Xms18432m" "-Xmx72g" "-Dsamjdk.reference_fasta=hg19_primary.fa"'
vardict-java \
    -c 1 -S 2 -E 3 \
    -b test_sample1.bwa2.IDT.hg19.local.DupMarked.bam \
    -th 12 \
    -G hg19_primary.fa \
    Exome_Exomev2_Targets.bed \
| teststrandbias.R \
| var2vcf_valid.pl \
     \
| bgzip  --threads 12 > test_sample1.vcf.gz

cat <<-END_VERSIONS > versions.yml
"DEMO_YOURWORKFLOW:YOURWORKFLOW:VARDICTJAVA":
    vardict-java: $( realpath $( command -v vardict-java ) | sed 's/.*java-//;s/-.*//' )
    var2vcf_valid.pl: $( var2vcf_valid.pl -h | sed '2!d;s/.* //' )
END_VERSIONS
