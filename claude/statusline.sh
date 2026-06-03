#!/usr/bin/env bash
# Claude Code statusline — single line:
#   [Model] ctx: <ctx%>  5h: <5h%>  7d: <7d%>  rst: <5h reset left>|<7d reset left>
#   ctx = context-window usage, 5h/7d = plan window usage, rst = time until each resets
# Fields come from the JSON Claude Code pipes to this command on stdin.
# Plan windows (rate_limits) only appear for Claude.ai Pro/Max sessions and
# after the first API response; context % is null until the first response too.
# Missing/null values render as "--".
# Colors: model dark grey; each label its own color; values stay default.

input=$(cat)
now=$(date +%s)

# ANSI colors (escape vars hold real ESC bytes; printed literally as %s args).
RESET=$'\033[0m'
GREY=$'\033[90m'   # model
C_CTX=$'\033[36m'  # ctx: cyan
C_5H=$'\033[32m'   # 5h:  green
C_7D=$'\033[33m'   # 7d:  yellow
C_RST=$'\033[35m'  # rst: magenta

# Model display name, compacted: "Opus 4.8 (1M context)" -> "Opus 4.8 1M".
model=$(printf '%s' "$input" | jq -r '
  (.model.display_name // .model.id // "?") | gsub(" context";"") | gsub("[()]";"")')

# jq emits 5 space-separated tokens: ctx% 5h% 7d% 5h-hours-left 7d-hours-left.
# Percentages are floored ints or "-"; hours-left are raw floats (>=0) or "-".
read -r ctx five week r5 rw <<EOF
$(printf '%s' "$input" | jq -r --argjson now "$now" '
  def pct: if . == null then "-" else (.|floor|tostring) end;
  def hrs: if . == null then "-" else (((. - $now) / 3600) | (if . < 0 then 0 else . end) | tostring) end;
  [ (.context_window.used_percentage          | pct),
    (.rate_limits.five_hour.used_percentage    | pct),
    (.rate_limits.seven_day.used_percentage    | pct),
    (.rate_limits.five_hour.resets_at          | hrs),
    (.rate_limits.seven_day.resets_at          | hrs)
  ] | join(" ")')
EOF

fmt_pct() { if [ "$1" = "-" ]; then printf -- '--'; else printf '%s%%' "$1"; fi; }
fmt_hrs() { if [ "$1" = "-" ]; then printf -- '--'; else printf '%.1fh' "$1"; fi; }

printf '%s[%s]%s %sctx:%s %s %s5h:%s %s %s7d:%s %s %srst:%s %s|%s' \
  "$GREY" "$model" "$RESET" \
  "$C_CTX" "$RESET" "$(fmt_pct "$ctx")" \
  "$C_5H" "$RESET" "$(fmt_pct "$five")" \
  "$C_7D" "$RESET" "$(fmt_pct "$week")" \
  "$C_RST" "$RESET" "$(fmt_hrs "$r5")" "$(fmt_hrs "$rw")"
