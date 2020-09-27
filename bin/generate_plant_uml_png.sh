#!/bin/sh
# converts all puml files to png

BASEDIR=$(dirname "$0")
mkdir -p "$BASEDIR"/dist
rm "$BASEDIR"/dist/*
for FILE in $BASEDIR/diagrams/*.puml; do
  echo Converting "$FILE"..
  FILE_PNG=${FILE//puml/png}
  cat "$FILE" | docker run --rm -i think/plantuml -tpng > "$FILE_PNG"
done
mv "$BASEDIR"/diagrams/*.png "$BASEDIR"/dist/
echo Done