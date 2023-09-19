
include { FASTP      } from '../../../modules/ebi-metagenomics/fastp/main'
include { SEQTK_SEQ     } from '../../../modules/ebi-metagenomics/seqtk/seq/main'

workflow  READS_QC {

    take:
    ch_reads // channel: [ val(meta), [ fastq ] ]

    main:

    ch_versions = Channel.empty()

    FASTP ( ch_reads, params.save_trimmed_fail, params.save_merged )
    ch_versions = ch_versions.mix(FASTP.out.versions.first())

    SEQTK_SEQ ( FASTP.out.reads_merged )
    ch_versions = ch_versions.mix(SEQTK_SEQ.out.versions.first())

    emit:
    reads              = FASTP.out.reads           // channel: [ val(meta), [ fastq ] ]
    reads_merged       = FASTP.out.reads_merged    // channel: [ val(meta), [ fastq ] ]
    fastp_summary_json = FASTP.out.json            // channel: [ val(meta), [ json ] ]
    reads_fasta        = SEQTK_SEQ.out.fastx       // channel: [ val(meta), [ fasta ] ]
    versions           = ch_versions               // channel: [ versions.yml ]
}

