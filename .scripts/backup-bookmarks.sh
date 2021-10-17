cp ~/.config/BraveSoftware/Brave-Browser/Default/Bookmarks ~/.bookmarks/marks
cd ~/.bookmarks || exit

git add .
git commit -m "bookmarks updated"
git push origin main
