htarg := docs

VAR2=$(shell printf '%02d' $(VAR))
REGEX=$(shell printf "^\./%s.*\.Rmd$$" $(VAR2))
CFILE=$(shell find ./ -type f -regextype posix-extended -regex '$(REGEX)')

.PHONY : book
book : clean 
	Rscript -e 'bookdown::render_book("index.Rmd", output_dir = "$(htarg)")'
	cp -r ../slides/ docs/
	zip -r docs/reading-lmem.zip docs/

chapter :
	Rscript -e 'bookdown::preview_chapter("$(CFILE)", output_dir = "docs")' 

chapterpdf :
	Rscript -e 'bookdown::preview_chapter("$(CFILE)", output_dir = "pdf", output_format = "bookdown::pdf_book")'

clean :
	Rscript -e 'bookdown::clean_book(TRUE)'
