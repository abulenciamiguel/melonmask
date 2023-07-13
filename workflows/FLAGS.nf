// Workflow for extracting positions and sample central ID

// enable dsl2
nextflow.enable.dsl=2


// import modules
include {barcodeTocentralID} from '../modules/centralID.nf'



workflow FLAGS {

	take:
		ch_bammix
		ch_ref


	main:
		barcodeTocentralID(ch_bammix, ch_ref)


	emit:
		centralID_out = barcodeTocentralID.out.barcodeCentralID
		prefixBAM_txt = barcodeTocentralID.out.prefixBAM
		prefixFASTA_txt = barcodeTocentralID.out.prefixFASTA
		//emptyFile_out = barcodeTocentralID.out.emptyFile
}