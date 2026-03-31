#!/bin/bash

# Ensure we are in the actual runners directory regardless of where called
cd "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create/Overwrite the 'current' symlink
# Usage: Change the first path to your desired Proton version
ln -sfn ./GE-Proton10-34 ./current

echo "Runner updated to: $(readlink current)"
