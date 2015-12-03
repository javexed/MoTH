import time
import sys

import stomp
import os

class MyListener(stomp.ConnectionListener):
    def on_error(self, headers, message):
        print('received an error "%s"' % message)
    def on_message(self, headers, message):
        print('received a message "%s"' % message)
        os.system('python dejavu.py --recognize file /recordings/' + message)

conn = stomp.Connection([('STOMP_SERVER',61613)])
conn.set_listener('', MyListener())
conn.start()
conn.connect(wait=True)

conn.subscribe(destination='/queue/fingerprint', id=1, ack='auto')

#conn.send(body=' '.join(sys.argv[1:]), destination='/queue/test')
try:
    while True:
        time.sleep(10)
        if not conn.is_connected():
            break
except KeyboardInterrupt:
    conn.stop()

conn.disconnect()
