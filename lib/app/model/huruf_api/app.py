from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import numpy as np
from deteksi_huruf import load_model, predict_single_sample_log, min_max_scaling

app = FastAPI()

# Load model once at startup
means, variances, p, classes = load_model()

# Pydantic model for input validation
class PixelInput(BaseModel):
    pixels: list[float]

@app.get("/")
def root():
    return {"message": "API deteksi huruf kapital aktif."}

@app.post("/predict")
async def predict(data: PixelInput):
    if len(data.pixels) != 784:
        raise HTTPException(status_code=400, detail="Data tidak valid. Harus ada 784 nilai pixel.")

    try:
        # Preprocess image
        sample = np.array(data.pixels)  
        sample = sample / 255.0

        # Predict
        probs = predict_single_sample_log(sample, means, variances, p, classes)  
        pred_index = np.argmax(probs)
        pred_char = classes[pred_index]

        return {
            "prediction": pred_char,
            "probabilities": probs.tolist()
        } 

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Terjadi kesalahan: {str(e)}")
