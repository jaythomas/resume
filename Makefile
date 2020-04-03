# Install pandoc and texlive-core to run this file!

OUT_DIR=.
OUT_FILE_NAME=resume
INPUT_FILE_NAME=README.md
STYLES_DIR=styles
STYLE=chmduquesne

all: clean html pdf

pdf: clean
	echo $(OUT_FILE_NAME).pdf; \
	pandoc --standalone --template $(STYLES_DIR)/$(STYLE).tex \
		--from markdown --to context \
		--variable papersize=A4 \
		--output $(OUT_DIR)/$(OUT_FILE_NAME).tex $(INPUT_FILE_NAME) > /dev/null; \
	mtxrun --path=$(OUT_DIR) --result=$(OUT_FILE_NAME).pdf --script context $(OUT_FILE_NAME).tex > /dev/null; \
	rm ${OUT_DIR}/$(OUT_FILE_NAME).log ${OUT_DIR}/$(OUT_FILE_NAME).tex ${OUT_DIR}/$(OUT_FILE_NAME).tuc; \

html: clean
	echo $(OUT_FILE_NAME).html; \
	pandoc --standalone --include-in-header $(STYLES_DIR)/$(STYLE).css \
		--lua-filter=pdc-links-target-blank.lua \
		--from markdown --to html \
		--output $(OUT_DIR)/$(OUT_FILE_NAME).html $(INPUT_FILE_NAME) \
		--metadata pagetitle=$(OUT_FILE_NAME);

clean:
	rm -f $(OUT_FILE_NAME).html $(OUT_FILE_NAME).pdf
