

def get_fastq_pe(wildcards):
	fastqs = samples.loc[(wildcards.sample, wildcards.unit, "pe"), ["fq1", "fq2"]]
	if fastqs.fq1.startswith("DRR") or fastqs.fq1.startswith("ERR") or fastqs.fq1.startswith("SRR"):
		return {"sample": [
				"data/pe/{}_1.fastq.gz".format(fastqs.fq1), 
				"data/pe/{}_2.fastq.gz".format(fastqs.fq2),
				]}
	else:
		return {"sample": [fastqs.fq1, fastqs.fq2]}

def get_fastq_se(wildcards):
	fastqs = samples.loc[(wildcards.sample, wildcards.unit, "se"), ["fq1"]]
	if fastqs.fq1.startswith("DRR") or fastqs.fq1.startswith("ERR") or fastqs.fq1.startswith("SRR"):
		return {"sample": ["data/se/{}.fastq.gz".format(fastqs.fq1)]}
	else:
		return {"sample": [fastqs.fq1]}


rule trimming_pe:
	input:
		unpack(get_fastq_pe),
	output:
		trimmed=[
			temp("results/trimmed/pe/{sample}-{unit}.1.fastq.gz"),
			temp("results/trimmed/pe/{sample}-{unit}.2.fastq.gz"),
		],
		html="results/qc/trimmed/pe/{sample}-{unit}.html",
		json="results/qc/trimmed/pe/{sample}-{unit}_fastp.json",
	log:
		"results/logs/trimmed/pe/{sample}-{unit}.log",
	params:
		extra=config["trimming_pe"]["params"],
	threads: config["trimming_pe"]["threads"]
	conda:
		"../envs/fastp.yaml"
	shell:
		"fastp"
		" --in1 {input[0]}"
		" --in2 {input[1]}"
		" --out1 {output.trimmed[0]}"
		" --out2 {output.trimmed[1]}"
		" --json {output.json}"
		" --html {output.html}"
		" --thread {threads}"
		" {params.extra}"
		" 1>{log} 2>&1"


rule trimming_se:
	input:
		unpack(get_fastq_se),
	output:
		trimmed=[temp("results/trimmed/se/{sample}-{unit}.1.fastq.gz")],
		html="results/qc/trimmed/se/{sample}-{unit}.html",
		json="results/qc/trimmed/se/{sample}-{unit}_fastp.json",
	log:
		"results/logs/trimmed/se/{sample}-{unit}.log",
	params:
		extra=config["trimming_se"]["params"],
	threads: config["trimming_se"]["threads"]
	conda:
		"../envs/fastp.yaml"
	shell:
		"fastp"
		" --in1 {input[0]}"
		" --out1 {output.trimmed[0]}"
		" --json {output.json}"
		" --html {output.html}"
		" --thread {threads}"
		" {params.extra}"
		" 1>{log} 2>&1"


