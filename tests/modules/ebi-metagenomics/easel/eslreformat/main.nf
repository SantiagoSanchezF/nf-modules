#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { EASEL_ESLREFORMAT } from '../../../../../modules/ebi-metagenomics/easel/eslreformat/main.nf'

workflow test_easel_eslreformat {

    input = [
        [ id:'test' ],
        file("/home/vangelis/Desktop/Projects/mgnifams/data/output/families/msa/mgnfam15_380.fa", checkIfExists: true)
        //"/home/vangelis/Desktop/Projects/mgnifams/data/output/families/seed_msa/mgnfam15_380.fa"
    ]

    EASEL_ESLREFORMAT ( input, "a2m" )
}
