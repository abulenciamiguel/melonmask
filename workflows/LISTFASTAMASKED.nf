// enable dsl2
nextflow.enable.dsl=2


// import modules
include {listFastaMasked} from '../modules/listFastaMasked.nf'



workflow LISTFASTAMASKED {

	take:
		list_out


	main:
		listFastaMasked(list_out)


	emit:
		listFastaMasked_out = listFastaMasked.out.list_out
}