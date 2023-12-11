#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { HHSUITE_HHSUITEDB } from '../../../../../modules/ebi-metagenomics/hhsuite/hhsuitedb/main.nf'

workflow test_hhsuite_hhsuitedb {

    input = [
        [ id:'test' ],
        file("/home/vangelis/Desktop/Projects/nf-modules/tests/modules/ebi-metagenomics/hhsuite/hhsuitedb/data/test.a3m", checkIfExists: true)
    ]

    HHSUITE_HHSUITEDB ( input )
}
