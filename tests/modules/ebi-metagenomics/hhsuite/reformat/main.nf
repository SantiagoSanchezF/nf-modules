#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { HHSUITE_REFORMAT } from '../../../../../modules/ebi-metagenomics/hhsuite/reformat/main.nf'

workflow test_hhsuite_reformat {

    input = [
        [ id:'test' ],
        file("/home/vangelis/Desktop/Projects/nf-modules/tests/modules/ebi-metagenomics/hhsuite/reformat/data/test.sto", checkIfExists: true)
    ]
    informat = "sto"
    outformat = "a3m"

    HHSUITE_REFORMAT ( input, informat, outformat )
}
