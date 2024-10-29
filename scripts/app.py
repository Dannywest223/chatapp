from flask import Flask, request, jsonify
from flask_cors import CORS
from transformers import pipeline

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

# Load the model (you can specify a model of your choice)
chat_model = pipeline('conversational', model='microsoft/DialoGPT-medium')

@app.route('/chat', methods=['POST'])
def chat():
    data = request.json
    user_input = data.get('message', '')
    response = chat_model(user_input)
    return jsonify({'response': response[-1]['generated_text']})

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
