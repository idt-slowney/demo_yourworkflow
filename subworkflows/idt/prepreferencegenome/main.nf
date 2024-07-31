include { BWAMEM2_INDEX }                       from '../../../modules/nf-core/bwamem2/index/main'
include { SAMTOOLS_FAIDX }                      from '../../../modules/nf-core/samtools/faidx/main'
include { PICARD_CREATESEQUENCEDICTIONARY }     from '../../../modules/nf-core/picard/createsequencedictionary/main'
include { SENTIEON_BWAINDEX }                   from '../../../modules/nf-core/sentieon/bwaindex/main'

workflow PREPREFERENCEGENOME {

    take:
    fasta       // channel: [mandatory] [fasta]

    main:
    // Initialize output channels
    versions = Channel.empty()

    // Map fasta to [meta, fasta] channel
    // fasta = fasta.map{ fasta -> [ [ id:fasta.baseName ], fasta ] }

    // Use `ext.when` with params (aligner, index, etc.) to determine what to run
    SENTIEON_BWAINDEX(fasta)
    BWAMEM2_INDEX(fasta)


    SAMTOOLS_FAIDX(fasta, [[id:'null'], []])
    PICARD_CREATESEQUENCEDICTIONARY(fasta)

    // Gather versions
    versions = versions.mix(SENTIEON_BWAINDEX.out.versions)
    versions = versions.mix(BWAMEM2_INDEX.out.versions)
    versions = versions.mix(SAMTOOLS_FAIDX.out.versions)
    versions = versions.mix(PICARD_CREATESEQUENCEDICTIONARY.out.versions)

    emit:
    bwa                   = SENTIEON_BWAINDEX.out.index.map{ meta, index -> [index] }.collect()             // path: bwa/*
    bwamem2               = BWAMEM2_INDEX.out.index.map{ meta, index -> [index] }.collect()                 // path: bwamem2/*
    fasta_fai             = SAMTOOLS_FAIDX.out.fai.map{ meta, fai -> [fai] }                                // path: reference.fa.fai
    fasta_dict            = PICARD_CREATESEQUENCEDICTIONARY.out.reference_dict.map{ meta, dict -> [dict] }  // path: reference.dict
    versions    // channel: [ versions.yml ]                                     
}

