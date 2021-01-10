#!/usr/bin/zsh

ingore_patterns=('node_modules' 'tmp' 'cache')

syncdev(){
  if [[ -v $1 && -v $1 ]]
  then
    echo "Invalid Command"
  else
    rsync -a --info=progress2 --exclude $ingore_patterns --info=name0 $1 $2 2>/home/sreedev/data/devarch_sync.log
  fi
}

remote_server='sreedev@devarch:/home/sreedev/data'
local_fs='/home/sreedev/data'

echo "synchronizing backups"
syncdev "$local_fs/backups/" "${remote_server}/devstation-remote/backups/"

echo "synchronizing official"
syncdev "$local_fs/tarkalabs/" "${remote_server}/devstation-remote/tarkalabs/"

echo "synchronizing repositories"
syncdev "$local_fs/repositories/" "${remote_server}/devstation-remote/repositories"

echo "synchronizing books"
syncdev "$local_fs/books/" "${remote_server}/devstation-remote/books"

echo "synchronizing projects"
syncdev "$local_fs/projects/" "${remote_server}/devstation-remote/projects"

echo "synchronizing resources"
syncdev "$local_fs/resources/" "${remote_server}/devstation-remote/resources"

echo "synchronizing labz"
syncdev "$local_fs/labz/" "${remote_server}/devstation-remote/labz"


