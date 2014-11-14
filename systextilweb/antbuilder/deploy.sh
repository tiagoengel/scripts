#!/bin/bash

MODULO="$1"

if [ -L "$0" ]; then 
   BASE_DIR="$(dirname $(readlink $0))";
else
   BASE_DIR="$(dirname $0)"; 
fi 

if [ "$MODULO" == "systextil" ]; then
   MODULO_XML="$BASE_DIR"/antsystextil
else
   MODULO_XML="$BASE_DIR"/antmodulo 
fi

if [ ! -f "$MODULO_XML"/build.xml ]; then
  echo "Arquivo $MODULO_XML/build.xml não encontrado.";  
  exit 1;
fi

cd "$MODULO_XML"

ant -DnomeModulo="$MODULO" deploy

# Touch web.xml to force redeploy
echo "Forcing redeploy..."
touch /usr/local/share/systextilweb/jboss-4.2.3.GA/server/default/deploy/systextil.ear/NxjWebApp.war/WEB-INF/web.xml




