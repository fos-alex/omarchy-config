# omarchy-config

My [Omarchy](https://omarchy.org/) configuration (Omarchy 4.0.2).

`main` tracks the **pristine stock configs** copied from the installed
Omarchy version (`/usr/share/omarchy/config/`). Everything I customize lives
on the [`tweaks`](https://github.com/fos-alex/omarchy-config/tree/tweaks)
branch, reviewed through a pull request against `main` — so the PR diff is
exactly my local changes and nothing else.

## Layout

| Path in repo | Live location |
|---|---|
| `hypr/` | `~/.config/hypr/` |
| `omarchy/` | `~/.config/omarchy/` |
| `xkb/` | `~/.config/xkb/` |
| `systemd/user/` | `~/.config/systemd/user/` |
| `local/bin/` | `~/.local/bin/` |

## Syncing

Files are copied (not symlinked). To apply the tweaks branch to a machine:

```bash
git clone https://github.com/fos-alex/omarchy-config
cp -r omarchy-config/hypr/. ~/.config/hypr/
cp -r omarchy-config/omarchy/. ~/.config/omarchy/
cp -r omarchy-config/xkb/. ~/.config/xkb/
cp -p omarchy-config/local/bin/* ~/.local/bin/
cp -p omarchy-config/systemd/user/* ~/.config/systemd/user/
systemctl --user daemon-reload
```

## Extras

### OpenCode usage in the Omarchy agents panel

`local/bin/omarchy-agent-usage-opencode` is a collector for Omarchy's
`omarchy.agents` bar panel. It reports the OpenCode Go subscription limits
(5h / weekly / monthly) from `https://opencode.ai/zen/go/v1/usage` plus local
token stats from opencode's database, as a tab next to Claude/Codex/Fireworks.

`systemd/user/omarchy-agent-usage-opencode.{service,timer}` runs it every
5 minutes and writes the record the panel watches
(`~/.local/state/omarchy/agents/usage/opencode.json`):

```bash
systemctl --user enable --now omarchy-agent-usage-opencode.timer
```

Requires opencode to be connected to OpenCode Go (`/connect` in opencode).

### Voxtype

`systemd/user/voxtype.service` runs the push-to-talk dictation daemon.
