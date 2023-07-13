// enable dsl2
nextflow.enable.dsl=2


// import modules
include {flaggedNegativeControlRegion} from '../modules/extractBAMregion.nf'


workflow BAMREGIONS {

	take:
		ch_bam


	main:
		flaggedNegativeControlRegion(ch_bam)


	emit:
		bamRegions = flaggedNegativeControlRegion.out.negcontrol_extract


}