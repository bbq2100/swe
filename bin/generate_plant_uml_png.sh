#!/bin/bash
# converts all puml files to png

echo "Generating Plantuml Diagrams"

BASEDIR=$(dirname "$0")
mkdir -p "$BASEDIR"/dist
rm "$BASEDIR"/dist/* > /dev/null
for FILE in "$BASEDIR"/diagrams/*.puml; do
  echo Converting "$FILE"..
  FILE_PNG=${FILE//puml/png}
  docker run --rm -i think/plantuml -tpng < "$FILE" > "$BASEDIR/dist/$(basename "$FILE_PNG")" &
done
echo "Done. Generated diagrams are located in ./bin/dist"