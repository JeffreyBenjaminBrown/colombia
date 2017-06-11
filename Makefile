# PITFALL: trailing whitespace breaks these
outdir := data/in-file-refactored
codedir := code/in-file-refactor


# goal sets
.PHONY: most singles

output: data/merged.csv singles

zips: $(outdir)/conflict.csv.bz2 $(outdir)/education.csv.bz2 \
      $(outdir)/gov.csv.bz2 $(outdir)/land.csv.bz2

singles: $(outdir)/general.csv $(outdir)/education.csv $(outdir)/land.csv $(outdir)/gov.csv $(outdir)/health.csv $(outdir)/conflict.csv

# raw_csv: data/csv/gov.csv data/csv/general.csv data/csv/land.csv data/csv/health.csv data/csv/education.csv data/csv/conflict.csv


# single-file goals
data/merged.csv: code/merge.R $(outdir)/general.csv $(outdir)/education.csv $(outdir)/land.csv $(outdir)/gov.csv $(outdir)/health.csv $(outdir)/conflict.csv
	Rscript code/merge.R

$(outdir)/general.csv: $(codedir)/general.R data/csv/general.csv
	Rscript $(codedir)/general.R
$(outdir)/education.csv: $(codedir)/education.R data/csv/education.csv
	Rscript $(codedir)/education.R
$(outdir)/land.csv: $(codedir)/land.R data/csv/land.csv
	Rscript $(codedir)/land.R
$(outdir)/gov.csv: $(codedir)/gov.R data/csv/gov.csv
	Rscript $(codedir)/gov.R
$(outdir)/health.csv: $(codedir)/health.R data/csv/health.csv
	Rscript $(codedir)/health.R
$(outdir)/conflict.csv: $(codedir)/conflict.R data/csv/conflict.csv
	Rscript $(codedir)/conflict.R

# TODO ? why do these next 12 always run, even if the dependencies are unchanged?
# (I also tried this idiom, where -f means "force overwrite":
    # $(outdir)/conflict.csv.bz2: $(outdir)/conflict.csv
    # 	bzip2 -kf $(outdir)/conflict.csv
$(outdir)/conflict.csv.bz2: $(outdir)/conflict.csv
	rm $(outdir)/conflict.csv.bz2
	bzip2 -k $(outdir)/conflict.csv
$(outdir)/education.csv.bz2: $(outdir)/education.csv
	rm $(outdir)/education.csv.bz2
	bzip2 -k $(outdir)/education.csv
$(outdir)/gov.csv.bz2: $(outdir)/gov.csv
	rm $(outdir)/gov.csv.bz2
	bzip2 -k $(outdir)/gov.csv
$(outdir)/land.csv.bz2: $(outdir)/land.csv
	rm $(outdir)/land.csv.bz2
	bzip2 -k $(outdir)/land.csv

data/csv/conflict.csv: data/csv/conflict.csv.bz2
	bzip2 -dkf data/csv/conflict.csv.bz2
data/csv/education.csv: data/csv/education.csv.bz2
	bzip2 -dkf data/csv/education.csv.bz2
data/csv/general.csv: data/csv/general.csv.bz2
	bzip2 -dkf data/csv/general.csv.bz2
data/csv/gov.csv: data/csv/gov.csv.bz2
	bzip2 -dkf data/csv/gov.csv.bz2
data/csv/health.csv: data/csv/health.csv.bz2
	bzip2 -dkf data/csv/health.csv.bz2
data/csv/land.csv: data/csv/land.csv.bz2
	bzip2 -dkf data/csv/land.csv.bz2
