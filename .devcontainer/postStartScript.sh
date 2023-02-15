#!/bin/bash
sudo chown -R $USER:$USER /workspaces
find . -type f -not -path '*/.git/*' -exec dos2unix {} 2>/dev/null \; || true
chmod ug+x /home/vscode/**.sh
chmod ug+x /workspaces/.devcontainer/**.sh
