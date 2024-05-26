---
layout: post
title: Arduino Sketch for ESP32 controller for unlock by SMS project.
description: Arduino Sketch for ESP32 controller for unlock by SMS project.
summary: There was a project for auto-selling and unlock items by SMS. I've designed electronic schema based on ESP32 and implemented Arduino Sketch to control it.
tags: esp32 microcontroller arduino electronics
---

There is a list of secret codes hardcoded into ESP32 controller.
When user buy an item, the system (another one) send him one of the codes.
User enters the code by 16-buttons keyboard.
The controller checks the code exists and not used yet,
then unlock an item from the stack for the user.
It uses the relay.

![schema](/assets/images/2024-05-26-schema.png)

I used [wokwi](https://wokwi.com/) online service and Arduino IDE.

Here is the [Source code](https://github.com/alex-alekseichuk/sms-lock/blob/main/controller.ino).
