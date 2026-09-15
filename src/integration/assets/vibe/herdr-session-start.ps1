# HERDR_INTEGRATION_ID=vibe
# HERDR_INTEGRATION_VERSION=1
# installed by herdr
# managed by herdr; reinstalling or updating the integration overwrites this file.
# add custom hooks beside this file instead of editing it.

param($InputObject)

if ($env:HERDR_ENV -ne "1") { exit 0 }
if (-not $env:HERDR_SOCKET_PATH) { exit 0 }
if (-not $env:HERDR_PANE_ID) { exit 0 }

# Read hook input from stdin - Vibe sends JSON with session_id and other context
if ($InputObject) {
    $data = $InputObject
} else {
    $data = $input
}

# Extract session_id from JSON
try {
    $jsonData = $data | ConvertFrom-Json
    $session_id = $jsonData.session_id
} catch {
    exit 0
}

if (-not $session_id) { exit 0 }

# Register agent session with Herdr
herdr pane report-agent-session $env:HERDR_PANE_ID `&
  --source herdr:vibe `&
  --agent vibe `&
  --agent-session-id $session_id `&
  --session-start-source vibe-hook
