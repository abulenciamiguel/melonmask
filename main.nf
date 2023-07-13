// Main workflow for masking

// enable dsl2
nextflow.enable.dsl=2


// import subworkflows
include {FLAGS} from './workflows/FLAGS.nf'
include {POSITIONS} from './workflows/POSITIONS.nf'
include {PRIMERS} from './workflows/PRIMERS.nf'
include {LISTFASTA} from './workflows/LISTFASTA.nf'
include {LISTNEGATIVEBAM} from './workflows/LISTNEGATIVEBAM.nf'
include {COPYFASTA} from './workflows/COPYFASTA.nf'
include {MASKMIX} from './workflows/MASKMIX.nf'
include {BAMREGIONS} from './workflows/BAMREGIONS.nf'
include {PRIMERSNEGATIVE} from './workflows/PRIMERSnegative.nf'
include {MASKNEGATIVE} from './workflows/MASKNEGATIVE.nf'




workflow {

	Channel
		.fromPath(params.bammix)
		.set{ch_bammix}

	Channel
		.fromPath(params.ref)
		.set{ch_ref}






	main:
		FLAGS(ch_bammix, ch_ref)

		FLAGS.out.centralID_out.splitCsv(header:true, sep:'\t')
					                 .map{row-> tuple(row.central_id, row.positions)}
					                 .set{ch_position}

		POSITIONS(ch_position)

		PRIMERS(POSITIONS.out.positions_out)

		LISTFASTA(ch_ref, FLAGS.out.prefixFASTA_txt)
	
		LISTFASTA.out.listFasta_out.splitCsv(header:true, sep:',')
					                 .map{row-> tuple(row.central_id, file(row.path))}
					                 .set{ch_fasta}

		//COPYFASTA(ch_fasta)


		LISTNEGATIVEBAM(ch_ref, FLAGS.out.prefixBAM_txt)

		LISTNEGATIVEBAM.out.listBam_out.splitCsv(header:true, sep:',')
					                 .map{row-> tuple(row.central_id, file(row.path), file(row.ont_barcode), file(row.type))}
					                 .set{ch_negativebam}

		BAMREGIONS(ch_negativebam)

		BAMREGIONS.out.bamRegions
								.collectFile(name: "combined.BAM.region.csv", newLine: true,
								storeDir: params.out_dir)
								.set{ch_combinedBAM}

		PRIMERSNEGATIVE(ch_combinedBAM)

		MASKMIX(ch_fasta, PRIMERS.out.flaggedBed)

		MASKNEGATIVE(MASKMIX.out.maskmix_out, PRIMERSNEGATIVE.out.flaggedPrimerNEGATIVE_out)


}


