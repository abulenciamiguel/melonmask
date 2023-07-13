// enable dsl2
nextflow.enable.dsl=2


// import modules
include {listBam} from '../modules/listBam.nf'
//include {flaggedNegativeControlRegion} from '../modules/extractBAMregion.nf'


workflow LISTNEGATIVEBAM {

	take:
		ch_bam
		ch_prfxBAMtxt


	main:
		listBam(ch_bam, ch_prfxBAMtxt)


	emit:
		listBam_out = listBam.out.list_out
}