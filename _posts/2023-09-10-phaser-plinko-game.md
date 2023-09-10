---
layout: post
title: Plinko game on the Phaser 3 framework
description: Plinko is a kind of gambling game where the small ball falling into one of the buckets randomly.
summary: I implemented working prototype of Plinko game 2 months ago. I used popular phaser 3 framework with built-in physics.
tags: javascript phaser plinko game gambling
---

I designed and implemented [plinko](https://alex-alekseichuk.github.io/projects/plinko/) game 2 months ago.
Plinko is a kind of gambling game.
A small ball is dropping to go through the set of barriers to finish its path in one of the buckets.
It's not a final version and there is no graphics.
On the other hand, the physics looks like real one with the gravity and correct collisions.

I used [phaser](https://phaser.io/) framework.

<div id="plinko-game"></div>

<script src="//cdn.jsdelivr.net/npm/phaser@3.55.1/dist/phaser.js"></script>
<script type="text/javascript">

  const model = {
    nBuckets: 12,

    launch: function() {
      let iBucket;
      while (iBucket === undefined)
        iBucket = this.getRandomBucket();
      return iBucket;
    },
    getRandomBucket: function() {
      const rand = Math.random();
      for (let i = 0; i < this.nBuckets; i++) {
        if (rand <= this.randMax[i]) return i;
      }
    },
    probs: [
      0.0004882,
      0.0053710,
      0.0268554,
      0.0805664,
      0.1611328,
      0.2255859,
      0.2255859,
      0.1611328,
      0.0805664,
      0.0268554,
      0.0053710,
      0.0004882,
    ],
    prizes: [
      136,
      6.4,
      3.2,
      1.6,
      0.6,
      0.3,
      0.3,
      0.6,
      1.6,
      3.2,
      6.4,
      136,
    ],
    init: function() {
      this.randMax = [];
      let accProb = 0;
      this.probs.forEach(prob => {
        this.randMax.push(prob + accProb);
        accProb += prob;
      });
    },
  };

  model.init();

  var config = {
    type: Phaser.AUTO,
    backgroundColor: '#eee',
    parent: 'plinko-game',
    width: 660,
    height: 495,
    scene: {
      preload: preload,
      create: create,
      update: update,
    },
    scale: {
      mode: Phaser.Scale.FIT,
      autoCenter: Phaser.Scale.CENTER_BOTH
    },
    physics: {
      default: 'arcade',
      arcade: {
        gravity: { y: 500 },
        debug: false
      }
    },
  };

  const game = new Phaser.Game(config);

  function preload ()
  {
  }

  const xStart = 0;
  let dx;
  let rb;
  let statics;
  let buckets;
  let dynamics;
  let ball;

  function create ()
  {
    dx = Math.floor(game.config.width / (model.nBuckets * 2 + 2));
    const dy = dx;
    const r = dx / 2 - 3;
    rb = r - 4;

    const yStart = 3 * dy;

    statics = this.physics.add.staticGroup();
    buckets = this.physics.add.staticGroup();
    dynamics = this.physics.add.group();

    for (let iy = 0; iy < model.nBuckets; iy++) {
      const xRowStart = xStart + (model.nBuckets - iy) * dx;
      for (let ix = 0; ix < iy+2; ix++) {
        const x = ix * dx * 2 + xRowStart;
        const y = iy * dy + yStart;
        const circle = this.add.circle(x, y, r, 0x101010);
        circle.bucket = model.nBuckets / 2 - 1 - iy/2 + ix;
        circle.xx = model.nBuckets - 2 - iy + 2*ix;
        circle.yy = iy;
        if (ix > 0) circle.canLeft = true;
        if (ix < iy+1) circle.canRight = true;
        statics.add(circle);
        circle.body.setCircle(r);
      }
    }

    for (let ix = 0; ix < model.nBuckets; ix++) {
      const x = ix * dx * 2 + (2*dx) + xStart;
      const y = model.nBuckets * dy + yStart;
      const bucket = this.add.rectangle(x, y, dx + dx/2, dy, 0x009900);
      bucket.i = ix;
      buckets.add(bucket);
    }

    launch(this);
  }

  function launch(scene) {
    const x = xStart + (model.nBuckets + 1) * dx;
    ball = scene.add.circle(x, 0, rb, 0xEE1010);
    ball.iBucket = model.launch();
    ball.xBucket = 2 * ball.iBucket;
    ball.yBucket = model.nBuckets - 1;
    ball.level = -1;
    console.log(`target bucket: ${ball.iBucket}`);
    dynamics.add(ball);
    ball.body.setCircle(rb);
    ball.body.setBounce(1.0, 0.3);
    ball.body.setCollideWorldBounds(true);

    scene.physics.add.collider(ball, statics, (ball, circle) => {
      if (ball.level < circle.yy) {
        ball.level = circle.yy;
      } else if (ball.level === circle.yy) {
        return;
      } else {
        ball.body.setVelocityY(30);
        return;
      }
      let v;
      let leftRightBoth = 2; // 0,1,2

      const h = ball.yBucket - (circle.yy - 1);
      if (ball.xBucket < circle.xx && circle.xx - ball.xBucket >= h) {
        leftRightBoth = 0;
      }
      if (ball.xBucket > circle.xx && ball.xBucket - circle.xx >= h) {
        leftRightBoth = 1;
      }
      switch (leftRightBoth) {
        case 0:
          v = -30;
          break;
        case 1:
          v = 30;
          break;
        case 2:
          if (Math.abs(ball.x - circle.x) < 10.0)
            v = (Math.random() - 0.5) * 60;
          break;
      }

      console.log(`v: ${v}`);
      if (v)
        ball.body.setVelocityX(v);
    });

    scene.physics.add.collider(ball, buckets, (ball, bucket) => {
      dynamics.remove(ball, true, true);
      console.log(`result bucket: ${bucket.i}`);
      launch(scene);
    });
  }

  function update ()
  {
  }

</script>
