

// enable dsl2
nextflow.enable.dsl=2


// import modules
include {primerFlagging} from '../modules/primerRegions.nf'


workflow PRIMERS {
		
	take:
		ch_position


	main:
		primerFlagging(ch_position)

	emit:
		flaggedBed = primerFlagging.out.flaggedPrimer
}