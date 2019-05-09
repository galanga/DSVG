build: dsvg.xsl

test: dsvg.xsl tests/*.bash
	bats tests/*.bash


dsvg.xsl: src/dsvg.pug Makefile
	pug < src/dsvg.pug -P > dsvg.xsl

