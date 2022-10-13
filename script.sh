ASSETSFOLDER=assets/timeline

for media in `ls $ASSETSFOLDER | grep .mp4`; do
    # Cut extensions and video resolution
    FILENAME=$(echo $media | sed -n 's/.mp4//p' | sed -n 's/-1920x1080//p')
    INPUT=$ASSETSFOLDER/$media
    FOLDER_TARGET=$ASSETSFOLDER/$FILENAME
    mkdir -p $FOLDER_TARGET

    # create 3 files to each file with different resolution
    OUTPUT=$ASSETSFOLDER/$FILENAME/$FILENAME

    OUTPUT_144=$OUTPUT-144
    OUTPUT_360=$OUTPUT-360
    OUTPUT_720=$OUTPUT-720

    echo 'Rendering in 720p'
    ffmpeg -y -i $INPUT \
        -c:a aac -ac 2 \
        -vcodec h264 -acodec aac \
        -ab 128k \
        -movflags frag_keyframe+empty_moov+default_base_moof \
        -b:v 1500k \
        -maxrate 1500k \
        -bufsize 1000k \
        -vf "scale=-1:720" \
        -v quiet \
        $OUTPUT_720.mp4

    echo 'Rendering in 360p'
    ffmpeg -y -i $INPUT \
        -c:a aac -ac 2 \
        -vcodec h264 -acodec aac \
        -ab 128k \
        -movflags frag_keyframe+empty_moov+default_base_moof \
        -b:v 400k \
        -maxrate 400k \
        -bufsize 400k \
        -vf "scale=-1:360" \
        -v quiet \
        $OUTPUT_360.mp4

    echo 'Rendering in 144p'
    ffmpeg -y -i $INPUT \
        -c:a aac -ac 2 \
        -vcodec h264 -acodec aac \
        -ab 128k \
        -movflags frag_keyframe+empty_moov+default_base_moof \
        -b:v 300k \
        -maxrate 300k \
        -bufsize 300k \
        -vf "scale=256:144" \
        -v quiet \
        $OUTPUT_144.mp4
done
