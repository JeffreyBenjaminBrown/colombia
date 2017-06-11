# Table of contents

### How to build the data
### What this repository is
### Credits


# How to build this data

You'll need R, make and bzip2 installed.

Git clone the repository to a folder:
```
https://github.com/JeffreyBenjaminBrown/colombia
```

That creates a folder called "colombia" with this stuff in it. Go there:
```
cd colombia
```

Now you have the raw data and the code, but not all the output data. Make that:
```
make output
```

Now you have a data set (under 'data/' called 'merged.csv'. It contains what's in the six individual files, cleaned, homogenized, and merged on city and year.


# What this repository is

This is code for data construction and analysis. It uses Colombia's "Panel Municipal CEDE", a yearly panel of cities from 1993 to 2015 covering government, education, health care, land and agriculture, conflict, and "caracteristicas generales". Jeff got it from the .dta files in [Luis's shared DropBox folder](https://www.dropbox.com/sh/3vwshykuw8l7z40/AACvyFjDSCz6ztLhUJNJqUWWa?dl=0), and converted them to .csv format using the code at 'code/not-or-barely-using/python/file-io-and-merges.py`.


# Credits
el Centro de Estudios sobre Desarrollo Económico
   , Universidad de los Andes
   , Bogota, Colombia
Luis Carlos Reyes
Larry Hignight
Jeff Brown
