process EASEL_ESLREFORMAT {
    tag "$meta.id"
    label 'process_single'

    conda "${moduleDir}/environment.yml"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/easel:0.49--h031d066_0':
        'biocontainers/easel:0.49--h031d066_0' }"

    input:
    tuple val(meta), path(fasta)
    val(type)

    output:
    tuple val(meta), path("*.fa"), emit: fa
    path "versions.yml"          , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    """
    esl-reformat \\
        $args \\
        -o ${prefix}.fa \\
        ${type} \\
        ${fasta}

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        easel: \$(easel --version)
    END_VERSIONS
    """

    stub:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    """
    touch ${prefix}.fa

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        easel: \$(easel --version)
    END_VERSIONS
    """
}
