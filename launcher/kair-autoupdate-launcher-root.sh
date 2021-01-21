#!/bin/bash
sleep 1

# tmux session name
session_name="kair"

#Delete Cache
sudo rm -r /root/.cache
sudo rm -r /root/.netease-musicbox
sudo rm -r /root/userInfo
sleep 1

#Update kair-robot
cd $HOME/kair
git pull

#Update kair Requirements
sudo pip install --upgrade -r client/requirements.txt
sleep 1

#Update kair-contrib
cd $HOME/.kair/contrib
git pull

#Update kair-contrib Requirements
sudo pip install --upgrade -r requirements.txt
sleep 1

#Restore Configuration of AlsaMixer
if [ -f $HOME/asound.state ]; then
    alsactl --file=$HOME/asound.state restore
    sleep 1
fi

#Launch kair in tmux
sudo tmux new-session -d -s $session_name $HOME/kair/kair.py
sleep 1

#Start Respeaker-Switcher in Background
if [ -d $HOME/ReSpeaker-Switcher ]; then
    sudo python $HOME/ReSpeaker-Switcher/switcher.py &
fi

cd $HOME/kair
