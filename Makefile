outdir=data,in-file-refactored
codedir=in-file-refactor,code



# goal sets
.PHONY: all csv zips
all: $(outdir)/merged.csv csv zips

csv: $(outdir)/general.csv $(outdir)/education.csv $(outdir)/land.csv $(outdir)/gov.csv $(outdir)/health.csv $(outdir)/conflict.csv

zips: $(outdir)/conflict.csv.bz2 $(outdir)/education.csv.bz2 \
      $(outdir)/gov.csv.bz2 $(outdir)/land.csv.bz2


# single-file goals
$(outdir)/merged.csv: $(codedir)/merge.R $(outdir)/general.csv $(outdir)/education.csv $(outdir)/land.csv $(outdir)/gov.csv $(outdir)/health.csv $(outdir)/conflict.csv
	Rscript $(codedir)/merge.R

$(outdir)/general.csv: $(codedir)/general.R csv/general.csv
	Rscript $(codedir)/general.R
$(outdir)/education.csv: $(codedir)/education.R csv/education.csv
	Rscript $(codedir)/education.R
$(outdir)/land.csv: $(codedir)/land.R csv/land.csv
	Rscript $(codedir)/land.R
$(outdir)/gov.csv: $(codedir)/gov.R csv/gov.csv
	Rscript $(codedir)/gov.R
$(outdir)/health.csv: $(codedir)/health.R csv/health.csv
	Rscript $(codedir)/health.R
$(outdir)/conflict.csv: $(codedir)/conflict.R csv/conflict.csv
	Rscript $(codedir)/conflict.R

$(outdir)/conflict.csv.bz2: $(outdir)/conflict.csv
	bzip2 -kf $(outdir)/conflict.csv
$(outdir)/education.csv.bz2: $(outdir)/education.csv
	bzip2 -kf $(outdir)/education.csv
$(outdir)/gov.csv.bz2: $(outdir)/gov.csv
	bzip2 -kf $(outdir)/gov.csv
$(outdir)/land.csv.bz2: $(outdir)/land.csv
	bzip2 -kf $(outdir)/land.csv
