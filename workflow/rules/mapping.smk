

rule mapping_Salmon_Quant_pe:
	input:
		reads=rules.trimming_pe.output.trimmed,
		idx=rules.ref_Salmon_index.output,
	output:
		directory("results/mapping/{ref_name}/pe/{sample}-{unit}.salmon"),
	log:
		"results/logs/mapping/{ref_name}/pe/{sample}-{unit}.log",
	params:
		extra=config["mapping_Salmon_Quant_pe"]["params"],
	priority: 20
	threads: config["mapping_Salmon_Quant_pe"]["threads"]
	conda:
		"../envs/salmon.yaml"
	shell:
		"("
		"rm -fr {output}; "
		"salmon quant"
		" {params.extra}"
		" --index {input.idx}"
		" --libType A"
		" --mates1 {input.reads[0]} --mates2 {input.reads[1]}"
		" --output {output}"
		" --threads {threads}"
		")"
		" 1>{log} 2>&1"


rule mapping_Salmon_Quant_se:
	input:
		reads=rules.trimming_se.output.trimmed,
		idx=rules.ref_Salmon_index.output,
	output:
		outdir=directory("results/mapping/{ref_name}/se/{sample}-{unit}.salmon"),
		quant="results/mapping/{ref_name}/se/{sample}-{unit}.salmon/quant.sf",
	log:
		"results/logs/mapping/{ref_name}/se/{sample}-{unit}.log",
	params:
		extra=config["mapping_Salmon_Quant_se"]["params"],
	priority: 20
	threads: config["mapping_Salmon_Quant_se"]["threads"]
	conda:
		"../envs/salmon.yaml"
	shell:
		"("
		"rm -fr {output}; "
		"salmon quant"
		" {params.extra}"
		" --index {input.idx}"
		" --libType A"
		" --unmatedReads {input.reads[0]}"
		" --output {output}"
		" --threads {threads}"
		")"
		" 1>{log} 2>&1"


rule mapping_Salmon_Quantmerge_numreads:
	input:
		unpack(get_salmon_outdirs),
	output:
		"results/{project}/mapping/salmon.numreads.tsv",
	log:
		"results/logs/{project}/mapping/salmon_quantmerge_numreads.log",
	conda:
		"../envs/salmon.yaml"
	shell:
		"("
		"salmon quantmerge"
		" --column numreads"
		" --output {output}"
		" --quants {input}; "
		"sed -i -e '1 s/\.salmon//g' {output}; "
		")"
		" 1>{log} 2>&1"


rule mapping_Salmon_Quantmerge_tpm:
	input:
		unpack(get_salmon_outdirs),
	output:
		"results/{project}/mapping/salmon.tpm.tsv",
	log:
		"results/logs/{project}/mapping/salmon_quantmerge_tpm.log",
	conda:
		"../envs/salmon.yaml"
	shell:
		"("
		"salmon quantmerge"
		" --column tpm"
		" --output {output}"
		" --quants {input}; "
		"sed -i -e '1 s/\.salmon//g' {output}; "
		")"
		" 1>{log} 2>&1"


