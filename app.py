from flask import Flask, request, jsonify
from flask_cors import CORS

import torch
torch.set_num_threads(1)
import torch.nn as nn
from torchvision import transforms
from PIL import Image

from timm import create_model

app = Flask(__name__)
CORS(app)

DEVICE = torch.device("cuda" if torch.cuda.is_available() else "cpu")

# CLASS NAMES
classes = [
    "Aphid",
    "Black Rust",
    "Blast",
    "Brown Rust",
    "Common Root Rot",
    "Fusarium Head Blight",
    "Healthy",
    "Leaf Blight",
    "Mildew",
    "Mite",
    "Septoria",
    "Smut",
    "Stem fly",
    "Tan spot",
    "Yellow Rust"
]

# CURE SUGGESTIONS
cures = {
    "Aphid": "Use insecticides and monitor crops regularly.",
    "Black Rust": "Apply fungicide immediately.",
    "Blast": "Use resistant wheat varieties.",
    "Brown Rust": "Spray sulfur-based fungicide.",
    "Common Root Rot": "Improve soil drainage.",
    "Fusarium Head Blight": "Avoid overhead irrigation.",
    "Healthy": "Crop appears healthy.",
    "Leaf Blight": "Remove infected leaves.",
    "Mildew": "Use appropriate fungicide spray.",
    "Mite": "Apply mite control treatment.",
    "Septoria": "Use certified disease-free seeds.",
    "Smut": "Treat seeds before planting.",
    "Stem fly": "Use insect control measures.",
    "Tan spot": "Rotate crops regularly.",
    "Yellow Rust": "Apply rust-resistant fungicides."
}

# MODEL
model = create_model(
    "mobilevit_s",
    pretrained=False,
    num_classes=len(classes)
)

model.load_state_dict(
    torch.load(
        "weights/wheatguard.pth",
        map_location=DEVICE
    )
)

model.to(DEVICE)
model.eval()

# IMAGE TRANSFORM
transform = transforms.Compose([
    transforms.Resize((224, 224)),
    transforms.ToTensor(),
])

@app.route("/")
def home():
    return "WheatGuard Backend Running"

@app.route("/predict", methods=["POST"])
def predict():

    if "image" not in request.files:
        return jsonify({
            "error": "No image uploaded"
        })

    file = request.files["image"]

    try:
        image = Image.open(file).convert("RGB")

    except:
        return jsonify({
            "disease": "Invalid Image",
            "confidence": 0,
            "confidence_label": "Low Confidence",
            "cure": "Please upload a valid image file."
        })

    img = transform(image).unsqueeze(0).to(DEVICE)

    with torch.no_grad():

        outputs = model(img)

        probabilities = torch.softmax(outputs, dim=1)

        confidence, predicted = torch.max(
            probabilities,
            1
        )

    confidence_score = round(
        confidence.item() * 100,
        2
    )

    if confidence_score >= 90:
        confidence_label = "High Confidence"

    elif confidence_score >= 75:
        confidence_label = "Moderate Confidence"

    else:
        confidence_label = "Low Confidence"

    disease = classes[predicted.item()]

    # NOT WHEAT DETECTION
    if confidence_score < 75:

        return jsonify({
            "disease": "Not a Wheat Leaf Image",
            "confidence": confidence_score,
            "confidence_label": "Low Confidence",
            "cure": "Please upload a valid wheat leaf image."
        })

    return jsonify({

        "disease": disease,

        "confidence": confidence_score,

        "confidence_label": confidence_label,

        "cure": cures[disease]
    })

if __name__ == "__main__":
    app.run(debug=True)