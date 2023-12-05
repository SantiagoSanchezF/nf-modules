#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { HHSUITE_HHBLITS } from '../../../../../modules/ebi-metagenomics/hhsuite/hhblits/main.nf'

workflow test_hhsuite_hhblits {

    input = [
        [ id:'test' ],
        file("tests/modules/ebi-metagenomics/hhsuite/hhblits/data/query.a3m", checkIfExists: true)
    ]
    pfam_db = file("/home/vangelis/Desktop/Tools/hh/databases/pfamA_35.0", checkIfExists: true)
    db_name = "pfam"

    HHSUITE_HHBLITS ( input, pfam_db, db_name )
}
