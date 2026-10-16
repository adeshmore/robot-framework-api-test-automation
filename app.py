from fastapi import FastAPI, HTTPException

app = FastAPI()

devices = [
    {"device_id": "PART1234", "status": "ACTIVE"},
    {"device_id": "PART456", "status": "INACTIVE"},
]


# Retrieve all devices
@app.get("/devices")
def get_all_devices():
    return devices


# Retrieve device by ID
@app.get("/devices/{device_id}")
def get_device(device_id: str):
    for device in devices:
        if device["device_id"] == device_id:
            return device

    raise HTTPException(
        status_code=404,
        detail="Device not found"
    )
