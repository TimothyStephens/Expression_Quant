

rule ref_parse_CDS:
	output:
		"resources/{ref_name}/CDS.fna",
	log:
		"results/logs/resources/{ref_name}/ref_parse_genome.log",
	params:
		ref_file=lambda w: config["ref_path"][w.ref_name],
	conda:
		"../envs/bash.yaml"
	shell:
		"( if [[ {params.ref_file} == *.gz ]]; then zcat {params.ref_file} > {output}; else cat {params.ref_file} > {output}; fi ) 1>{log} 2>&1"


rule ref_faidx:
	input:
		"resources/{ref_name}/CDS.fna",
	output:
		"resources/{ref_name}/CDS.fna.fai",
	log:
		"results/logs/resources/{ref_name}/ref_faidx.log",
	conda:
		"../envs/samtools.yaml"
	shell:
		"samtools faidx"
		" {input}"
		" 1>{log} 2>&1"


rule ref_Salmon_index:
	input:
		"resources/{ref_name}/CDS.fna",
	output:
		directory("resources/{ref_name}/CDS.fna.salmon.idx")
	log:
		"results/logs/resources/{ref_name}/ref_Salmon_index.log",
	params:
		extra=config["ref_Salmon_index"]["params"],
	threads: config["ref_Salmon_index"]["threads"]
	conda:
		"../envs/salmon.yaml"
	shell:
		"salmon index"
		" --transcripts {input}"
		" --index {output}"
		" {params.extra}"
		" --threads {threads}"
		" 1>{log} 2>&1"


