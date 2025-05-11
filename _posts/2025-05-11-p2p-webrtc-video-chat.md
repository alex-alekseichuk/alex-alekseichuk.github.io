---
layout: post
title: P2P Video Chat based on WebRTC
description: I implemented a solution for P2P video chat in browser.
summary: All modern communication systems support video calls in their web clients. I implemented similar for P2P calls of 2 clients
tags: webrtc javascript node.js websocket video chat
---

I've implemented the solution for P2P web video calls.
Two clients open the same web page and video call session starts automatically.

[https://github.com/alex-alekseichuk/p2p-webrtc-video-chat](https://github.com/alex-alekseichuk/p2p-webrtc-video-chat)

It's based on WebRTC and signaling via node.js websocket server.

There are only 2 clients can communicate with each other.
To have more parties in terms of the same call it needs some other approach to stream the video to/from.

I tested it in Chrome and Firefox under Linux and Windows.
