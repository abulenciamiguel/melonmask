// enable dsl2
nextflow.enable.dsl=2


// import modules
include {listFasta} from '../modules/listFasta.nf'



workflow LISTFASTA {

	take:
		ch_ref
		ch_prfxFASTA


	main:
		listFasta(ch_ref, ch_prfxFASTA)


	emit:
		listFasta_out = listFasta.out.list_out
}