process FOLDSEEK_EASYSEARCH {
    tag "$meta.id"
    label 'process_medium'

    conda "bioconda::foldseek=8.ef4e960"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/foldseek:8.ef4e960--pl5321hb365157_0':
        'biocontainers/foldseek:8.ef4e960--pl5321hb365157_0' }"

    input:
    tuple val(meta), path(pdb)
    tuple val(meta), path(db)

    output:
    tuple val(meta), path("${meta.id}.m8"), emit: aln
    path "versions.yml"                   , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"

    """
    mkdir -p data
    mv ${pdb} data/

    foldseek \\
        easy-search \\
        data/${pdb} \\
        data/ \\
        ${prefix}.m8 \\
        ${db} \\
        ${args}

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        foldseek: \$(foldseek --help | grep Version | sed 's/.*Version: //')
    END_VERSIONS
    """

    stub:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"

    """
    touch ${prefix}.m8

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        foldseek: \$(foldseek --help | grep Version | sed 's/.*Version: //')
    END_VERSIONS
    """
}
