// Workflow for variant calling

//enable dsl2
nextflow.enable.dsl=2

// import modules
include {maskmix} from '../modules/maskMixsite.nf'



workflow MASKMIX {
	take:
		ch_fasta
		ch_bed


	main:
		maskmix(ch_fasta.join(ch_bed))

	emit:
		maskmix_out = maskmix.out.maskedMix


}