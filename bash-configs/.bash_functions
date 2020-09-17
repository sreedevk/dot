# disable wifi automatic transmission power management to avoid issues with linux kernel 5.4
disable_wifi_powerman() {
  if [ -z "$1" ]
  then
    WIFI_IFX=$1
  else
    WIFI_IFX="$(ip link show | grep 'wlp\|wlan' | sed 's/\://g' | awk '{print $2}')"
  fi
  sudo iwconfig $WIFI_IFX power off
  unset WIFI_IFX
}

# move files to trash instead of removing
trash(){
  mv $1 ~/.trash/
}

# generate app from template
create_app(){
  # template sources
  templates_container="$HOME/app_templates"
  declare -A template_remote_source
  template_remote_source[svelte]="git@github.com:sveltejs/template.git"
  template_remote_source[esp]="git@github.com:espressif/esp-idf-template.git"

  # app specific inputs
  app_stack=$1
  app_name=$2
  local_app_path="$(pwd)/$app_name"

  # clone template repo locally
  local_template_path="$templates_container/${app_stack}_template"
  [ ! -d "$templates_container" ] && mkdir $templates_container
  [ ! -d "$app_template_path" ] && git clone $template_remote_source[$app_stack] "$local_template_path"

  # copy template to current directory
  cp -r $local_template_path $local_app_path

  # post processing
  rm -rf $local_app_path/.git
  git init $local_app_path
}

# create new idf project from espressif template
create_idf_app(){
  idf_app_path="$(pwd)/$1"
  create_app esp $1
  sed -i "s/app-template/$1/g" "$idf_app_path/Makefile"
  mkdir "$idf_app_path/components"
}

# svelte app
create_svelte_app(){
  create_app svelte $1
}

# print formatted csv output
csv() {
  column -s, -t < $1 | less -#2 -N -S
}

# brightness for intel backlight
set_brightness(){
  sudo echo $1 > /sys/class/backlight/intel_backlight/brightness
}

pisync(){
  PI_REMOTE_PATH="pi@rpi0w:/home/pi/remote/"
  PI_LOCAL_PATH="/home/sreedev/data/remote-rpi0w/"
  [ ! -z "$1" ] && PI_LOCAL_PATH="$1"
  [ ! -z "$2" ] && PI_REMOTE_PATH="$2"
  rsync -av --progress $PI_LOCAL_PATH $PI_REMOTE_PATH --delete
}

aws_instances() {
  AWS_FILTER="*"
  OUTPUT_TYPE="table"
  [ ! -z "$1" ] && AWS_FILTER="*$1*"
  [ ! -z "$2" ] && OUTPUT_TYPE="$2"
  aws ec2 describe-instances\
    --query "Reservations[*].Instances[*].{InstanceID:InstanceId,PrivateIP:PrivateIpAddress,PublicIPAddr:PublicIp,Instance:Tags[?Key=='Name']|[0].Value}"\
    --filter "Name=tag:Name,Values=$AWS_FILTER"\
    --output "$OUTPUT_TYPE" 
}


# FZF MAGIC
gco(){
  git checkout $(git branch | fzf)
}

prockill(){
  sudo kill -9 $(ps aux | fzf | awk '{print $2}')
}

# zsh plugin update - antibody
antibody_compile(){
  antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh
}



