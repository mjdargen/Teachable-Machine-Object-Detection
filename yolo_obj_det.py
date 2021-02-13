# OpenCV Common Object Detection
#
# Michael D'Argenio
# mjdargen@gmail.com
# https://dargenio.dev
# https://github.com/mjdargen
# Created: February 6, 2020
# Last Modified: February 13, 2021
#
# My program to execute Arun Ponnusamy's OpenCV wrapper for
# a YOLO common object detection model. More info below:
# https://www.arunponnusamy.com/yolo-object-detection-opencv-python.html
# https://github.com/arunponnusamy/object-detection-opencv/

import multiprocessing
import cv2
import cvlib as cv
from cvlib.object_detection import draw_bbox
import pyttsx3


# this process is purely for text-to-speech so it doesn't hang processor
def speak(speakQ, ):
    # initialize text-to-speech object
    engine = pyttsx3.init()
    # can adjust volume if you'd like
    volume = engine.getProperty('volume')
    engine.setProperty('volume', volume+0.25)

    # keeps program running forever until ctrl+c or window is closed
    while True:
        # clear out message and reinit skip
        msg = ""
        skip = 0
        # retrieve all messages
        while not speakQ.empty():
            temp = speakQ.get()
            # if new, break loop and reset because not newest labels
            if '#new#' in temp:
                skip = 1
                break
            # concatenate labels for speech
            msg = msg + ', ' + temp
        # if we aren't skipping, say the labels
        if not skip:
            engine.say(msg)
            engine.runAndWait()


def main():

    # instantiate video capture object
    cap = cv2.VideoCapture(0)
    # creating a queue to share data to speech process
    speakQ = multiprocessing.Queue()
    # creating speech process to not hang processor
    p1 = multiprocessing.Process(target=speak, args=(speakQ, ))
    # starting process 1 - speech
    p1.start()

    # keeps program running forever until ctrl+c or window is closed
    while True:
        # capture image
        _, img = cap.read()
        # use detect common objects model to label objects
        bbox, labels, conf = cv.detect_common_objects(img)
        # draw labels
        img = draw_bbox(img, bbox, labels, conf)
        # send unique string denoting new labels being sent to speech
        speakQ.put('#new#')
        # send each label to text to speech process
        for label in labels:
            speakQ.put(label.lower())
        # display and wait 10ms
        cv2.imshow('my webcam', img)
        cv2.waitKey(10)

    # clean up if you want to remove while loop
    cap.release()
    p1.terminate()
    cv2.destroyAllWindows()


if __name__ == '__main__':
    main()
