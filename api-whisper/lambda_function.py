import whisper
import base64
import json
import os

model = whisper.load_model(name="base", download_root="./")

file_path = '/tmp/audio.mp3'

def lambda_handler(event, context):

    base64_audio = event['body']
    # print(os.listdir('/tmp'))
    decode_base64_to_audio(base64_audio, file_path)
    result = model.transcribe(file_path, language="en", fp16=False)
    os.remove(file_path)

    data = {
        'text': result["text"],
    }
    
    return {
        'statusCode': 200,
        'body': json.dumps(data),
    }

def decode_base64_to_audio(encoded_data, output_file_path):
    decoded_audio = base64.b64decode(encoded_data)
    with open(output_file_path, "wb") as audio_file:
        audio_file.write(decoded_audio)