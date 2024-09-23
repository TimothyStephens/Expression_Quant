# Salmon_Quant
Snakemake workflow to automatically quantify gene expression with Salmon using local and SRA samples

## Documentation
[Setup and installation](https://github.com/TimothyStephens/Expression_Quant/wiki#setup-and-installation)
[Workflow config](https://github.com/TimothyStephens/Expression_Quant/wiki#workflow-config)
[Running the workflow](https://github.com/TimothyStephens/Expression_Quant/wiki#running-the-workflow)
[Results explanation](https://github.com/TimothyStephens/Expression_Quant/wiki#results)

[Run tests](https://github.com/TimothyStephens/Expression_Quant/wiki/Test_Example)



## Credits
This workflow is based on (and borrows code from) my [Genomtype_Samples](https://github.com/TimothyStephens/Genotype_Samples) snakemake workflow.
Which, in turn is based on the [deepvariant workflow](https://github.com/nikostr/dna-seq-deepvariant-glnexus-variant-calling) and [Metagenome-Atlas](https://github.com/metagenome-atlas/atlas) workflows.

Conda packages used by this workflow:
`for F in workflow/envs/*.yaml; do awk '{ if($1=="dependencies:"){F=1}else{if(F==1){print}} }' $F; done | sort | uniq`
  - fastp=0.23.2
  - fastqc=0.12.1
  - multiqc=1.14
  - pigz=2.6
  - python=3.11.0
  - salmon=1.10.2
  - samtools=1.16.1
  - sra-tools=3.0.5

