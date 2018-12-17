#!/usr/bin/python3
import pyautogui
import time
import datetime

coords = None

print('Waiting for patcher to finish')

while coords == None:
    time.sleep(10)
    print(str(datetime.datetime.now()))
    coords = pyautogui.locateCenterOnScreen('launcher/launch_done.png')

print('Patching done')
