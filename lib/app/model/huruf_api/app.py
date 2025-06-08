from fastapi import FastAPI, Request, HTTPException
from fastapi.responses import JSONResponse
import numpy as np
from deteksi_huruf import load_model, predict_single_sample_log
from typing import List, Dict, Any

app = FastAPI()

# Load model once at startup
means, variances, p, classes = load_model()

@app.post('/predict')
async def predict(request: Request):
    try:
        # Parse JSON data from request
        data = await request.json()
        pixels = data.get("pixels", [])
        
        # Validate input
        if not pixels or len(pixels) != 784:
            raise HTTPException(status_code=400, detail="Data tidak valid. Harus ada 784 pixel values")
        
        # Process image
        sample = np.array(pixels, dtype=np.float64)
        sample = sample / 255.0
        sample[sample == 0] = 1e-12
        
        # Make prediction
        probs = predict_single_sample_log(sample, means, variances, p, classes)
        pred_index = np.argmax(probs)
        pred_char = classes[pred_index]
        
        return {
            "prediction": pred_char,
            "probabilities": probs.tolist()
        }
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))