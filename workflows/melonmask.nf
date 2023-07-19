// Main workflow for masking

// enable dsl2
nextflow.enable.dsl=2


// import subworkflows
include {barcodeTocentralID} from '../modules/centralID.nf'
include {flaggedMixsite} from '../modules/extractMixsite.nf'
include {primerFlagging} from '../modules/primerRegions.nf'
include {listFasta} from '../modules/listFasta.nf'
include {listBam} from '../modules/listBam.nf'
include {flaggedNegativeControlRegion} from '../modules/extractBAMregion.nf'
include {primerFlaggingNEGATIVE} from '../modules/primerRegionsNEGATIVE.nf'
include {maskmix} from '../modules/maskMixsite.nf'
include {maskNegative} from '../modules/maskNegative.nf'



workflow melonmask {

	take:
		ch_bammix
        ch_ref




	main:
		barcodeTocentralID(ch_bammix, ch_ref)

        barcodeTocentralID.out.barcodeCentralID.splitCsv(header:true, sep:'\t')
				.map{row-> tuple(row.central_id, row.positions)}
				.set{ch_position}


        flaggedMixsite(ch_position)

        primerFlagging(flaggedMixsite.out.bammix_extract)


        listFasta(ch_ref, barcodeTocentralID.out.prefixFASTA)


		listFasta.out.list_out.splitCsv(header:true, sep:',')
				.map{row-> tuple(row.central_id, file(row.path))}
				.set{ch_fasta}


		listBam(ch_ref, barcodeTocentralID.out.prefixBAM)

		listBam.out.list_out.splitCsv(header:true, sep:',')
                .map{row-> tuple(row.central_id, file(row.path), file(row.ont_barcode), file(row.type))}
				.set{ch_negativebam}


        flaggedNegativeControlRegion(ch_negativebam)

		flaggedNegativeControlRegion.out.negcontrol_extract
				.collectFile(name: "combined.BAM.region.csv", newLine: true,
				storeDir: params.out_dir)
				.set{ch_combinedBAM}


        primerFlaggingNEGATIVE(ch_combinedBAM)

		maskmix(ch_fasta, primerFlagging.out.flaggedPrimer)

		maskNegative(maskmix.out.maskedMix, primerFlaggingNEGATIVE.out.flaggedPrimerNEGATIVE)

		//centralID_out = barcodeTocentralID.out.barcodeCentralID
		//prefixBAM_txt = barcodeTocentralID.out.prefixBAM
		//prefixFASTA_txt = barcodeTocentralID.out.prefixFASTA


        //FLAGS(ch_bammix, ch_ref)

		//FLAGS.out.centralID_out.splitCsv(header:true, sep:'\t')
		//			                 .map{row-> tuple(row.central_id, row.positions)}
		//			                 .set{ch_position}

		//POSITIONS(ch_position)

		//PRIMERS(POSITIONS.out.positions_out)

		//LISTFASTA(ch_ref, FLAGS.out.prefixFASTA_txt)
	
		//LISTFASTA.out.listFasta_out.splitCsv(header:true, sep:',')
		//			                 .map{row-> tuple(row.central_id, file(row.path))}
		//			                 .set{ch_fasta}


		//LISTNEGATIVEBAM(ch_ref, FLAGS.out.prefixBAM_txt)

		//LISTNEGATIVEBAM.out.listBam_out.splitCsv(header:true, sep:',')
		//			                 .map{row-> tuple(row.central_id, file(row.path), file(row.ont_barcode), file(row.type))}
		//			                 .set{ch_negativebam}

		//BAMREGIONS(ch_negativebam)

		//BAMREGIONS.out.bamRegions
		//						.collectFile(name: "combined.BAM.region.csv", newLine: true,
		//						storeDir: params.out_dir)
		//						.set{ch_combinedBAM}

		//PRIMERSNEGATIVE(ch_combinedBAM)

		//MASKMIX(ch_fasta, PRIMERS.out.flaggedBed)

		//MASKNEGATIVE(MASKMIX.out.maskmix_out, PRIMERSNEGATIVE.out.flaggedPrimerNEGATIVE_out)


}


