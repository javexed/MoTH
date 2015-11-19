#!/bin/bash
find /recordings/*.wav -exec python dejavu.py --recognize file {} \;
