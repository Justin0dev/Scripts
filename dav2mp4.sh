#!/bin/sh

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    echo "ffmpeg could not be found. Please install it and try again."
    exit 1
fi

# Convert each .dav file to .mp4
for file in *.dav; do
    # Extract the filename without the extension
    filename=$(basename -- "$file")
    base="${filename%.*}"

    # Convert the file using ffmpeg
    echo "Converting $file to $base.mp4..."
    ffmpeg -y -i "$file" -vcodec libx264 -crf 24 -filter:v "setpts=1*PTS" "$base.mp4"
done

echo "Conversion complete."
