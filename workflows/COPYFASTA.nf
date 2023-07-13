// Workflow for extracting positions and sample central ID

// enable dsl2
nextflow.enable.dsl=2


// import modules
include {copyFasta} from '../modules/copyFasta.nf'



workflow COPYFASTA {

	take:
		ch_fasta

	main:
		copyFasta(ch_fasta)


	//emit:
		//fastaList_out = listfasta.out.fastaList_out
}