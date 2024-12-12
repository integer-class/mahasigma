from fastapi import FastAPI, File, UploadFile
from fastapi.responses import JSONResponse
import uvicorn
import tensorflow as tf
import numpy as np
from PIL import Image
from mtcnn import MTCNN

# Initialize FastAPI
app = FastAPI()

# Load the trained model
model = tf.keras.models.load_model("mobilenet_with_cnn.h5")

# Initialize MTCNN for face detection
mtcnn = MTCNN()

# Define class labels
class_labels = ["blackhead", "eksim", "flek hitam", "herpes", "jerawat", "milia", "Normal","panu", "rosacea", "tineafasialis"]


# Preprocessing function
def preprocess_image(image: Image.Image) -> np.ndarray:
    """
    Preprocess the input image to the format required by the model.
    Args:
        image (Image.Image): Input image.

    Returns:
        np.ndarray: Preprocessed image ready for prediction.
    """
    image = image.resize((224, 224))
    image_array = np.asarray(image) / 255.0  # Normalize to [0, 1]
    image_array = np.expand_dims(image_array, axis=0)  # Add batch dimension
    return image_array


# Face detection and prediction function
def detect_and_predict_faces(image: Image.Image) -> dict:
    """
    Detect faces using MTCNN and predict skin disease for the largest detected face.
    Args:
        image (Image.Image): Input image.

    Returns:
        dict: Predicted class and confidence score.
    """
    image_array = np.asarray(image)
    faces = mtcnn.detect_faces(image_array)

    if not faces:
        return {"error": "No faces detected in the image."}

    # Select the largest detected face
    largest_face = max(faces, key=lambda face: face["box"][2] * face["box"][3])
    x, y, w, h = largest_face["box"]

    # Crop the detected face
    cropped_face = image.crop((x, y, x + w, y + h))

    # Preprocess the cropped face
    preprocessed_face = preprocess_image(cropped_face)

    # Perform prediction
    predictions = model.predict(preprocessed_face)
    predicted_class_index = np.argmax(predictions)
    confidence = float(predictions[0][predicted_class_index])

    return {
        "class": class_labels[predicted_class_index],
        "confidence": confidence
    }


# Endpoint for prediction
@app.post("/predict/")
async def predict(file: UploadFile = File(...)):
    """
    Accepts an image file, detects faces using MTCNN, and predicts the class for the largest face.
    Args:
        file (UploadFile): Uploaded image file.

    Returns:
        dict: Predicted class and confidence score.
    """
    try:
        # Load the image
        image = Image.open(file.file).convert("RGB")

        # Detect and predict
        result = detect_and_predict_faces(image)
        return JSONResponse(content=result)
    except Exception as e:
        return JSONResponse(content={"error": str(e)}, status_code=500)


# Endpoint for checking server status
@app.get("/")
def root():
    """
    Root endpoint to check if the server is running.
    """
    return {"message": "Skin disease classification API with MTCNN is running."}


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
