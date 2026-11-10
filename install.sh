#!/bin/sh
# OPSEC DEMON / POINT NEMO installer — user-level only, no root needed.
set -e
cd "$(dirname "$0")"
BIN="$HOME/.local/bin"; SHARE="$HOME/.local/share/point-nemo"; CONF="$HOME/.config/point-nemo"
UNITS="$HOME/.config/systemd/user"

missing=""
for c in python3 ffmpeg ffprobe pacat pw-play notify-send gdbus dbus-monitor systemctl; do
  command -v "$c" >/dev/null 2>&1 || missing="$missing $c"
done
python3 -c "import numpy" 2>/dev/null || missing="$missing python3-numpy"
[ -n "$missing" ] && { echo "missing:$missing"; echo "Debian/Ubuntu: sudo apt install python3-numpy ffmpeg pulseaudio-utils pipewire-bin libnotify-bin libglib2.0-bin dbus-bin"; exit 1; }

mkdir -p "$BIN" "$SHARE/voice" "$SHARE/quotes" "$SHARE/sounds/_default" "$CONF" "$UNITS"
install -m 755 bin/nemo bin/nemo-bus bin/nemo-demo "$BIN/"
cp share/voice/* "$SHARE/voice/"
cp share/quotes/*.txt "$SHARE/quotes/"
cp config/hook.zsh "$CONF/"
cp systemd/*.service "$UNITS/"

# event folders: one symlink per clip, built from event-map.json
python3 - "$SHARE" <<'PY'
import json, os, sys
from pathlib import Path
share = Path(sys.argv[1]); voice = share / "voice"
files = {f.name[:3]: f for f in voice.glob("*.mp3")}
for ev, ids in json.load(open(voice / "event-map.json")).items():
    d = share / "sounds" / ev; d.mkdir(parents=True, exist_ok=True)
    for n in ids:
        f = files[f"{n:03d}"]; link = d / f.name
        if link.is_symlink() or link.exists(): link.unlink()
        link.symlink_to(os.path.relpath(f, d))
print("linked", sum(len(v) for v in json.load(open(voice / "event-map.json")).values()), "clips")
PY

systemctl --user daemon-reload
systemctl --user enable --now point-nemo-bus.service point-nemo.service

cat <<MSG

☢ OPSEC DEMON installed. Test it:   nemo test login     (volume: nemo vol 40)

Optional:
  • shell triggers (sudo, rm -rf, adb, segfaults...):
      echo '[[ -f ~/.config/point-nemo/hook.zsh ]] && source ~/.config/point-nemo/hook.zsh' >> ~/.zshrc
  • Claude Code sounds: merge claude/settings-hooks.json into ~/.claude/settings.json
  • a chime for events without a voice line: drop any mp3 into $SHARE/sounds/_default/
  • system-journal events (sudo-fail, crashes, OOM): sudo usermod -aG systemd-journal \$USER  (then re-login)
MSG
