

// enable dsl2
nextflow.enable.dsl=2


// import modules
include {primerFlaggingNEGATIVE} from '../modules/primerRegionsNEGATIVE.nf'


workflow PRIMERSNEGATIVE {
		
	take:
		ch_combinedBAM


	main:
		primerFlaggingNEGATIVE(ch_combinedBAM)

	emit:
		flaggedPrimerNEGATIVE_out = primerFlaggingNEGATIVE.out.flaggedPrimerNEGATIVE
}