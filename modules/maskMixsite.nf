process maskmix {
	container 'ufuomababatunde/biopython:v1.2.0'

	tag "masking the mix sites in sample $central_id"

	publishDir (
	path: "${params.out_dir}/maskedMixsites",
	mode: "copy",
	overwrite: "true"
	)

	errorStrategy 'ignore'

	input:
	tuple val(central_id), path(fasta), path(bed)


	output:
	tuple val(central_id), path("*.maskedMix.fasta"), emit: maskedMix


	script:
	"""
	cp $bed flag_primerpair_edited.bed

	sed -i 's/MN908947.3/${params.prefix_fasta}${central_id}/g' flag_primerpair_edited.bed

	if [ -s "./flag_primerpair_edited.bed" ]; then
		fa-mask.py --regions flag_primerpair_edited.bed --fasta $fasta --out $params.prefix_fasta${central_id}.maskedMix.fasta
	else
		cat $fasta > $params.prefix_fasta${central_id}.maskedMix.fasta
	fi
	"""
}