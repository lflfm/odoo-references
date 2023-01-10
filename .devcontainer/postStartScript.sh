#!/bin/bash
find . -type f -not -path '*/.git/*' -exec sudo dos2unix {} 2>/dev/null \; || true
chmod ug+x /home/vscode/**.sh