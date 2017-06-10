# Offers "make clean" too.
# If files thought1 and thought2 exists,
# then you can create|update file "speech" with "make speech".

outdir=data,in-file-refactored
codedir=in-file-refactor,code

all: $(outdir)/general.csv $(outdir)/education.csv $(outdir)/land.csv $(outdir)/gov.csv $(outdir)/health.csv $(outdir)/conflict.csv

$(outdir)/general.csv: csv/general.csv
	Rscript $(codedir)/general.R
$(outdir)/education.csv: csv/education.csv
	Rscript $(codedir)/education.R
$(outdir)/land.csv: csv/land.csv
	Rscript $(codedir)/land.R
$(outdir)/gov.csv: csv/gov.csv
	Rscript $(codedir)/gov.R
$(outdir)/health.csv: csv/health.csv
	Rscript $(codedir)/health.R
$(outdir)/conflict.csv: csv/conflict.csv
	Rscript $(codedir)/conflict.R
