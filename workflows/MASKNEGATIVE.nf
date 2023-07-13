// Workflow for variant calling

//enable dsl2
nextflow.enable.dsl=2

// import modules
include {maskNegative} from '../modules/maskNegative.nf'



workflow MASKNEGATIVE {
	take:
		ch_fasta
		ch_bed


	main:
		maskNegative(ch_fasta, ch_bed)




}