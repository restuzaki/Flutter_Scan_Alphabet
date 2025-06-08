from fastapi import FastAPI, Request
import numpy as np
from model import load_model, predict_single_sample_log


app = FastAPI()

means, variances, p, classes = load_model()

@app.post("/predict")
async def predict(request: Request):
    data = await request.json()
    pixels = data.get("pixels", [])
    if not pixels or len(pixels) != 784:
        return {"error": "Data tidak valid"}
    sample = np.array(pixels)
    sample = sample / 255
    sample[sample == 0] = 1e-12
    probs = predict_single_sample_log(sample, means, variances, p, classes)
    pred_index = np.argmax(probs)
    pred_char = classes[pred_index]
    return {
        "prediction": pred_char,
        "probabilities": probs.tolist()
    }
