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

# create new idf project from espressif template
idf_create_project(){
  IDF_TEMPLATE_PATH=$IDF_PATH/esp-idf-template/
  PROJECT_PATH="$(pwd)/$1"
  [ ! -d $IDF_TEMPLATE_PATH ] && git clone git@github.com:espressif/esp-idf-template.git $IDF_TEMPLATE_PATH
  cp -r $IDF_TEMPLATE_PATH $PROJECT_PATH
  sed -i "s/app-template/$1/g" $PROJECT_PATH/Makefile
  [ -d $PROJECT_PATH/.git ] && rm -rf $PROJECT_PATH/.git
  touch $PROJECT_PATH/README.md && truncate -s 0 $PROJECT_PATH/README.md
  echo "# $1 - ESP IDF PROJECT " >> $PROJECT_PATH/README.md
  cd $PROJECT_PATH
  git init
  mkdir components
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

# print_software_license_info(){
#    #TBD
# }

# FZF MAGIC
gco(){
  git checkout $(git branch | fzf)
}

prockill(){
  sudo kill -9 $(ps aux | fzf | awk '{print $2}')
}
