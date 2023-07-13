process flaggedNegativeControlRegion {
	cpus 1

    container 'ufuomababatunde/samtools:v1.17--python3'

    tag "Extracting flagged positions of negative control $central_id"

	publishDir (
	path: "${params.out_dir}/positionsFlaggedNegControl",
	mode: "copy",
	overwrite: "true"
	)

	input:
	tuple val(central_id), path(path), path(ont_barcode), path(type)


	output:
	path "negative.*.csv", emit: negcontrol_extract


	script:
	"""
	extract_negcontrol.py \
	--bam $path \
	--out negative.${central_id}.csv
	"""


}