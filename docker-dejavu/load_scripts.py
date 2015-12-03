import warnings
import json
import os
import time
warnings.filterwarnings("ignore")

from dejavu import Dejavu
from dejavu.recognize import FileRecognizer, MicrophoneRecognizer

# load config from a JSON file (or anything outputting a python dictionary)
with open("dejavu.cnf") as f:
    config = json.load(f)

if __name__ == '__main__':

        # create a Dejavu instance
        config["database"]["passwd"] = os.environ.get(config["database"]["passwd"])
        config["database"]["db"] = os.environ.get(config["database"]["db"])
	djv = ""
	for i in range(0, 20):
		try:
		        djv = Dejavu(config)
			break
		except Exception,e:
			print e
			time.sleep(1)

	# Fingerprint all the mp3's in the directory we give it
        djv.fingerprint_directory("scripts", [".wav"])
