# melonmask
 Masking regions flagged to be mix sites and regions with reads in the negative control

```
nextflow run melonmask \
--bammix flagged_barcodes_positions_proportions.csv \
--ref Barcode_Batch_08.csv \
--bam_dir /absolute/path/articNcovNanopore_sequenceAnalysisNanopolish_articMinIONNanopolish \
--fasta_dir /absolute/path/articNcovNanopore_prepRedcap_renameFasta \
--out_dir result
```
