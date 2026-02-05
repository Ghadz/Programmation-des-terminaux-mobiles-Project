import os
from flask import Flask, request, jsonify
from openai import OpenAI

app = Flask(__name__)

# Make sure you set your Hugging Face token in your environment
client = OpenAI(
    base_url="https://router.huggingface.co/v1",
    api_key=os.environ.get("HF_TOKEN"),
)

@app.route("/chat", methods=["POST"])
def chat():
    data = request.json
    user_message = data.get("message", "")
    if not user_message:
        return jsonify({"error": "No message provided"}), 400

    try:
        completion = client.chat.completions.create(
            model="deepseek-ai/DeepSeek-V3:together",
            messages=[
                {
                    "role": "system",
                    "content": (
                        "You are Cosmo, a friendly space exploration assistant. "
                        "You love astronomy, planets, missions, and space facts. "
                        "Keep answers short (2–3 sentences) and fun. Use space emojis sometimes 🚀✨."
                    ),
                },
                {"role": "user", "content": user_message},
            ],
        )
        response_text = completion.choices[0].message["content"]
        return jsonify({"response": response_text})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)
