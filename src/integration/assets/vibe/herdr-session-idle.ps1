# HERDR_INTEGRATION_ID=vibe
# HERDR_INTEGRATION_VERSION=1
# installed by herdr
# managed by herdr; reinstalling or updating the integration overwrites this file.
# add custom hooks beside this file instead of editing it.

if ($env:HERDR_ENV -ne "1") { exit 0 }
if (-not $env:HERDR_SOCKET_PATH) { exit 0 }
if (-not $env:HERDR_PANE_ID) { exit 0 }

# Report idle state after agent turn completes
herdr pane report-agent $env:HERDR_PANE_ID `&
  --source herdr:vibe `&
  --agent vibe `&
  --state idle
