

rule multiqc:
	input:
		expand("results/qc/raw/{fq}_fastqc.zip", fq=expand_raw_fastqc_paths()),
		expand("results/qc/trimmed/{fq}_fastqc.zip", fq=expand_fastq_paths()),
		expand("results/qc/trimmed/{fq}_fastp.json", fq=expand_sample_paths()),
		unpack(get_salmon_outdirs),
	output:
		report(
			"results/{project}/qc/multiqc.html",
			caption="../report/multiqc.rst",
			subcategory="MultiQC",
			labels={"QC": "Reads and Mapping"},
		),
	log:
		"results/logs/{project}/qc/multiqc.log",
	params:
		extra=config["qc_multiqc"]["params"],
	conda:
		"../envs/multiqc.yaml"
	shell:
		"output_dir=$(dirname {output}); "
		"output_name=$(basename {output}); "
		"multiqc"
		" {params.extra}"
		" --config workflow/report/multiqc_config.yaml"
		" --force"
		" -o $output_dir"
		" -n $output_name"
		" {input}"
		" 1>{log} 2>&1"


