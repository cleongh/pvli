GENERAL=general/criterios_evaluacion.html general/grupos.html general/programa.html general/reportar.html general/depurar.html
TEMA1=tema1/0101-1-introduccion-pvli.html tema1/0101-2-interpretes_js.html tema1/0102-tooling.html tema1/compilado.dot.svg  tema1/instrucciones.dot.svg  tema1/interpretes.dot.svg  tema1/trabajo_curso.dot.svg  tema1/trabajo_general.dot.svg  tema1/trabajo_manual.dot.svg
TEMA2=
TEMA3=
TEMA4=tema4/0401-introduccion-arquitectura-videojuegos.html tema4/0402-ejemplo-componentes-completo.html tema4/imgs/umlbasico.pu.svg tema4/imgs/herencia.pu.svg tema4/imgs/asociacion.pu.svg tema4/imgs/composicion.pu.svg tema4/imgs/herenciacorrecta.pu.svg  tema4/imgs/herenciaproblema.pu.svg tema4/imgs/sistemascomponentes.pu.svg tema4/imgs/arquitectura.pu.svg
TEMA5=tema5/0501_carga_de_recursos_con_phaser.html tema5/ejercicio/ejercicios_tema5.zip
TEMA6=tema6/0603_tiles.html tema6/0604-texto-en-phaser.html tema6/0605-webaudio.html tema6/nodos.dot.svg tema6/0606-audio-en-phaser.html
TEMA7=tema7/0701-phaser-colisiones.html tema7/0702-phaser-colisiones-ninja.html tema7/0703-phaser-el-motor-p2.html
TEMA8=tema8/0801-animacion_con_sprites.html
TEMA9=tema9/0901-proyectos.html
TEMA10=tema10/1001-extensiones.html
PROYECTO1=proyecto/version1/especificacion.html
PROYECTO2=proyecto/version2/especificacion.html
PROYECTO3=proyecto/version3/especificacion.html

PROYECTO=$(PROYECTO1) $(PROYECTO2) $(PROYECTO3) proyecto/criterios_evaluacion.html
TEMAS=$(TEMA1) $(TEMA2) $(TEMA3) $(TEMA4) tema4/0403-ejercicios.html $(TEMA5) $(TEMA6) $(TEMA7) $(TEMA8) $(TEMA9) $(TEMA10)
TODO=$(GENERAL) $(TEMAS) $(PROYECTO)
BASERUN=pandoc -s --mathjax --filter pandoc-include -M secPrefix= -M figPrefix= -M eqnPrefix= -M tblPrefix= --filter pandoc-crossref
# BASERUN=pandoc  -s --mathjax -M secPrefix= -M figPrefix= -M eqnPrefix= -M tblPrefix= --filter pandoc-crossref

all: $(TODO)

general/%.html: general/%.md shared/docs.css
	$(BASERUN) --css ../shared/docs.css -t html+smart $< -o $@

proyecto/criterios_evaluacion.html: proyecto/criterios_evaluacion.md shared/docs.css
	$(BASERUN) --css ../shared/docs.css -t html+smart $< -o $@

proyecto/version1/%.html: proyecto/version1/%.md shared/docs.css
	$(BASERUN) --css ../../shared/docs.css -t html+smart $< -o $@

proyecto/version2/%.html: proyecto/version2/%.md shared/docs.css
	$(BASERUN) --css ../../shared/docs.css -t html+smart $< -o $@

proyecto/version3/%.html: proyecto/version3/%.md shared/docs.css
	$(BASERUN) --css ../../shared/docs.css -t html+smart $< -o $@

tema4/0403-ejercicios.html: tema4/0403-ejercicios.md shared/docs.css
	$(BASERUN) --css ../shared/docs.css -t html+smart $< -o $@

%.dot.svg: %.dot
	dot -T svg $< -O

tema5/ejercicio/ejercicios_tema5.html: tema5/ejercicio/ejercicios_tema5.md
	$(BASERUN) --css ../../shared/docs.css -t html+smart $< -o $@

tema5/ejercicio/ejercicios_tema5.zip: tema5/ejercicio/ejercicios_tema5.html tema5/ejercicio/gulpfile.js tema5/ejercicio/package.json tema5/ejercicio/README.md tema5/ejercicio/.jshintrc tema5/ejercicio/src/*
	cd tema5/ejercicio/ && zip -r $(notdir $@) src ejercicios_tema5.html gulpfile.js package.json README.md .jshintrc

%.pu.svg: %.pu
	cat $< | plantuml -p -tsvg > $@


%.html: %.md shared/pvli-template-pandoc.html
	# $(BASERUN) -i --slide-level=2 --section-divs --variable revealjs-url=../shared/lib/reveal -t revealjs+smart --template shared/pvli-template-pandoc.html $< -o $@
	$(BASERUN) -i --variable revealjs-url=../shared/lib/reveal -t revealjs+smart --template shared/pvli-template-pandoc.html $< -o $@


clean:
	rm -f $(TODO)

.PHONY: all clean
