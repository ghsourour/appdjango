!/bin/bash
GIT_REPO="https://github.com/ghsourour/appdjango.git"
LOCAL_DIR="appdajngo"

echo "clonage du projet"

if [ -d "$LOCAL_DIR" ] ; then
   echo "suppresion du repertoire"
   rm -rf "$LOCAL_DIR"
fi

git clone "$GIT_REPO"  "$LOCAL_DIR" ||  { echo "erreur lors du clonage"; exit 1;}
 
cd "$LOCAL_DIR" || { echo " le dossier n'existe pas"; exit 1 ;}



docker-compose down || true


docker-compose up -d
PORT=8000
MAX_WAIT=50
WAIT=0
while ! curl -s --head "http://localhost:$PORT" | grep "200 OK " > /dev/null ; do
 sleep 4
 if [ $WAIT -ge $MAX_WAIT ] ; then
  echo "erruer : l'app ne repond pas"
  echo "affichier logs"
  docker-compose logs web
  exit 1
 fi 
done
echo "l'app est accesbile depuis http:/localhost:$PORT"
