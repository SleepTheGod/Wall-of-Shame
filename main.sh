#!/bin/bash

# Ensure the script is run with root privileges (needed for journalctl and web root access)
if [ "$EUID" -ne 0 ]; then
  echo "[-] Please run as root (sudo ./wall_of_shame.sh)"
  exit 1
fi

HTML_FILE="/var/www/html/wallofshame.html"

echo "[+] Starting Wall of Shame generator loop..."
echo "[+] Deploying to: $HTML_FILE"
echo "[+] Press Ctrl+C to stop the background process."

# Continuous update loop
while true; do
  cat << 'EOF' > "$HTML_FILE"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>THE WALL OF SHAME</title>
    <meta http-equiv="refresh" content="3">
    <style>
        body { 
            background-color: #000000; 
            color: #ff2a2a; 
            font-family: "Courier New", Courier, monospace; 
            padding: 40px; 
        }
        h1 { 
            color: #ffffff; 
            text-align: center; 
            text-shadow: 0 0 10px #ffffff, 0 0 20px #ff0000; 
            font-size: 2.2em; 
            border-bottom: 2px dashed #ff2a2a; 
            padding-bottom: 20px; 
        }
        .subtitle { 
            text-align: center; 
            color: #888888; 
            margin-bottom: 30px; 
            font-size: 0.9em; 
        }
        pre { 
            background-color: #050505; 
            border: 1px solid #ff2a2a; 
            padding: 20px; 
            width: fit-content; 
            margin: 0 auto; 
            box-shadow: 0 0 15px rgba(255, 0, 0, 0.3); 
            font-size: 1.2em; 
            line-height: 1.5; 
        }
        .glow { 
            animation: pulse 1.5s infinite alternate; 
        }
        @keyframes pulse { 
            0% { opacity: 0.8; text-shadow: 0 0 5px #ff0000; } 
            100% { opacity: 1; text-shadow: 0 0 15px #ff0000, 0 0 25px #ff2a2a; } 
        }
    </style>
</head>
<body>
    <h1>=== [ THE WALL OF SHAME: TOP SSH ATTACKERS ] ===</h1>
    <div class="subtitle">Auto-refreshing live matrix feed. Updates every 3 seconds.</div>
    <pre class="glow">
EOF

  # Gather stats and safely escape output for HTML display
  journalctl -u ssh --no-pager | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | sort | uniq -c | sort -nr | head -n 25 | sed 's/&/&amp;/g; s/</&lt;/g; s/>/&gt;/g' >> "$HTML_FILE"

  cat << 'EOF' >> "$HTML_FILE"
    </pre>
</body>
</html>
EOF

  sleep 3
done
