GENERAL=general/criterios_evaluacion.html general/grupos.html general/programa.html general/reportar.html general/depurar.html
TEMA1=tema1/0101-1-introduccion-pvli.html tema1/0101-2-interpretes_js.html tema1/0102-tooling.html tema1/compilado.dot.svg  tema1/instrucciones.dot.svg  tema1/interpretes.dot.svg  tema1/trabajo_curso.dot.svg  tema1/trabajo_general.dot.svg  tema1/trabajo_manual.dot.svg
TEMA2=
TEMA3=
TEMA4=tema4/0401-introduccion-arquitectura-videojuegos.html tema4/0402-ejemplo-componentes-completo.html tema4/imgs/umlbasico.pu.svg tema4/imgs/herencia.pu.svg tema4/imgs/asociacion.pu.svg tema4/imgs/composicion.pu.svg tema4/imgs/herenciacorrecta.pu.svg  tema4/imgs/herenciaproblema.pu.svg tema4/imgs/sistemascomponentes.pu.svg tema4/imgs/arquitectura.pu.svg
TEMA5=tema5/0501_carga_de_recursos_con_phaser.html tema5/Ejercicio2/Enunciado/ejercicios_tema5.zip
TEMA6=tema6/0603_tiles.html tema6/0604-texto-en-phaser.html tema6/0605-webaudio.html tema6/nodos.dot.svg tema6/0606-audio-en-phaser.html
TEMA7=tema7/0701-phaser-colisiones.html tema7/0702-phaser-colisiones-ninja.html tema7/0703-phaser-el-motor-p2.html 
TEMA8=
TEMA9=
PR3=proyecto/version1/criterios_evaluacion.html  proyecto/version1/especificacion.html

PROYECTO=$(PR3)
TEMAS=$(TEMA1) $(TEMA2) $(TEMA3) $(TEMA4) tema4/0403-ejercicios.html $(TEMA5) $(TEMA6) $(TEMA7) $(TEMA8) $(TEMA9) 
TODO=$(GENERAL) $(TEMAS) $(PROYECTO)
BASERUN=pandoc -S -s --mathjax --filter pandoc-include -M secPrefix= -M figPrefix= -M eqnPrefix= -M tblPrefix= --filter pandoc-crossref
# BASERUN=pandoc  -s --mathjax -M secPrefix= -M figPrefix= -M eqnPrefix= -M tblPrefix= --filter pandoc-crossref

all: $(TODO)

%.html: %.md shared/pvli-template-pandoc.html
	$(BASERUN) -i --slide-level=2 --section-divs --variable revealjs-url=../shared/lib/reveal -t revealjs --template shared/pvli-template-pandoc.html $< -o $@

general/%.html: general/%.md shared/docs.css
	$(BASERUN) --css ../shared/docs.css $< -o $@

proyecto/version1/%.html: proyecto/version1/%.md shared/docs.css
	$(BASERUN) --css ../shared/docs.css $< -o $@

tema4/0403-ejercicios.html: tema4/0403-ejercicios.md shared/docs.css
	$(BASERUN) --css ../shared/docs.css $< -o $@

%.dot.svg: %.dot
	dot -T svg $< -O

tema5/Ejercicio2/Enunciado/EnunciadoEjercicio2.html: tema5/Ejercicio2/Enunciado/EnunciadoEjercicio2.md
	$(BASERUN) --css ../shared/docs.css $< -o $@

tema5/Ejercicio2/Enunciado/ejercicios_tema5.zip: tema5/Ejercicio2/Enunciado/ejercicios_tema5.html tema5/Ejercicio2/Enunciado/gulpfile.js tema5/Ejercicio2/Enunciado/package.json tema5/Ejercicio2/Enunciado/README.md tema5/Ejercicio2/Enunciado/.jshintrc tema5/Ejercicio2/Enunciado/src/*
	cd tema5/Ejercicio2/Enunciado/ && zip -r $(notdir $@) src ejercicios_tema5.html gulpfile.js package.json README.md .jshintrc

%.pu.svg: %.pu
	cat $< | plantuml -p -tsvg > $@

clean: 
	rm -f $(TODO)

.PHONY: all clean
