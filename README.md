
# Dockerized OpenCV Camera Feed Application

This project demonstrates how to run a Python OpenCV application in a Docker container that captures video from your camera and displays it in a GUI window.

## Requirements

- **Docker**: Make sure Docker is installed on your machine. You can install it from [Docker's official website](https://docs.docker.com/get-docker/).

## Project Structure

- **`app.py`**: The main Python script that captures video from the camera and displays it.
- **`Dockerfile`**: The Docker configuration file to set up the container with OpenCV and its dependencies.
- **`requirements.txt`**: Lists the Python dependencies for the project.

## Installation and Setup

1. Clone this repository or download the project files.

2. Make sure the following files are in the project directory:
   - `app.py`
   - `Dockerfile`
   - `requirements.txt`

### `app.py`

The `app.py` script uses OpenCV to capture and display video frames from your camera:

```python
import cv2

def capture_video():
    # Open the default camera
    cap = cv2.VideoCapture(0)
    
    if not cap.isOpened():
        print("Error: Could not open camera.")
        return

    while True:
        ret, frame = cap.read()
        if not ret:
            print("Error: Failed to capture frame.")
            break

        # Display the frame
        cv2.imshow("Camera Feed", frame)

        # Press 'q' to exit the loop
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    cap.release()
    cv2.destroyAllWindows()

if __name__ == "__main__":
    capture_video()
```
## requirements.txt

Add opencv-python as the dependency in requirements.txt:

```
opencv-python
```
## Build the Docker Image
In the directory where Dockerfile, app.py, and requirements.txt are located, build the Docker image with the following command:

```
docker build -t opencv-camera .
```
This will create an image named opencv-camera.

## Running the Docker Container
Option 1: Running with Direct Display Access (X11)
For machines with a display, use the following command to allow Docker to access the host's display:

bash
Copy code
# Allow Docker to access the display (Linux)
xhost +local:docker

# Run the Docker container with display access
```
sudo docker run --restart=always -it -e DISPLAY=$DISPLAY -v /home:/home -v /media:/media -v /dev:/dev --network=host --volume /tmp/.X11-unix:/tmp/.X11-unix --privileged opencv-camera
```
--device /dev/video0:/dev/video0: Allows the container to access your camera.
-e DISPLAY=$DISPLAY: Passes the display environment variable from the host to the container.
--volume /tmp/.X11-unix:/tmp/.X11-unix: Shares the X11 socket with the container.
Note: Remember to revoke display access after running the container with:

## Usage
Once the Docker container is running, it will open a window displaying the camera feed. To stop the application, press q while the video feed window is active.

## Troubleshooting
Error: Could not connect to display
If you encounter this error, make sure that X11 forwarding or Xvfb setup is correct based on the options above.

## Permission Issues with /dev/video0
Ensure that the Docker user has permission to access the camera. You may need to add your user to the video group on Linux (sudo usermod -aG video $USER) and restart the session.

## License
This project is licensed under the MIT License.

---

This `README.md` provides setup instructions, running options, and troubleshooting tips, 
