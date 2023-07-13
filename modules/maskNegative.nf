process maskNegative {
	container 'ufuomababatunde/biopython:v1.2.0'
	
    tag "masking flagged positions in $central_id"

	publishDir (
	path: "${params.out_dir}/maskedMixNegative",
	mode: "copy",
	overwrite: "true"
	)

	input:
	tuple val(central_id), path(fasta)
	each file(flaggedPrimer)


	output:
	path "*.maskedMixNegative.fasta"


	script:
	"""
	cp $flaggedPrimer flag_primerpair_edited.bed

	sed -i 's/MN908947.3/${params.prefix_fasta}${central_id}/g' flag_primerpair_edited.bed

	fa-mask.py --regions flag_primerpair_edited.bed --fasta $fasta --out $params.prefix_fasta${central_id}.maskedMixNegative.fasta
	"""
}
