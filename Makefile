BUILD := $(shell git rev-parse --short HEAD)
PROJECTNAME := $(shell basename "$(PWD)")

generate-diagrams:
	./bin/generate_plant_uml_png.sh
