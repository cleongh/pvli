GNERAL=general/criterios_evaluacion.html general/grupos.html general/programa.html
TEMA1=tema1/0101-1-introduccion-pvli.html tema1/0101-2-interpretes_js.html tema1/0102-tooling.html tema1/compilado.dot.svg  tema1/instrucciones.dot.svg  tema1/interpretes.dot.svg  tema1/trabajo_curso.dot.svg  tema1/trabajo_general.dot.svg  tema1/trabajo_manual.dot.svg
TEMA2=
TEMA3=
TEMA4=tema4/0401-introduccion-arquitectura-videojuegos.html tema4/0402-ejemplo-componentes-completo.html tema4/imgs/umlbasico.pu.svg tema4/imgs/herencia.pu.svg tema4/imgs/asociacion.pu.svg tema4/imgs/composicion.pu.svg tema4/imgs/herenciacorrecta.pu.svg  tema4/imgs/herenciaproblema.pu.svg tema4/imgs/sistemascomponentes.pu.svg tema4/imgs/arquitectura.pu.svg
TEMA5=tema5/0501_carga_de_recursos_con_phaser.html
TEMA6=
TEMA7=tema7/0701_tiles.html tema7/0702-texto-en-phaser.html
TEMA8=
TEMA9=

TEMAS=$(TEMA1) $(TEMA2) $(TEMA3) $(TEMA4) tema4/0403-ejercicios.html $(TEMA5) $(TEMA6) $(TEMA7) $(TEMA8) $(TEMA9) 
TODO=$(GENERAL) $(TEMAS)
BASERUN=pandoc  -s --mathjax --filter pandoc-include -M secPrefix= -M figPrefix= -M eqnPrefix= -M tblPrefix= --filter pandoc-crossref
# BASERUN=pandoc  -s --mathjax -M secPrefix= -M figPrefix= -M eqnPrefix= -M tblPrefix= --filter pandoc-crossref

all: $(TODO)

%.html: %.md shared/pvli-template-pandoc.html
	$(BASERUN) -i --slide-level=2 --section-divs --variable revealjs-url=../shared/lib/reveal -t revealjs --template shared/pvli-template-pandoc.html $< -o $@

general/%.html: general/%.md shared/docs.css
	$(BASERUN) --css ../shared/docs.css $< -o $@

tema4/0403-ejercicios.html: tema4/0403-ejercicios.md shared/docs.css
	$(BASERUN) --css ../shared/docs.css $< -o $@

%.dot.svg: %.dot
	dot -T svg $< -O

%.pu.svg: %.pu
	cat $< | plantuml -p -tsvg > $@

clean: 
	rm -f $(TODO)

.PHONY: all clean
