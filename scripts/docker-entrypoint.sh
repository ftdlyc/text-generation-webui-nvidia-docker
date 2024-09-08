#!/bin/bash

# Runtime extension build
if [[ -n "$BUILD_EXTENSIONS_LIVE" ]]; then
  eval "live_extensions=($BUILD_EXTENSIONS_LIVE)"
  . /scripts/extensions_runtime_rebuild.sh $live_extensions
fi

# Print variant
VARIANT=$(cat /variant.txt)
echo "=== Running text-generation-webui variant: '$VARIANT' ===" 

# Assemble CMD and extra launch args
eval "extra_launch_args=($EXTRA_LAUNCH_ARGS)"
LAUNCHER=($@ ${extra_launch_args[@]})

# Launch the server with ${CMD[@]} + ${EXTRA_LAUNCH_ARGS[@]}
exec "${LAUNCHER[@]}"
