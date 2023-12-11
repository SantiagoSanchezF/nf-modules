#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { HHSUITE_HHSEARCH } from '../../../../../modules/ebi-metagenomics/hhsuite/hhsearch/main.nf'

workflow test_hhsuite_hhsearch {

    input = [
        [ id:'test' ],
        file("tests/modules/ebi-metagenomics/hhsuite/hhsearch/data/query.a3m", checkIfExists: true)
    ]
    pfam_db = file("/home/vangelis/Desktop/Tools/hh/databases/pfamA_35.0", checkIfExists: true)
    db_name = "pfam"

    HHSUITE_HHSEARCH ( input, pfam_db, db_name )
}
