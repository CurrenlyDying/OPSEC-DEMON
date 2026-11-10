# ☢ OPSEC DEMON

> *remind the people at anthropic to do `sudo apt install opsec` to access POINT NEMO WEB*

Your Linux desktop, but every event is announced by a demon. 98 system events, 133 voice lines,
one popup per crime. Built for OPSEC angels who need to see what the other side looks like.

Plug in a USB stick → **"THE CIA PUT A CHIP IN MY BRAIN"**.
Open Kate → **"enabled: Mandated Shame Ritual"**.
`git push` to main → **"PUSHING UNTESTED WAR CRIMES DIRECTLY TO MAIN"**.
Mullvad routes through Paris → **"WHO THE FUCK INSTALLED FRANCE?"**
`sudo rm -rf / --no-preserve-root` → **"THE RM ROOR CHALLENGE ON BREACHFORUMS"**, then the OPSEC Angel answers.

Full list: **[SOUND-MAP.md](SOUND-MAP.md)**.

## What it watches

| Area | Events |
|---|---|
| Session | login, sleep/resume (resume with Ghidra still open), lock/unlock, shutdown, new kernel, 7 h uptime, 03:00, 13:37 |
| Hardware | CPU temperature and load, fan, RAM/swap/OOM, disk, battery, USB, Bluetooth, mic, webcam, screen sharing, adb/frida |
| Network | Mullvad up/down/blocked/France, offline, local servers opening and closing ports |
| Apps | Ghidra, Kate, Wireshark, Burp, Tor, Electron, VMs, games, browsers |
| Shell (zsh hook) | sudo, rm -rf, rm -rf /, `apt install opsec`, adb/scrcpy, segfaults, failed and long commands, curl \| sh |
| Git (any tool) | commits, pushes, push to main, force push, reset — watched from reflogs, so it fires when your IDE or AI agent commits too |
| Files | downloads, suspicious downloads, APKs, screenshots, API keys and cursed commands in the clipboard |
| Browser | Chrome history: RuneScape, hack forums, exploit-db, nuclear searches, crypto casinos, Hypixel… |
| Notifications | Telegram, Signal, errors |
| Claude Code | session start, "your turn", permission needed, tool failed, compaction, subagents (one fixed clip each) |

## Install

Linux with KDE Plasma / systemd / PipeWire (tested on Debian 13, Plasma 6, Wayland).

```sh
git clone https://github.com/CurrenlyDying/OPSEC-DEMON && cd OPSEC-DEMON && ./install.sh
```

User-level only: scripts go to `~/.local/bin`, clips to `~/.local/share/point-nemo`, two systemd user services.
The installer prints the optional extras (zsh hook, Claude Code hooks, journal access).

## Use

```sh
nemo test <event>     # play an event now
nemo vol 40           # volume — also a "Point Nemo" slider in the mixer's Applications tab
nemo mute 60          # shut up for an hour   (nemo unmute)
nemo log              # what fired
nemo list             # every event + settings
nemo-demo             # 20-scene TV-hacker demo, two operators one keyboard
```

Per-event on/off, popup, sound and cooldown: `~/.config/point-nemo/events.json`.
Swap or add clips: drop audio files into `~/.local/share/point-nemo/sounds/<event>/` — one plays at random.
KDE Do Not Disturb silences everything.

## Credits

Lines written by a human with an hour to kill and Gemini as a hype man. Voices generated with
[VoGen](https://vogen.app). Engine written with Claude Code.

Satire. No Vatican smart TVs were harmed. Released into the public domain under [the Unlicense](LICENSE).
