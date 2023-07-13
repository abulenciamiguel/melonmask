// Workflow for extracting positions and sample central ID

// enable dsl2
nextflow.enable.dsl=2


// import modules
include {flaggedMixsite} from '../modules/extractMixsite.nf'


workflow POSITIONS {
		
	take:
		ch_position


	main:
		flaggedMixsite(ch_position)


	emit:
		positions_out = flaggedMixsite.out.bammix_extract
}