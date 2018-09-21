GENERAL=general/criterios_evaluacion.html general/grupos.html general/programa.html general/reportar.html general/depurar.html
TEMA1=tema1/introduccion-pvli.html tema1/interpretes_js.html tema1/tooling.html tema1/compilado.dot.svg  tema1/instrucciones.dot.svg  tema1/interpretes.dot.svg  tema1/trabajo_curso.dot.svg  tema1/trabajo_general.dot.svg  tema1/trabajo_manual.dot.svg
TEMA2=
TEMA3=
TEMA5=tema5/introduccion-arquitectura-videojuegos.html tema5/ejemplo-componentes-completo.html tema5/imgs/umlbasico.pu.svg tema5/imgs/herencia.pu.svg tema5/imgs/asociacion.pu.svg tema5/imgs/composicion.pu.svg tema5/imgs/herenciacorrecta.pu.svg  tema5/imgs/herenciaproblema.pu.svg tema5/imgs/sistemascomponentes.pu.svg tema5/imgs/arquitectura.pu.svg tema5/ejercicios.html tema5/introduccion_uml.html tema5/imgs/interface.pu.svg tema5/imgs/composicionuml.pu.svg tema5/imgs/agregacionuml.pu.svg tema5/imgs/herenciafrutas.pu.svg tema5/imgs/muchos.pu.svg tema5/imgs/metodos.pu.svg tema5/imgs/atributos.pu.svg tema5/imgs/frutas.pu.svg


TEMA6=tema6/carga_de_recursos_con_phaser.html tema6/ejercicio/ejercicios_carga.zip
TEMA7=tema7/tiles.html tema7/texto-en-phaser.html tema7/webaudio.html tema7/nodos.dot.svg tema7/audio-en-phaser.html
TEMA8=tema8/phaser-colisiones.html tema8/phaser-colisiones-ninja.html tema8/phaser-el-motor-p2.html
TEMA9=tema9/animacion_con_sprites.html
TEMA10=tema10/proyectos.html
TEMA11=tema11/extensiones.html
PROYECTO1=proyecto/version1/especificacion.html
PROYECTO2=proyecto/version2/especificacion.html
PROYECTO3=proyecto/version3/especificacion.html

PROYECTO=$(PROYECTO1) $(PROYECTO2) $(PROYECTO3) proyecto/criterios_evaluacion.html
TEMAS=$(TEMA1) $(TEMA2) $(TEMA3) $(TEMA4) $(TEMA5) $(TEMA6) $(TEMA7) $(TEMA8) $(TEMA9) $(TEMA10) $(TEMA11)
TODO=$(GENERAL) $(TEMAS) $(PROYECTO)
# BASERUN=pandoc -s --mathjax --filter pandoc-include -M secPrefix= -M figPrefix= -M eqnPrefix= -M tblPrefix= --filter pandoc-crossref

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

tema5/ejercicios.html: tema5/ejercicios.md shared/docs.css
	$(BASERUN) --css ../shared/docs.css -t html+smart $< -o $@

%.dot.svg: %.dot
	dot -T svg $< -O

tema6/ejercicio/ejercicios_carga.html: tema6/ejercicio/ejercicios_carga.md
	$(BASERUN) --css ../../shared/docs.css -t html+smart $< -o $@

tema6/ejercicio/ejercicios_carga.zip: tema6/ejercicio/ejercicios_carga.html tema6/ejercicio/gulpfile.js tema6/ejercicio/package.json tema6/ejercicio/README.md tema6/ejercicio/.jshintrc tema6/ejercicio/src/*
	cd tema6/ejercicio/ && zip -r $(notdir $@) src ejercicios_carga.html gulpfile.js package.json README.md .jshintrc

%.pu.svg: %.pu
	cat $< | plantuml -p -tsvg > $@


%.html: %.md shared/pvli-template-pandoc.html
	# $(BASERUN) --variable revealjs-url=../shared/lib/reveal -t revealjs+smart --template shared/pvli-template-pandoc.html $< -o $@
	$(BASERUN) --variable revealjs-url=../shared/lib/reveal -Vtheme=beige -t revealjs+smart $< -o $@



clean:
	rm -f $(TODO)

.PHONY: all clean
